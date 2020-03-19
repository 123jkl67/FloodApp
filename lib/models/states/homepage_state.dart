import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
class HomePageState {
  final int pageIndex;
  final PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  HomePageState({
    @required this.pageIndex,
  });

  factory HomePageState.initial() {
    return new HomePageState(pageIndex: 0);
  }
  HomePageState copyWith({int pageIndex}) {
    return new HomePageState(pageIndex: pageIndex ?? this.pageIndex);
  }

  @override
  String toString() {
    return "PageIndex: $pageIndex";
  }
}
