import 'package:infineon_floodmonitoring/actions/retrieve_action.dart';
import 'package:flutter/material.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'package:infineon_floodmonitoring/models/app_state.dart';

//not need for now
// import 'package:collection/collection.dart';
// import 'package:quiver/strings.dart';

import 'dart:io' show Platform;

//updated to display better ui
class SearchBarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _SearchViewModel>(
      onInit: (store) => store.dispatch(FetchSearchAction().actionFetch()),
      converter: (store) => _SearchViewModel.fromStore(store),
      builder: (BuildContext context, _SearchViewModel viewmodel) {
        return WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              appBar: AppBar(
                title: Text("Search For location"),
                leading: new IconButton(
                  icon: Platform.isIOS
                      ? Icon(Icons.arrow_back_ios)
                      : Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();

                    // Navigator.of(context).pushNamedAndRemoveUntil(
                    //     Navigator.defaultRouteName,
                    //     (Route<dynamic> route) => false);
                    //Navigator.pushNamed(context, '/');
                    // Navigator.popUntil(context,
                    //     ModalRoute.withName(Navigator.defaultRouteName));
                  },
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      showSearch(
                          context: context, delegate: DataSearch(viewmodel));
                    },
                  ),
                ],
              ),
              body: LiquidPullToRefresh(
                showChildOpacityTransition: false,
                onRefresh: viewmodel.refreshData,
                child: viewmodel.searchData == null ||
                        viewmodel.searchData.isEmpty
                    ? ListView(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(20.0),
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.40,
                          ),
                          Center(
                            child: viewmodel.searchData == null
                                ? CircularProgressIndicator()
                                : Text("Error loading!"),
                          ),
                        ],
                      )
                    : ListView.builder(
                        itemBuilder: (context, index) => ListTile(
                          onTap: () {
                            //This is when the user taps on index list
                            //showResults(context);
                            viewmodel.updateLocation(viewmodel.searchData[
                                index]); //updated to use the location from the search data
                            Navigator.pushNamed(context, '/detailPage');
                            // Navigator.of(context).pushNamedAndRemoveUntil(
                            //     '/detailPage', (Route<dynamic> route) => false);
                          },
                          leading: Icon(Icons.location_city),
                          title: RichText(
                            text: TextSpan(
                              text: viewmodel.searchData[index].replaceAll(
                                  RegExp(r'_', caseSensitive: false),
                                  ' '), //This is for display without the _
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        itemCount: viewmodel.searchData.length,
                      ),
              ),
            )); // add the will popscope to here
      },
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  // final List<String> cities = [];s
  final _SearchViewModel viewModel;
  DataSearch(this.viewModel);

  @override
  List<Widget> buildActions(BuildContext context) {
    //actions for app bar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leading icon on the left of the app bar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result based on the selction
    // Navigator.pushNamed(context, "/detailPage");
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> displayDataList = [];
    //This replaces all the undescores in display Data list
    viewModel.searchData.forEach((String index) {
      String temp = index.replaceAll(RegExp(r"_"), ' ');
      displayDataList.add(temp);
    });
    //remove the section below when you are done
    print("The viewmodel SearchData is :" + viewModel.searchData.toString());
    print("The viewmodel displayData is :" + displayDataList.toString());
    //remove ˆˆ^the section above when yo uare done
    // show when some seaches for something
    final List<String> suggestionList = query.isEmpty
        ? displayDataList // recent cities displayDataList
        : displayDataList //viewmodel.searchData displayDataList
            .where((p) =>
                p.toLowerCase().contains(query.toLowerCase())) //starts with
            .toList();
    //   .where((p) {
    //   p.toLowerCase(); //improve version just compare lower case only
    //   return p.startsWith(query.toLowerCase());
    // }).toList(); //actual cities list
    String lowerQuery = query.toLowerCase();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          //showResults(context);
          //updateLocation here
          viewModel.updateLocation(viewModel.searchData[index]);
          Navigator.pushNamed(context, "/detailPage");
          //Navigator.pushReplacementNamed(context, "/detailPage");
          // Navigator.of(context).pushNamedAndRemoveUntil(
          //     '/detailPage', (Route<dynamic> route) => false);
        },
        leading: Icon(Icons.location_city),
        title: RichText(
          text: query.isEmpty
              ? TextSpan(
                  text: suggestionList[index].substring(0),
                  style: TextStyle(color: Colors.grey))
              : TextSpan(
                  text: suggestionList[index].substring(
                      0, //original 0
                      suggestionList[index].toLowerCase().indexOf(lowerQuery) <
                              0
                          ? 0
                          : suggestionList[index].toLowerCase().indexOf(
                              lowerQuery)), //replace all _ //testing what does this value dp  original was query.length
                  style: TextStyle(
                      color: Colors
                          .grey), // original was fontweight bold and color black
                  children: [
                      //New TextSpan to highlight the black text in the app
                      TextSpan(
                          text: suggestionList[index].substring(
                              suggestionList[index]
                                          .toLowerCase()
                                          .indexOf(lowerQuery) <
                                      0
                                  ? 0
                                  : suggestionList[index]
                                      .toLowerCase()
                                      .indexOf(lowerQuery),
                              suggestionList[index]
                                      .toLowerCase()
                                      .indexOf(lowerQuery) +
                                  query.length),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),

                      TextSpan(
                          text: suggestionList[index].substring(
                              suggestionList[index]
                                      .toLowerCase()
                                      .indexOf(lowerQuery) +
                                  query.length), //query.length
                          style: TextStyle(color: Colors.grey))
                      //end of if statement
                    ]),
        ),
      ),
      itemCount: suggestionList.length,
    );
    //end of build suggestion here
  }
}

class _SearchViewModel {
  //FloodDataViewModel

  List<String> searchData;
//List<String> displayData;

  final bool isLoading;
  final bool fetchError;
  _SearchViewModel({
    this.isLoading,
    this.fetchError,
    this.searchData,
    this.fetchData,
    this.refreshData,
    this.updateLocation,
  });
  final Function() fetchData;
  final Function() refreshData;
  final Function(String) updateLocation;

  static _SearchViewModel fromStore(Store<AppState> store) {
    return _SearchViewModel(
        isLoading: store.state.searchState.isLoading,
        fetchError: store.state.searchState.fetchError,
        searchData: store.state.searchState.searchData,
        fetchData: () {
          FetchSearchAction fetch = FetchSearchAction();
          store.dispatch(fetch.actionFetch());
        },
        refreshData: () {
          var fetch = FetchSearchAction();
          store.dispatch(fetch.actionFetch());
          return fetch.completer.future;
        },
        updateLocation: (String selectionIndex) {
          store.dispatch(
              UpdateFloodLocationSelection(selectionIndex: selectionIndex));
        });
    // return new _ViewModel(store.state.floodData);
  }
}
