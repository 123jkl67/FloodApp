import 'package:infineon_floodmonitoring/util/Controllers/pageController_home.dart';
import 'package:infineon_floodmonitoring/widgets/FlipBoxBar.dart';
import 'package:flutter/material.dart';
//for the Custom ios button
//import 'dart:io' show Platform;

//myHomePage for the scroll view of the items
class MyHomePage extends StatefulWidget {
  final String address;
  MyHomePage({this.address});
  @override
  State<StatefulWidget> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  String title = "Sensor Details";
  @override
  Widget build(BuildContext context) {
    return
        // return WillPopScope(
        // onWillPop: () async => false,
        // child:
        Scaffold(
      appBar: AppBar(
        title: Text(this.title),
        // leading: new IconButton(
        //   icon: Platform.isIOS
        //       ? Icon(Icons.arrow_back_ios)
        //       : Icon(Icons.arrow_back),
        //   onPressed: () {
        //     // Navigator.of(context).pushNamedAndRemoveUntil(
        //     //     '/', (Route<dynamic> route) => false);
        //     Navigator.of(context).pop();
        //     Navigator.of(context).pop();
        //     //Navigator.pushNamed(context, "/");
        //     // Navigator.popToFirs
        //     // final newRouteName = "/";
        //     // bool isNewRouteSameAsCurrent = false;

        //     // Navigator.popUntil(context, (route) {
        //     //   if (route.settings.name == newRouteName) {
        //     //     isNewRouteSameAsCurrent = true;
        //     //   }
        //     //   return true;
        //     // });

        //     // if (!isNewRouteSameAsCurrent) {
        //     //   Navigator.pushNamed(context, newRouteName);
        //     // }
        //   },
        // ),
      ),
      body: PageScrollWidget(
        address: widget.address,
      ), //tesing variable of loading down the widgets
      bottomNavigationBar: SizedBox(
          height: MediaQuery.of(context).size.height * .1, child: FlipBox()),
      //warp this in size box
    ); //)
  }
}
