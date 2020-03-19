import 'dart:async';

import 'package:infineon_floodmonitoring/models/data_models/floodData.dart';
import 'package:infineon_floodmonitoring/services/fetchData.dart';
import 'package:redux/redux.dart';

import 'package:redux_thunk/redux_thunk.dart';

//update the floodAction to include the title and image for the hero widget

class UpdateHeroWidget {
  final String title;
  final String image;
  UpdateHeroWidget({this.title, this.image});
}

class UpdateFloodLocationSelection {
  final String selectionIndex;
  UpdateFloodLocationSelection({this.selectionIndex});

  String locationGetter() {
    return this.selectionIndex;
  }
}

class FetchAction {
  final Completer<Null> completer;
  final String location;

  FetchAction({Completer completer, this.location})
      : this.completer = completer ?? Completer<Null>();

  ThunkAction actionFetch() {
    return (Store store) async {
      new Future(() async {
        List<FloodData> response;
        store.dispatch(StartLoadingAction());
        try {
          response = await fetchFloodData(location);
          store.dispatch(FetchSuccess(response));
          completer.complete(null);
        } catch (error) {
          print("error from thunkActionFetchData " + error.toString());
          store.dispatch(FetchDataFailed());
          completer.complete(null);
        }
      });
    };
  }
}

class StartLoadingAction {
  //start loading action for any ui components
  StartLoadingAction();
}

class FetchDataFailed {
  //fetch data failed
  FetchDataFailed();
}

class FetchSuccess {
  //fetch data succes
  List<FloodData> floodData;
  FetchSuccess(this.floodData);
}

class FetchSearchAction {
  final Completer<Null> completer;

  FetchSearchAction({Completer completer})
      : this.completer = completer ?? Completer<Null>();

  ThunkAction actionFetch() {
    return (Store store) async {
      new Future(() async {
        List<String> response;
        store.dispatch(StartLoadingAction());
        try {
          response = await fetchSearchData();
          store.dispatch(FetchSearchSuccess(response));
          completer.complete(null);
        } catch (error) {
          print("error from thunkActionSearchData " + error.toString());
          store.dispatch(FetchDataFailed());
          completer.complete(null);
        }
      });
    };
  }
}

class FetchSearchSuccess {
  //fetch data succes
  List<String> searchData;
  FetchSearchSuccess(this.searchData);
}
