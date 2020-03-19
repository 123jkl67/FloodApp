import 'package:infineon_floodmonitoring/reducers/floodData_reducer.dart';
import 'package:infineon_floodmonitoring/reducers/googleMapReducer.dart';
import 'package:infineon_floodmonitoring/reducers/page_reducer.dart';
import 'package:infineon_floodmonitoring/reducers/searchData_reducer.dart';

import '../models/app_state.dart';

AppState appReducer(AppState state, action) {
  return new AppState(
      floodState: floodReducer(state.floodState, action),
      homePageState: homePageReducer(state.homePageState, action),
      googleMapState: googleMapReducer(state, action),
      searchState: searchReducer(state.searchState, action));
}
