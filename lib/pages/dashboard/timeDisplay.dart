import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Material timeDisplay(IconData icon, String text, int color,
    {String item, @required double fontSizeTime}) {
  if (item == null) {
    item = "null item error";
  }
  String time;
  int timeStamp = int.parse(item);
  //old format final f = new DateFormat('yyyy-MM-dd hh:mm a');
  final f = new DateFormat('dd-MM-yyyy hh:mm a');

  //Text(f.format(new DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000)));
  time = f.format(new DateTime.fromMillisecondsSinceEpoch(
      timeStamp * 1000)); //* 1000 to get the correc t time stamp
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
                  'assets/logo/clock.png',
                  width: 35,
                  height: 35,
                  fit: BoxFit.fill, //cover
                ),
                //text part
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    text + ":", // + :
                    style: TextStyle(
                      color: Color(color),
                      fontSize: fontSizeTime, //20
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    time, //item //waterlevel.toStringAsPrecision(3) + " cm"
                    style: TextStyle(
                      color: Color(color),
                      fontSize: fontSizeTime, //20
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
