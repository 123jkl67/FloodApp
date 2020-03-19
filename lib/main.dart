import 'package:infineon_floodmonitoring/routes.dart' as router;
import 'package:flutter/material.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_logging/redux_logging.dart';

import 'reducers/app_reducer.dart';
import 'models/app_state.dart';
import 'package:redux_thunk/redux_thunk.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final store = new Store<AppState>(appReducer,
      initialState: AppState.initial(),
      //remove this thunkmiddleware to save space and prevent state monitoring
      middleware: [thunkMiddleware]
        //..addAll(createAuthMiddleware())
        //..add(fetchDataMiddleware())
        ..add(LoggingMiddleware.printer()));
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Infineon FloodMonitoring Example App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: IntroPageView(),
        initialRoute: '/',
        //split into routes.dart
        onGenerateRoute: router.generateRoute,
        onUnknownRoute: (RouteSettings settings) {
          //to ask the router for unknown route settings
          return MaterialPageRoute(builder: (BuildContext context) {
            return Scaffold(
              appBar: AppBar(
                title: Text('oppps Wrong page'),
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              body: Text("Wrong page here"),
            );
          });
        },
      ),
    );
  }
}
