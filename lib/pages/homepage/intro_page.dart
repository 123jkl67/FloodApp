import 'package:infineon_floodmonitoring/actions/retrieve_action.dart';
import 'package:infineon_floodmonitoring/models/data_models/introData.dart';
import 'package:infineon_floodmonitoring/pages/homepage/homepage.dart';
import 'package:infineon_floodmonitoring/pages/homepage/widgets/intro_pageItem.dart';
import 'package:infineon_floodmonitoring/routes.dart' as prefix0;
import 'package:infineon_floodmonitoring/util/Controllers/page_transformer.dart';
import 'package:flutter/material.dart';
//not need for now
//import 'package:path/path.dart';

//redux
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

//StateMangement Stuff
import 'package:infineon_floodmonitoring/models/app_state.dart';

//Firebase stuff
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io' show Platform;

//set up the main pageView for the main page in the app
class IntroPageView extends StatefulWidget {
  //final bool test;
  //IntroPageView({bool test}):test?test:this.test;
  @override
  State<StatefulWidget> createState() {
    return IntroPageViewState();
  }
}

class IntroPageViewState extends State<IntroPageView> {
  //firebase stuff
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  void iosPermission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  PageController pageController =
      PageController(viewportFraction: 0.85); //testing
  int pageIndex = 0;
  int copyIndex = 0;
  // @override
  // void initState() {
  //   pageController.addListener(() {
  //     pageIndex = copyIndex;
  //     print("Floofy index selected is:" + pageIndex.toString());
  //   });

  //   super.initState();
  // }

