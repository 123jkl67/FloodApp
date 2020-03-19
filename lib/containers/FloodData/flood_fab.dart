// // containers/increase_counters.dart
// import 'package:infineon_floodmonitoring/actions/retrieve_action.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_redux/flutter_redux.dart';
// import '../../models/app_state.dart';
// import 'package:redux/redux.dart';

// // This is just another stateless widget.
// class FetchDataButton extends StatelessWidget {
//   FetchDataButton({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return new StoreConnector<AppState, VoidCallback>(
//       converter: (Store<AppState> store) {
//         return () {
//           FetchAction fetch = FetchAction();
//           store.dispatch(fetch.actionFetch());
//         };
//       },
//       builder: (BuildContext context, VoidCallback fetchData) {
//         return new FloatingActionButton(
//           onPressed: fetchData,
//           child: new Icon(Icons.refresh),
//         );
//       },
//     );
//   }
// }
