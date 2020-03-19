import 'package:flutter/material.dart';

Material temperatureDisplay(IconData icon, String text, int color,
    {String item, @required double fontSizeTitle, double fontSizeTemp}) {
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
                Image.asset(
                  'assets/logo/thermometer.png',
                  width: 30,
                  height: 30,
                  fit: BoxFit.cover,
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
                    item + "°C",
                    style: TextStyle(
                      color: Color(color),
                      fontSize: fontSizeTemp, //32
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}
