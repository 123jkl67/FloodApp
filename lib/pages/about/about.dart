import 'package:infineon_floodmonitoring/models/data_models/about_description.dart';
import 'package:flutter/material.dart';

class AboutDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double fontSizeAddress;
    double percentageMulti;
    //adjsut the content size of the box
    if (width < 200) {
      fontSizeAddress = 11;
      percentageMulti = 0.65;
    } else if (width < 400) {
      fontSizeAddress = 13;
      percentageMulti = 0.72;
    } else {
      fontSizeAddress = 13;
      percentageMulti = 0.8;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.only(left: 20),
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              primary: false,
              itemCount: about == null ? 0 : about.length,
              itemBuilder: (BuildContext context, int index) {
                Map place = about[index];

                return Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      "${place["img"]}",
                      height: 250,
                      width: MediaQuery.of(context).size.width - 40,
                      fit: BoxFit.contain, //cover
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          ListView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            primary: false,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${about[0]["name"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.location_on,
                    size: 14,
                    color: Colors.blueGrey[300],
                  ),
                  SizedBox(width: 3),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: MediaQuery.of(context).size.width *
                        percentageMulti, // multiply by percentage
                    margin: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Infineon Technolgies,\n 8 Kallang Sector,Singapore 349282,", //testing location
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: fontSizeAddress, //orignal font size 13
                            color: Colors.blueGrey[300],
                          ),
                          maxLines: 3,
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height:
                              10.0, //height box adjustment when container vaires
                        ),
                        Text(
                          "Singapore polytechnic,\n500 Dover Rd, Singapore 139651", //testing location
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: fontSizeAddress, //original font size 13
                            color: Colors.blueGrey[300],
                          ),
                          maxLines: 3,
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Details",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 10),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${about[0]["details"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ],
      ),
    );
  }
}
