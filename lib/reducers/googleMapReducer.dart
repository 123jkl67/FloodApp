import 'package:infineon_floodmonitoring/actions/google_mapUpdate.dart';
import 'package:infineon_floodmonitoring/models/app_state.dart';
import 'package:infineon_floodmonitoring/models/data_models/floodData.dart';
import 'package:infineon_floodmonitoring/models/states/googleMapState.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

GoogleMapState googleMapReducer(AppState state, action) {
  if (action is GoogleMapUpdate) {
    List<FloodData> rawData = state.floodState.floodData;
    final Map<MarkerId, Marker> markers = Map<MarkerId, Marker>();
    String coordinates = rawData[0].coordinates; //coordiates
    List<String> latlng = coordinates.split(',');
    //var markerIdVal = MyWayToGenerateId();
    String _lat = latlng[0];
    String _lng = latlng[1];

    //print("floof washere" + rawData.toString());
    final MarkerId markerId =
        MarkerId(rawData[0].address); //address of the first item in the list
    LatLng centerTarget = LatLng(double.parse(_lat), double.parse(_lng));

    // creating a new MARKER
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(double.parse(_lat), double.parse(_lng)),
      infoWindow: InfoWindow(title: rawData[0].address, snippet: '*'),
      onTap: () {},
    );
    markers[markerId] = marker;
    return state.googleMapState.copyWith(
        address: rawData[0].address,
        coordinatesRaw: rawData[0].coordinates, //coordinates
        lat: _lat,
        lng: _lng,
        centerTarget: centerTarget,
        markers: markers);

    //super.initState();
  } else {
    return state.googleMapState;
  }
}
