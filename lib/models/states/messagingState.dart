// import 'package:meta/meta.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'dart:io' show Platform;

// @immutable
// class MessageState {
//   final String title;
//   final String body;
//   //final Completer<Null> completer;

//   MessageState({
//     @required this.title,
//     @required this.body,
//   });

//   factory MessageState.initial() {
//     final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

//     //Intialiser IOS Permissions For IOS notifications
//     void iosPermission() {
//       _firebaseMessaging.requestNotificationPermissions(
//           IosNotificationSettings(sound: true, badge: true, alert: true));
//       _firebaseMessaging.onIosSettingsRegistered
//           .listen((IosNotificationSettings settings) {
//         print("Settings registered: $settings");
//       });
//     }

//     //Initialise the methods
//     if (Platform.isIOS) {
//       iosPermission();
//     }
//     _firebaseMessaging.subscribeToTopic('flood');
//     _firebaseMessaging.configure(
//         onMessage: (Map<String, dynamic> message) async {
//       print("onMessage:$message");

//       if (Platform.isAndroid) {
//         // setState(() {
//         //   final notification = message['notification'];
//         //   messages.add(Message(
//         //       title: notification['title'], body: notification['body']));
//         // });
//       } else if (Platform.isIOS) {
//         // setState(() {
//         //   final notification = message['aps']['alert'];
//         //   messages.add(Message(
//         //       title: notification['title'], body: notification['body']));
//         // });
//       }
//     }, onLaunch: (Map<String, dynamic> message) async {
//       print("onLaunch:$message");
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => NextPage()),
//       );
//     }, onResume: (Map<String, dynamic> message) async {
//       print("onResume:$message");
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => NextPage()),
//       );
//     });

//     return new MessageState(title: null, body: null);
//   }

//   MessageState copyWith({
//     String title,
//     String body,
//   }) {
//     return new MessageState(
//       title: title ?? this.title,
//       body: body ?? this.body,
//     );
//   }

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is MessageState &&
//           runtimeType == other.runtimeType &&
//           title == other.title &&
//           body == other.body;

//   @override
//   int get hashCode => title.hashCode ^ body.hashCode;

//   @override
//   String toString() {
//     return "MessageState[title:$title,floodData:${body}]";
//   }
// }
