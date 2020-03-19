import 'package:infineon_floodmonitoring/actions/google_mapUpdate.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';

import 'package:infineon_floodmonitoring/models/app_state.dart';

class GoogleMapDisplay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GoogleMapDisplayState();
  }
}

class GoogleMapDisplayState extends State<GoogleMapDisplay> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _GoogleMapViewModel>(
        onInit: (store) => store.dispatch(GoogleMapUpdate()),
        converter: (store) => _GoogleMapViewModel.fromStore(store),
        builder: (BuildContext context, viewmodel) {
          return GoogleMap(
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
              new Factory<OneSequenceGestureRecognizer>(
                () => new EagerGestureRecognizer(),
              ),
            ].toSet(),
            compassEnabled: true,
            onMapCreated: (controller) =>
                viewmodel.onMapCreated(controller), //onmapcreated
            initialCameraPosition: CameraPosition(
              target: viewmodel.centerTarget,
              zoom: 18.0,
            ),
            markers: Set<Marker>.of(viewmodel.markers.values),
          );
        });
  }
}

class _GoogleMapViewModel {
  GoogleMapController mapController;
  final String address;
  final LatLng centerTarget;
  final Map<MarkerId, Marker> markers;
  _GoogleMapViewModel({this.address, this.centerTarget, this.markers});
  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  static _GoogleMapViewModel fromStore(Store<AppState> store) {
    //testStore = store;
    return _GoogleMapViewModel(
        address: store.state.googleMapState.address,
        centerTarget: store.state.googleMapState.centerTarget,
        markers: store.state.googleMapState.markers);
  }
}
