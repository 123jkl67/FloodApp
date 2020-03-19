import 'dart:async';

import 'package:infineon_floodmonitoring/models/data_models/floodData.dart';
import 'package:meta/meta.dart';

//update the floodstate to include the global variables for the setting of the app

@immutable
class FloodState {
  final String location;
  final bool isLoading;
  final bool fetchError;
  final List<FloodData> floodData;
  final Completer<Null> completer;

  //This is for setting the heropage display dashboard
  final String title;
  final String image;

  FloodState(
      {@required this.isLoading,
      @required this.fetchError,
      @required this.floodData,
      this.location,
      this.completer,
      this.title,
      this.image});

  factory FloodState.initial() {
    return new FloodState(
        isLoading: false,
        fetchError: false,
        floodData: null,
        location: null,
        completer: Completer<Null>(),
        title: "Singapore Polytechnic state",
        image: "assets/dashboard_images/Singapore.jpg");
  }

  FloodState copyWith(
      {bool isLoading,
      bool fetchError,
      List<FloodData> floodData,
      String location,
      String title,
      String image}) {
    return new FloodState(
        isLoading: isLoading ?? this.isLoading,
        fetchError: fetchError ?? this.fetchError,
        floodData: floodData ?? this.floodData,
        location: location ?? this.location,
        title: title ?? this.title,
        image: image ?? this.image);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FloodState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          fetchError == other.fetchError &&
          floodData == other.floodData;

  @override
  int get hashCode => isLoading.hashCode ^ floodData.hashCode;

  @override
  String toString() {
    return "FloodState[isLoading:$isLoading,floodData:${floodData.toString()}]";
  }
}
