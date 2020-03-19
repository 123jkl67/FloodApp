import 'package:infineon_floodmonitoring/actions/home_changer.dart';
import 'package:infineon_floodmonitoring/models/states/homepage_state.dart';
import 'package:flutter/material.dart';

HomePageState homePageReducer(HomePageState state, action) {
  if (action is UpdateHomePageIndex) {
    return state.copyWith(pageIndex: action.pageIndex);
  }
  if (action is AnimateHomePageIndex) {
    state.pageController.animateToPage(action.toIndex,
        duration: Duration(milliseconds: 500), curve: Curves.ease);
    return state.copyWith(pageIndex: action.toIndex);
  }
  return state;
}
