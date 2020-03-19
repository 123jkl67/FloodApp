import 'package:infineon_floodmonitoring/pages/dashboard/drawCircle.dart';
import 'package:flutter/material.dart';

Material alertDisplay(String text, int color,
    {String item, @required double fontSizeTitle}) {
  String alertText;
  double waterLevel = double.parse(item);
  //double waterLevel = 60.0;
  Color colors;
  bool highAlert = false;
  if (waterLevel < 15.0) {
    //no alert
    alertText = "No Flood Detected";
    colors = Colors.grey;
    highAlert = false;
  } else if (waterLevel < 30) {
    alertText = "Alert:Low Flood";
    colors = Colors.green;
    highAlert = false;
  } else if (waterLevel < 45) {
    alertText = "Warning:Medium Flood, Evacuate!";
    colors = Colors.yellow;
    highAlert = true;
  } else if (waterLevel >= 45) {
    alertText = "Warning:High Flood, Evacuate!";
    colors = Colors.red;
    highAlert = true;
  } else {
    alertText = "No Flood Detected";
    colors = Colors.grey;
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
                //text part
                highAlert
                    ? Image.asset("assets/warning_images/warning.png")
                    : CustomPaint(painter: DrawCircle(colors)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    alertText,
                    style: TextStyle(
                      color: Color(color),
                      fontSize:
                          fontSizeTitle, //change the font size here man but I will push up to edit
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
