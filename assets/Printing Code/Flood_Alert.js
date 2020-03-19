const https = require('http');
var AWS = require('aws-sdk');
const timeToDelay = 15000;
var lowDanger = 15;
var mediumDanger = 20;
var highDanger = 30;
let message = "";
let title = "";
let messageAlert = "none";
let previousMessageAlert = "none";

// Alert: none -> no danger
//         low -> low danger
//         medium -> mediumDanger
//         high -> highDanger

exports.handler = (event, context, callback) => {

    console.log("previous message alert" + typeof previousMessageAlert)

    //merging code here 
    var locationId = event['locationId']
    var currentWaterLevel = parseFloat(event['waterLevel'])
    var address = event.address
    //console.log("type of "+ typeof address)
    var newAddress = address.replace(/_/gi, " ")
    //console.log('This stupid address is ' + newAddress)
    AWS.config.update({ region: 'us-east-1' });
    // Create the DynamoDB service object
    var ddb = new AWS.DynamoDB({ apiVersion: '2012-08-10' });
    var currentTime = Date.now()

    let dateTimeItem = null
    let waterLevel = null

    var getItem = {
        TableName: 'floodTime',
        Key: {
            'id': { S: locationId }
        },
        ProjectionExpression: 'previoustime,waterLevel,previousalert'//get attributes from the dynamodb 
    };
    //this database is to prevent spamming of notificaions from the 
    // Call DynamoDB to read the item from the table
    ddb.getItem(getItem, function (err, data) {
        if (err) {
            console.log("Error", err);
        } else {
            console.log("SuccessGettingItem", data.Item);
            previousMessageAlert = data.Item['previousalert']['S'];
            dateTimeItem = data.Item['previoustime']['S'];
            waterLevel = data.Item['waterLevel']['S'];


            var previousTime = parseFloat(dateTimeItem)


            //console.log("type of currentTime :" + typeof currentTime)
            //Use the new address for printing address without the underscore
            if (currentWaterLevel <= lowDanger) {
                messageAlert = "none"
                previousMessageAlert = "none"
                var noneParams = {
                    TableName: 'floodTime',
                    Item: {
                        'id': { S: locationId },
                        'previoustime': { S: dateTimeItem.toString() }, //set back the original values
                        'waterLevel': { S: waterLevel.toString() }, //set back the original values
                        'previousalert': { S: 'none' }//set previous Message Back to none
                    }
                };
                console.log("none detected putting items back in the database")
                //put the item back to the database
                ddb.putItem(noneParams, function (err, data) {
                    if (err) {
                        console.log("none:Error", err);
                    } else {
                        console.log("none:Success", data);
                    }
                });

                return;
            } else if (currentWaterLevel <= mediumDanger) {
                title = "Low Alert"
                message = "At " + newAddress + " with a water level of " + currentWaterLevel.toString() + "cm"
                messageAlert = "low"

            } else if (currentWaterLevel <= highDanger) {
                title = "Medium Alert:Evacuate!"
                message = "At " + newAddress + " with a water level of " + currentWaterLevel.toString() + "cm"
                messageAlert = "medium"
            } else {
                title = "High Alert:Evacuate!"
                message = "At " + newAddress + " with a water level of " + currentWaterLevel.toString() + "cm"
                messageAlert = "high"
            }






            //should do Message Alert Checking here
            if (previousMessageAlert == messageAlert) {
                return
            }



            //if(currentTime - previousTime <= timeToDelay){
            //  return;
            //}else{

            //checking fore previous water level
            var previousWaterLevel = parseFloat(waterLevel)
            if (currentWaterLevel == previousWaterLevel) {
                return;
            }

            //setPreviousAlertWith the table
            //Time to put Item here man and check notifications here
            //updating the time in the dynamodb table
            var params = {
                TableName: 'floodTime',
                Item: {
                    'id': { S: locationId },
                    'previoustime': { S: currentTime.toString() },
                    'waterLevel': { S: currentWaterLevel.toString() },
                    'previousalert': { S: messageAlert } //set the current message alert as the previous message alert
                }
            };

            ddb.putItem(params, function (err, data) {
                if (err) {
                    console.log("database :Error", err);
                } else {
                    console.log("database :Success", data);
                }
            });

            console.log("Sending alert with " + title + message.toString() + "messageAlert:" + messageAlert);
            //check for notifications here
            processNotification(title, message, address, context);

            //end of inner else statement
            //}//else bracket

            //end of outer else statement
        }


    });//end of get item database



    //the old check notification was here 
    //processNotification(JSON.parse(event.waterLevel), context);
};


function processNotification(title, message, address, context) {

    console.log("sending notfication")

    const FIREBASE_API_KEY = 'AAAAH8R9tPw:APA91bEyslb6hkfJs_L9f0kGSpbpHA4AjTcD9i1sw67U4ag6tAVfINlCogst1LMGrshRO_Ng8VwGBeVL70nax6-p18udnNXC8sTfPsFqbRInJ4Kjoor0hyQVG8mV_sAWtFhQlbnyH8B3';

    const options = {
        host: 'fcm.googleapis.com',
        path: "/fcm/send",
        method: 'POST',
        headers: {
            'Authorization': 'key=AAAAH8R9tPw:APA91bEyslb6hkfJs_L9f0kGSpbpHA4AjTcD9i1sw67U4ag6tAVfINlCogst1LMGrshRO_Ng8VwGBeVL70nax6-p18udnNXC8sTfPsFqbRInJ4Kjoor0hyQVG8mV_sAWtFhQlbnyH8B3',
            'Content-Type': 'application/json'
        }

    };

    const postData = JSON.stringify({
        notification: {
            title: title,
            body: message,
            location: address,
            click_action: 'FLUTTER_NOTIFICATION_CLICK'
        },
        to: '/topics/flood'
    })

    const req = https.request(options, (res) => {
        console.log(`statusCode: ${res.statusCode}`)
        res.on('data', (d) => {
            process.stdout.write(d)
            //return context.succeed(buildSuccessResponse(d.toString()));
            return context.succeed(buildSuccessResponse(d.toString()));
        });

    })

    req.on('error', (e) => {
        console.error(`problem with request: ${e.message}`);
        return context.succeed(buildSuccessResponse(e.toString()));
    });

    // Write data to request body
    req.write(postData);
    req.end();
    //return context.succeed(buildSuccessResponse(postData));

}

function buildSuccessResponse(data) {
    return {
        statusCode: 200,
        body: JSON.stringify(data),
        headers: {
            'Content-Type': 'application/json',
        }
    };
}