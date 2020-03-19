import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

class GoogleMapState {
  final String address;
  final String coordinatesRaw;
  final String lat;
  final String lng;
  final LatLng centerTarget;
  final Map<MarkerId, Marker> markers;

  factory GoogleMapState.initial() {
    return new GoogleMapState(
        address: "", //let me assign initial values here so that it doesn hand
        coordinatesRaw: "1.3521,103.8198", //defualt values
        lat: "1.3521", // default values
        lng: "103.8198", // defualt values
        centerTarget: LatLng(0, 0),
        markers: Map<MarkerId, Marker>());
  }

  GoogleMapState(
      {@required this.address,
      @required this.coordinatesRaw,
      @required this.lat,
      @required this.lng,
      @required this.centerTarget,
      @required this.markers});

  GoogleMapState copyWith(
      {String address,
      String coordinatesRaw,
      GoogleMapController mapController,
      String lat,
      String lng,
      LatLng centerTarget,
      Map<MarkerId, Marker> markers}) {
    return GoogleMapState(
        address: address ?? this.address,
        coordinatesRaw: coordinatesRaw ?? this.coordinatesRaw,
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
        centerTarget: centerTarget ?? this.centerTarget,
        markers: markers ?? this.markers);
  }

  // CLASS MEMBER, MAP OF MARKS

}
