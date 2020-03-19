import 'package:infineon_floodmonitoring/actions/retrieve_action.dart';
import 'package:infineon_floodmonitoring/models/states/floodDataState.dart';
import 'package:redux/redux.dart';

//update the new reducer for the hero page title and image

final floodReducer = combineReducers<FloodState>([
  TypedReducer<FloodState, FetchSuccess>(_fetchinSuccess),
  TypedReducer<FloodState, FetchDataFailed>(_fetchinFailed),
  TypedReducer<FloodState, StartLoadingAction>(_startLoading),
  TypedReducer<FloodState, UpdateFloodLocationSelection>(_updateLocation),
  //reducer for updating the title and hero page
  TypedReducer<FloodState, UpdateHeroWidget>(_updateHero)
]);

FloodState _fetchinSuccess(FloodState state, FetchSuccess action) {
  return state.copyWith(
      floodData: action.floodData, isLoading: false, fetchError: false);
}

FloodState _fetchinFailed(FloodState state, FetchDataFailed action) {
  return state.copyWith(floodData: null, isLoading: false, fetchError: true);
}

FloodState _startLoading(FloodState state, StartLoadingAction action) {
  return state.copyWith(isLoading: true, fetchError: false);
}

FloodState _updateLocation(
    FloodState state, UpdateFloodLocationSelection action) {
  return state.copyWith(location: action.selectionIndex);
}

FloodState _updateHero(FloodState state, UpdateHeroWidget action) {
  return state.copyWith(title: action.title, image: action.image);
}
