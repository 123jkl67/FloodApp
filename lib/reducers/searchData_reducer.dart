import 'package:infineon_floodmonitoring/actions/retrieve_action.dart';
import 'package:infineon_floodmonitoring/models/states/searchDataState.dart';
import 'package:redux/redux.dart';

final searchReducer = combineReducers<SearchState>([
  TypedReducer<SearchState, FetchSearchSuccess>(_fetchinSuccess),
  TypedReducer<SearchState, FetchDataFailed>(_fetchinFailed),
  TypedReducer<SearchState, StartLoadingAction>(_startLoading),
]);

SearchState _fetchinSuccess(SearchState state, FetchSearchSuccess action) {
  return state.copyWith(
      searchData: action.searchData, isLoading: false, fetchError: false);
}

SearchState _fetchinFailed(SearchState state, FetchDataFailed action) {
  return state.copyWith(searchData: null, isLoading: false, fetchError: true);
}

SearchState _startLoading(SearchState state, StartLoadingAction action) {
  return state.copyWith(isLoading: true, fetchError: false);
}
