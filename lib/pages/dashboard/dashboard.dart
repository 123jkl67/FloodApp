import 'package:infineon_floodmonitoring/actions/retrieve_action.dart';
import 'package:infineon_floodmonitoring/models/app_state.dart';
import 'package:infineon_floodmonitoring/models/data_models/floodData.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:infineon_floodmonitoring/pages/dashboard/heropage.dart';
import 'package:infineon_floodmonitoring/pages/dashboard/timeDisplay.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'package:infineon_floodmonitoring/pages/dashboard/layout_type.dart';
import './temperatureDisplay.dart';
import './pressureDisplay.dart';
import './AlertDisplay.dart';

//not needed for now
// import './locationDisplay.dart';

class Dashboard extends StatefulWidget {
  final String address;
  Dashboard({this.address});
  @override
  State<StatefulWidget> createState() {
    return DashBoardState();
  }
}

class DashBoardState extends State<Dashboard> {
  //layout Stuffss
  LayoutGroup _layoutGroup = LayoutGroup.scrollable; //nonScrollable
  // LayoutType _layoutSelection1 = LayoutType.rowColumn;
  // LayoutType _layoutSelection2 = LayoutType.pageView;

  //layout logic
  void _onLayoutGroupToggle() {
    setState(() {
      _layoutGroup = _layoutGroup == LayoutGroup.nonScrollable
          ? LayoutGroup.scrollable
          : LayoutGroup.nonScrollable;
    });
  }

  // void _onLayoutSelected(LayoutType selection) {
  //   setState(() {
  //     if (_layoutGroup == LayoutGroup.nonScrollable) {
  //       _layoutSelection1 = selection;
  //     } else {
  //       _layoutSelection2 = selection;
  //     }
  //   });
  // }

  ScrollController _scrollViewController;
  @override
  void initState() {
    _scrollViewController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    super.dispose();
  }

