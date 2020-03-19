import 'package:infineon_floodmonitoring/actions/home_changer.dart';
import 'package:infineon_floodmonitoring/actions/retrieve_action.dart';
import 'package:infineon_floodmonitoring/containers/FloodData/floodDisplay.dart';
import 'package:infineon_floodmonitoring/models/app_state.dart';
import 'package:infineon_floodmonitoring/pages/analytics/analytics.dart';
import 'package:infineon_floodmonitoring/pages/dashboard/dashboard.dart';
import 'package:infineon_floodmonitoring/pages/googlemap/google_map_solo.dart';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class PageScrollWidget extends StatelessWidget {
//optinonal arguments for passing down the address testing
  final String address;
  PageScrollWidget({this.address});

  @override
  Widget build(BuildContext context) {
    String fetchAddress = address;
    // PageController pageController = PageController(
    //   initialPage: 0,
    //   keepPage: true,
    // );

    Widget buildPageView() {
      return StoreConnector<AppState, PageViewModel>(
        onInit: (store) {
          int index = 0;
          store.dispatch(UpdateHomePageIndex(index));

          if (fetchAddress == null) {
            print("null action");
            store.dispatch(
                FetchAction(location: store.state.floodState.location)
                    .actionFetch());
          } else {
            if (fetchAddress.isEmpty) {
              print("empty action");
              store.dispatch(
                  FetchAction(location: store.state.floodState.location)
                      .actionFetch());
            } else {
              print("cool action");
              store.dispatch(FetchAction(location: fetchAddress).actionFetch());
              //dispose the string man
              fetchAddress = null;
            }
          }

          //let me try this instead by assigning the heropage here instead mehhh
          String address = store.state.floodState.location.toString();
          String title;
          String image;
          //settign of image on the heropage is hardcoded
          //newer implementation requires fetching images via api for the preset location
          switch (address) {
            case "Infineon_Technologies":
              title = "Infineon Technologies";
              image = "assets/dashboard_images/infineon.png";
              break;
            case "Singapore_Polytechnic":
              title = "Singapore Polytechnic";
              image = "assets/dashboard_images/Singapore.jpg";
              break;
            case "Tampines":
              title = "Tampines";
              image = "assets/dashboard_images/Tampines.jpg";
              break;
            case "Woodlands":
              title = "Woodlands";
              image = "assets/dashboard_images/Woodlands.jpg";
              break;
            case "Yishun":
              title = "Yishun";
              image = "assets/dashboard_images/Yishun.jpg";
              break;
            default:
              title = "You have some error";
              image = "assets/error_images/error_dialog_icon.png";
          }
          store.dispatch(UpdateHeroWidget(title: title, image: image));
        },
        converter: (store) => PageViewModel.fromStore(store),
        builder: (BuildContext context, viewmodel) {
          return PageView(
            controller: viewmodel.pageController,
            onPageChanged: (index) {
              // pageChanged(index);
              viewmodel.updateIndex(index);
            },
            children: <Widget>[
              Dashboard(
                address: address,
              ), //first page // tesing passing down address via here fert inefficient way to do it
              GoogleMapDisplay(), // second page
              gridViewAnalytics(), // third page
              FloodDisplay(), // fourth page
            ],
          );
        },
      );
    }

    return buildPageView();
  }
}

class PageViewModel {
  final int pageIndex;
  final PageController pageController;

  final Function(int) updateIndex;

  PageViewModel({this.pageIndex, this.updateIndex, this.pageController});

  static PageViewModel fromStore(Store<AppState> store) {
    return PageViewModel(
        pageController: store.state.homePageState.pageController,
        pageIndex: store.state.homePageState.pageIndex,
        updateIndex: (index) {
          store.dispatch(UpdateHomePageIndex(index));
        });
  }
}
