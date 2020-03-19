import 'package:flutter/material.dart';

//This is the data model to keep track of each indivudal data from the sensor itself

//use this to modify what instructions that the
class FloodData {
  final String floodId;
  final String time;
  final String pressure;
  final String temperature;
  //final String location;
  final String address;
  final String coordinates;
  final String waterLevel;
  FloodData(
      {@required this.floodId,
      @required this.time,
      @required this.pressure,
      @required this.temperature,
      //@required this.location,
      @required this.address,
      @required this.coordinates,
      @required this.waterLevel});

  @override
  String toString() {
    return "id:$floodId, temperature:$temperature,pressure: $pressure";
  }
}