  StaggeredGridView gridView(_DashBoardViewModel viewmodel) {
    double width = MediaQuery.of(context).size.width;
    double blockAlert;
    double blockDisplay;
    double boxSize;
    //text adjustment values
    double fontSizeTitle;
    double fontSizePress;
    double fontSizeTemp;
    double fontSizeTime;
    print("The width of the phone is :" + width.toString());

    if (width < 200) {
      blockAlert = 133;
      blockDisplay = 119;
      boxSize = 600;
      fontSizePress = 10;
      fontSizeTemp = 16;
      fontSizeTitle = 10;
      fontSizeTime = 10;
    } else if (width < 400) {
      blockAlert = 133;
      blockDisplay = 119;
      boxSize = 300;
      fontSizePress = 14.5;
      fontSizeTemp = 19;
      fontSizeTitle = 15;
      fontSizeTime = 15;
    } else {
      blockAlert = 190;
      blockDisplay = 155;
      boxSize = 300;
      fontSizePress = 18;
      fontSizeTemp = 30;
      fontSizeTitle = 18;
      fontSizeTime = 18;
    }

    return StaggeredGridView.count(
      controller: _scrollViewController,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      children: <Widget>[
        // locationDisplay(Icons.wifi, "Location", 0xffed622b,
        //     item: viewmodel.floodData[0].address),
        alertDisplay("Alert", 0xffed622b,
            item: viewmodel.floodData[0].waterLevel,
            fontSizeTitle: fontSizeTitle),
        temperatureDisplay(Icons.attach_money, "Temperature", 0xffed622b,
            item: viewmodel.floodData[0].temperature,
            fontSizeTitle: fontSizeTitle,
            fontSizeTemp: fontSizeTemp),
        pressureDisplay(Icons.battery_full, "Water Level", 0xffed622b,
            item: viewmodel.floodData[0].waterLevel,
            fontSizePress: fontSizePress,
            fontSizeTitle:
                fontSizeTitle), //show water level instead of pressure
        timeDisplay(Icons.arrow_back_ios, "Time", 0xffed622b,
            item: viewmodel.floodData[0].time, fontSizeTime: fontSizeTime),
        SizedBox(
          height: boxSize, //800
        )
      ],
      staggeredTiles: [
        //Dynamically change the size of the staggerd tiles when resoution changes
        //get the changes of the and place the height of the changed resolution
        // StaggeredTile.extent(2, 120.0), //height 130
        StaggeredTile.extent(2, blockAlert), // alert warning 190
        StaggeredTile.extent(1, blockDisplay), //height 150 170
        StaggeredTile.extent(1, blockDisplay), //170
        StaggeredTile.extent(2, blockDisplay), // alert warning 170
        StaggeredTile.extent(2, boxSize) //sizebox 900
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    //String fetchAddress = widget.address;

    //HeroPage meow;
    // HeroPage meow = HeroPage(
    //     layoutGroup: _layoutGroup,
    //     onLayoutToggle: _onLayoutGroupToggle,
    //     image: "assets/dashboard_images/infineon.png");
    // String title = "Singapore_Polytechnic";
    // String image = "assets/dashboard_images/Singapore.jpg";

    // String title;
    // String image;

    return StoreConnector<AppState, _DashBoardViewModel>(
      onInit: (store) {},
      converter: (store) => _DashBoardViewModel.fromStore(store),
      builder: (BuildContext context, _DashBoardViewModel vm) {
        HeroPage meow = HeroPage(
            layoutGroup: _layoutGroup,
            onLayoutToggle: _onLayoutGroupToggle,
            image: vm.image, // image
            title: vm.title);

        return LiquidPullToRefresh(
            showChildOpacityTransition: false,
            onRefresh: vm.refreshData, //vm.refreshData
            child: vm.floodData == null || vm.floodData.isEmpty
                ? ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(20.0),
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.40,
                      ),
                      Center(
                        child: vm.floodData == null
                            ? CircularProgressIndicator()
                            : Text("Error loading!"),
                      ),
                    ],
                  )
                : meow.scrollView(context, gridView(vm), _scrollViewController)

            // NestedScrollView(
            //     headerSliverBuilder:
            //         (BuildContext context, bool boxIsScrolled) {
            //       return <Widget>[
            //         SliverAppBar(
            //           title: Text("Flood Monitoring"),
            //           pinned: true,
            //           floating: true,
            //           forceElevated: boxIsScrolled,
            //         ),
            //       ];
            //     },
            //     controller: _scrollViewController,
            //     body: gridView(vm),
            //   ),

            // gridView(vm)
            //added list view here
            );
      },
    );
  }
}

class _DashBoardViewModel {
  List<FloodData> floodData;
  final bool isLoading;
  final bool fetchError;

  //hero page variables
  final String title;
  final String image;
  //Static String currentLocation;
  _DashBoardViewModel(
      {this.isLoading,
      this.fetchError,
      this.floodData,
      this.fetchData,
      this.refreshData,
      this.fetchCurrentLocation,
      //hero variables
      this.title,
      this.image});
  final Function() fetchData;
  final Function() refreshData;
  final Function() fetchCurrentLocation;

  static _DashBoardViewModel fromStore(Store<AppState> store) {
    return _DashBoardViewModel(
        isLoading: store.state.floodState.isLoading,
        fetchError: store.state.floodState.fetchError,
        floodData: store.state.floodState.floodData,
        //hero variables
        title: store.state.floodState.title,
        image: store.state.floodState.image,
        //actions method implementation
        fetchData: () {
          FetchAction fetch =
              FetchAction(location: store.state.floodState.location);
          store.dispatch(fetch.actionFetch());
        },
        refreshData: () {
          var fetch = FetchAction(location: store.state.floodState.location);
          store.dispatch(fetch.actionFetch());
          return fetch.completer.future;
        },
        fetchCurrentLocation: () {
          var fetch = UpdateFloodLocationSelection();
          String currentLocation = fetch.locationGetter();
          return currentLocation;
        });
  }
}
