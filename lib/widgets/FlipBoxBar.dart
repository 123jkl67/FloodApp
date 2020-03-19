import 'package:infineon_floodmonitoring/actions/home_changer.dart';
import 'package:flip_box_bar/flip_box_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:infineon_floodmonitoring/models/app_state.dart';

class FlipBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _FlipViewModel>(
      onInit: (store) {
        // int index = store.state.homePageState.pageIndex;
        // int zero = 0;
        // print(index);
        // if (index == zero) {
        // } else {
        //   print("hohohoho");
        //   store.dispatch(AnimateHomePageIndex(index));
        // }
      },
      converter: (store) => _FlipViewModel.fromStore(store),
      builder: (BuildContext context, viewmodel) {
        return FlipBoxBar(
          navBarHeight:
              MediaQuery.of(context).size.height * .1, //used to be point 1
          selectedIndex: viewmodel.pageIndex,
          items: [
            FlipBarItem(
                icon: Icon(
                  Icons.dashboard, //dashboard
                  color: Colors.white,
                ),
                text: Text(
                  "Dashboard",
                  style: TextStyle(color: Colors.white),
                ),
                frontColor: Colors.blue[700],
                backColor: Colors.blueAccent),
            FlipBarItem(
                icon: Icon(
                  Icons.map,
                  color: Colors.white,
                ),
                text: Text(
                  "Map",
                  style: TextStyle(color: Colors.white),
                ),
                frontColor: Colors.cyan[600],
                backColor: Colors.cyanAccent[400]),
            FlipBarItem(
                icon: Icon(
                  Icons.data_usage,
                  color: Colors.white,
                ),
                text: Text(
                  "Chart",
                  style: TextStyle(color: Colors.white),
                ),
                frontColor: Colors.orange[600],
                backColor: Colors.orangeAccent),
            FlipBarItem(
                icon: Icon(
                  Icons.dehaze,
                  color: Colors.white,
                ),
                text: Text(
                  "Raw data", //dehaze
                  style: TextStyle(color: Colors.white),
                ),
                frontColor: Colors.purple[600],
                backColor: Colors.purpleAccent[100]),
          ],
          onIndexChanged: (newIndex) {
            viewmodel.updatePageIndex(newIndex);
          },
        );
      },
    );
  }
}

class _FlipViewModel {
  final int pageIndex;
  final Function(int) updatePageIndex;

  _FlipViewModel({this.pageIndex, this.updatePageIndex});
  static _FlipViewModel fromStore(Store<AppState> store) {
    return _FlipViewModel(
      pageIndex: store.state.homePageState.pageIndex,
      updatePageIndex: (index) {
        store.dispatch(AnimateHomePageIndex(index));
      },
    );
  }
}
