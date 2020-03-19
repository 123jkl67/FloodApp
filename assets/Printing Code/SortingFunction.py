# import json
# import boto3
# import calendar;
# import time;


# def lambda_handler(event, context):
#     ts = calendar.timegm(time.gmtime())
#     #print(ts)
#     floodId = str(ts) + "-" +event['locationId']
#     dynamodb = boto3.client('dynamodb',"us-east-1")
#     dynamodb.put_item(TableName='floodMonitoring',
#     Item={
#     'floodId':{'S':floodId},
#     'address':{'S': event['address']},
#     'coordinates':{'S': event['coordinates']},
#     'pressure':{'S':event['pressure']},
#     'temperature':{'S':event['temperature']},
#     'waterLevel':{'S':event['waterLevel']},
#     'time':{'S':str(ts)}})
