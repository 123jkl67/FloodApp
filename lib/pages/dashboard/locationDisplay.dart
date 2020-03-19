import 'package:flutter/material.dart';

Material locationDisplay(IconData icon, String text, int color, {String item}) {
  String displayItem =
      item.replaceAll(RegExp('_'), ' '); //replace the underScores with a space
  return Material(
    color: Colors.white,
    elevation: 14.0,
    shadowColor: Color(0x802196f3), // color of the card shadow
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
                  "/assets/logo/cityLogo.png",
                ),
                //Location text part
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Text(
                //     text + ":",
                //     style: TextStyle(
                //       color: Color(color),
                //       fontSize: 20,
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    displayItem, //display
                    style: TextStyle(
                      color: Color(color),
                      fontSize: 20, //32
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
