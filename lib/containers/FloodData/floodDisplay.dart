import 'package:infineon_floodmonitoring/containers/error/ErrorDialog.dart';
import 'package:infineon_floodmonitoring/models/app_state.dart';
import 'package:infineon_floodmonitoring/models/data_models/floodData.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../models/app_state.dart';
import '../../widgets/floodCard.dart';

import '../../actions/retrieve_action.dart';

import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class FloodDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    showLoginError() {
      showDialog(
          context: context, builder: (BuildContext context) => ErrorDialog());
    }

    return new StoreConnector<AppState, FloodViewModel>(
      //onInit: (store) => store.dispatch(FetchAction().actionFetch()),
      converter: (store) =>
          FloodViewModel.fromStore(store), //_ViewModel.fromStore
      builder: (BuildContext context, FloodViewModel vm) {
        return LiquidPullToRefresh(
            showChildOpacityTransition: false,
            onRefresh: vm.refreshData,
            child: vm.floodData == null || vm.floodData.isEmpty
                ? ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(20.0),
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.45,
                      ),
                      Center(
                        child: vm.floodData == null
                            ? CircularProgressIndicator()
                            : Text("Your List Is Empty"),
                      ),
                    ],
                  )
                : ListView.builder(
                    reverse: true,
                    itemCount: vm.floodData.length,
                    itemBuilder: (BuildContext context, int index) {
                      print("Printing from flood display");
                      print(vm.floodData.toString());
                      return Container(
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              //print(vm.floodData.toString());
                              FloodCard(vm.floodData[index]),
                            ],
                          ),
                        ),
                      );
                    },
                  ));
      },
      onDidChange: (vm) {
        if (vm.fetchError) {
          showLoginError();
        }
      },
    );
  }
}

class FloodViewModel {
  //FloodDataViewModel

  List<FloodData> floodData;
  final bool isLoading;
  final bool fetchError;
  FloodViewModel(
      {this.isLoading,
      this.fetchError,
      this.floodData,
      this.fetchData,
      this.refreshData});
  final Function() fetchData;
  final Function() refreshData;

  static FloodViewModel fromStore(Store<AppState> store) {
    //testStore = store;
    return FloodViewModel(
      isLoading: store.state.floodState.isLoading,
      fetchError: store.state.floodState.fetchError,
      floodData: store.state.floodState.floodData,
      fetchData: () {
        FetchAction fetch = FetchAction();
        store.dispatch(fetch.actionFetch());
      },
      refreshData: () {
        var fetch = FetchAction();
        store.dispatch(fetch.actionFetch());
        return fetch.completer.future;
      },
    );
    // return new _ViewModel(store.state.floodData);
  }
}