  Widget mainScaffold() {
    return Scaffold(
      body: Center(
        child: SizedBox.fromSize(
          size: const Size.fromHeight(500.0),
          child: PageTransformer(
            pageViewBuilder: (context, visibilityResolver) {
              return PageView.builder(
                controller:
                    pageController, //PageController(viewportFraction: 0.85)
                itemCount: sampleItems.length, //sampleItems.length
                itemBuilder: (context, index) {
                  final item = sampleItems[index];
                  // print("page index" + index.toString());
                  // copyIndex = index;
                  // IntroItem item;
                  // if (index < 3) {
                  //   item = sampleItems[index];
                  // } else {
                  //   item = null;
                  final pageVisibility =
                      visibilityResolver.resolvePageVisibility(index);
                  return IntroPageItem(
                    item: item,
                    pageVisibility: pageVisibility,
                    index: index,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  } //main scaffold

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _IntroPageViewModel>(
      onInit: (store) {
        //on Init State with the store connected
        if (Platform.isIOS) {
          iosPermission();
        }
        _firebaseMessaging.subscribeToTopic('flood');
        _firebaseMessaging.configure(
            onMessage: (Map<String, dynamic> message) async {
          print("onMessage:$message");
          //on message Fetch
          if (Platform.isAndroid) {
            final notification = message['notification'];
            store.dispatch(UpdateFloodLocationSelection(
                selectionIndex: notification['address']));
            store.dispatch(
                FetchAction(location: store.state.floodState.location)
                    .actionFetch());
            //rremove this message = null if it is causing problems here man
            message = null;
            // setState(() {
            //   final notification = message['notification'];
            //   messages.add(Message(
            //       title: notification['title'], body: notification['body']));
            // });
          } else if (Platform.isIOS) {
            final notification = message['aps']['alert'];
            store.dispatch(UpdateFloodLocationSelection(
                selectionIndex: notification['address']));
            store.dispatch(
                FetchAction(location: store.state.floodState.location)
                    .actionFetch());
            message = null;
            // setState(() {
            //   final notification = message['aps']['alert'];
            //   messages.add(Message(
            //       title: notification['title'], body: notification['body']));
            // });
          }
        }, onLaunch: (Map<String, dynamic> message) async {
          //open the app to the navigator page when you tap open the notification
          // print("onLaunch:$message");
          //on launch have problem with error loading the data from the notification still do not
          //know the error caused
          if (Platform.isAndroid) {
            final notification = message['notification'];
            store.dispatch(UpdateFloodLocationSelection(
                selectionIndex: notification['address']));
            // store.dispatch(
            //     FetchAction(location: notification['address']).actionFetch());
            //testing here instead for the android part
            String address = notification['address'];
            //prefix0.pushWithoutAnimation(IntroPageView(), context);
            prefix0.pushWithoutAnimation(
                MyHomePage(
                  address: address,
                ),
                context);

            // store.dispatch(
            //     FetchAction(location: store.state.floodState.location)
            //         .actionFetch());
            // Navigator.pushReplacementNamed(context, '/detailPage');
            //set the message null remove if uncessary
            // message = null;
            //Navigator.pushReplacementNamed(context, '/detailPage');
            // Navigator.of(context).pushNamedAndRemoveUntil(
            //     '/detailPage', ModalRoute.withName('/'));
            // Navigator.of(context).pushNamedAndRemoveUntil(
            //     '/detailPage', (Route<dynamic> route) => false);

            // return;
          } else if (Platform.isIOS) {
            final notification = message['aps']['alert'];

            store.dispatch(UpdateFloodLocationSelection(
                selectionIndex: notification['address']));

            String address = notification['address'];
            prefix0.pushWithoutAnimation(
                MyHomePage(
                  address: address,
                ),
                context);
            //this part does not work here so testing
            // Navigator.pushReplacementNamed(context, '/detailPage');
            //set the message null remove if uncessary
            //message = null;
            // Navigator.of(context).pushNamedAndRemoveUntil(
            //     '/detailPage', (Route<dynamic> route) => false);
          }

          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => NextPage()),
          // );
        }, onResume: (Map<String, dynamic> message) async {
          print("onResume:$message");
          //final path = ModalRoute.of(context).settings.name;
          //print("path is " + path);
          if (Platform.isAndroid) {
            final notification = message['notification'];
            //print the address notification
            // print("notification address is " +
            //     notification['address'].toString());
            String address = notification['address'];
            store.dispatch(UpdateFloodLocationSelection(
                selectionIndex: notification['address']));
            // store.dispatch(
            //     FetchAction(location: notification['address']).actionFetch());

            prefix0.pushWithoutAnimation(
                MyHomePage(
                  address: address,
                ),
                context);

            //THIS WAS THE OLD DATA OF SETTLING THE PUSH OBJECT
            //message = null;
            // Navigator.of(context).pushNamedAndRemoveUntil(
            //     '/detailPage', ModalRoute.withName('/'));
            //Navigator.pushReplacementNamed(context, '/detailPage');
            // message = null;
            // return;
            // Navigator.of(context).pushNamedAndRemoveUntil(
            //     '/detailPage', (Route<dynamic> route) => false);
            // if (path == "/detailPage") {
            //   store.dispatch(
            //       FetchAction(location: store.state.floodState.location)
            //           .actionFetch());
            // } else {
            //   Navigator.pushNamed(context, '/detailPage');
            // }
            //Navigator.pushReplacementNamed(context, '/detailPage');
            //set the message null remove if uncessary
            //message = null;
          } else if (Platform.isIOS) {
            final notification = message['aps']['alert'];
            //print the address notification
            // print("notification address is " +
            //     notification['address'].toString());
            String address = notification['address'];
            store.dispatch(UpdateFloodLocationSelection(
                selectionIndex: notification['address']));
            // if (path == "/detailPage") {
            //   store.dispatch(
            //       FetchAction(location: store.state.floodState.location)
            //           .actionFetch());
            // } else {}

            prefix0.pushWithoutAnimation(
                MyHomePage(
                  address: address,
                ),
                context);

            //Navigator.pushReplacementNamed(context, '/detailPage');

            //set the message null remove if uncessary
            // message = null;
          }
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => NextPage()),
          // );
        });
      },
      converter: (store) => _IntroPageViewModel.fromStore(store),
      builder: (BuildContext context, _IntroPageViewModel vm) {
        return mainScaffold();
      },
    );
  }
}

class _IntroPageViewModel {
  _IntroPageViewModel({this.fetchData, this.updateLocation});
  final Function(String) updateLocation;
  final Function fetchData;
  static _IntroPageViewModel fromStore(Store<AppState> store) {
    return _IntroPageViewModel(fetchData: () {
      FetchSearchAction fetch = FetchSearchAction();
      store.dispatch(fetch.actionFetch());
    }, updateLocation: (String selectionIndex) {
      store.dispatch(
          UpdateFloodLocationSelection(selectionIndex: selectionIndex));
    });
  }
}
