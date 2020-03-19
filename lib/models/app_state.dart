import 'package:infineon_floodmonitoring/models/states/floodDataState.dart';
import 'package:infineon_floodmonitoring/models/states/googleMapState.dart';
import 'package:infineon_floodmonitoring/models/states/homepage_state.dart';
import 'package:infineon_floodmonitoring/models/states/searchDataState.dart';
import 'package:flutter/material.dart';

class AppState {
  final FloodState floodState;
  final HomePageState homePageState;
  final GoogleMapState googleMapState;
  final SearchState searchState;

  AppState(
      {@required this.floodState,
      @required this.homePageState,
      @required this.googleMapState,
      @required this.searchState});

  factory AppState.initial() {
    return AppState(
        floodState: FloodState.initial(),
        homePageState: HomePageState.initial(),
        googleMapState: GoogleMapState.initial(),
        searchState: SearchState.initial());
  }

  AppState copyWith(
      {FloodState floodState,
      HomePageState homePageState,
      GoogleMapState googleMapState,
      SearchState searchState}) {
    return new AppState(
        floodState: floodState ?? this.floodState,
        homePageState: homePageState ?? this.homePageState,
        googleMapState: googleMapState ?? this.googleMapState,
        searchState: searchState ?? this.searchState);
  }

  @override
  String toString() {
    return 'AppState{,homepageStateIndex:${homePageState.toString()}'; //floodState:${floodState.toString()}
  }

  // @override
  // int get hashCode =>
  // floodState.hashCode;

  // @override
  // bool operator ==(Object other) =>
  //     identical(this, other) ||
  //         other is AppState && floodState == other.floodState;

}
