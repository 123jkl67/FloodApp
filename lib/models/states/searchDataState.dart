import 'dart:async';
import 'package:meta/meta.dart';

@immutable
class SearchState {
  final bool isLoading;
  final bool fetchError;
  final List<String> searchData;
  final Completer<Null> completer;

  SearchState(
      {@required this.isLoading,
      @required this.fetchError,
      @required this.searchData,
      this.completer});

  factory SearchState.initial() {
    return new SearchState(
        isLoading: false,
        fetchError: false,
        searchData: null,
        completer: Completer<Null>());
  }

  SearchState copyWith({
    bool isLoading,
    bool fetchError,
    List<String> searchData,
  }) {
    return new SearchState(
      isLoading: isLoading ?? this.isLoading,
      fetchError: fetchError ?? this.fetchError,
      searchData: searchData ?? this.searchData,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          fetchError == other.fetchError &&
          searchData == other.searchData;

  @override
  int get hashCode => isLoading.hashCode ^ searchData.hashCode;

  @override
  String toString() {
    return "SearchState[isLoading:$isLoading,floodData:${searchData.toString()}]";
  }
}
