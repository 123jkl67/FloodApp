import 'package:flutter/material.dart';

Material pressureDisplay(IconData icon, String text, int color,
    {String item,
    @required double fontSizeTitle,
    @required double fontSizePress}) {
  //double waterlevel = int.parse(item) / 10000;
  if (item == null) {
    item = "it was null";
  }
  return Material(
    color: Colors.white,
    elevation: 14.0,
    shadowColor: Color(0x802196f3),
    borderRadius: BorderRadius.circular(24.0),
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/logo/speedometer.png',
                  width: 35,
                  height: 35,
                  fit: BoxFit.fill, //cover
                ),
                //text part
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    text + ":",
                    style: TextStyle(
                      color: Color(color),
                      fontSize: fontSizeTitle, //20
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    item + " cm", //item //waterlevel.toStringAsPrecision(3)
                    style: TextStyle(
                      color: Color(color),
                      fontSize: fontSizePress, //fontSize 20
                    ),
                  ),
                ),
                //icon
                // Material(
                //   color: Color(color),
                //   borderRadius: BorderRadius.circular(24.0),
                //   child: Padding(
                //     padding: EdgeInsets.all(16.0),
                //     child: Icon(
                //       icon,
                //       color: Colors.white,
                //       size: 30.0,
                //     ),
                //   ),
                // )
              ],
            )
          ],
        ),
      ),
    ),
  );
}
