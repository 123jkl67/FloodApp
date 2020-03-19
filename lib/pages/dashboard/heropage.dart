import 'package:flutter/material.dart';
import './layout_type.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/foundation.dart';

class HeroHeader extends SliverPersistentHeaderDelegate {
  // changed to extend.
  HeroHeader(
      {this.layoutGroup,
      this.onLayoutToggle,
      this.minExtent,
      this.maxExtent,
      this.image,
      this.title});
  final LayoutGroup layoutGroup;
  final VoidCallback onLayoutToggle;
  double maxExtent;
  double minExtent;
  final String image;
  final String title;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          image, //'assets/backup_images/2.png'
          fit: BoxFit.cover,
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                Colors.black54,
              ],
              stops: [0.5, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.repeated,
            ),
          ),
        ),
        // Positioned(
        //   left: 4.0,
        //   top: 4.0,
        //   child: SafeArea(
        //     child: IconButton(
        //       icon: Icon(layoutGroup == LayoutGroup.nonScrollable
        //           ? Icons.filter_1
        //           : Icons.filter_2),
        //       onPressed: onLayoutToggle,
        //     ),
        //   ),
        // ),
        Positioned(
          left: 16.0,
          right: 16.0,
          bottom: 16.0,
          child: Text(
            title, //Location Title // title
            style: TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
      ],
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => null;
}

class HeroPage extends StatelessWidget implements HasLayoutGroup {
  HeroPage(
      {Key key, this.layoutGroup, this.onLayoutToggle, this.image, this.title})
      : super(key: key);
  final LayoutGroup layoutGroup;
  final String image;
  final String title;
  final VoidCallback onLayoutToggle;

  @override
  Widget build(BuildContext context) {
    return null;
    // return Scaffold(
    //   body: scrollView(context),
    // );
  }

  Widget scrollView(BuildContext context, Widget gridview,
      ScrollController scrollPageController) {
    // final List<String> assetNames = [
    //   'assets/backup_images/2.png',
    //   'assets/backup_images/2.png',
    //   'assets/backup_images/2.png',
    //   'assets/backup_images/2.png',
    //   'assets/backup_images/2.png',
    //   'assets/backup_images/2.png',
    //   'assets/backup_images/2.png',
    //   'assets/backup_images/2.png',
    // ];
    // Use LayoutBuilder to get the hero header size while keeping the image aspect-ratio
    return //Container(child:
        CustomScrollView(
      controller: scrollPageController,
      slivers: <Widget>[
        SliverPersistentHeader(
          pinned: true,
          delegate: HeroHeader(
            layoutGroup: layoutGroup,
            onLayoutToggle: onLayoutToggle,
            minExtent: 0.0, // set minimum extent
            maxExtent: 150.0,
            image: image,
            title: title,
          ),
        ),
        SliverGrid(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            //maxCrossAxis
            maxCrossAxisExtent: MediaQuery.of(context).size.width,
            mainAxisSpacing: 0.0,
            crossAxisSpacing: 0.0,
            childAspectRatio: 0.75,
          ),
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            return Container(
              alignment: Alignment.center,

              //Take note to fix the staggered griview bug here
              // padding: _edgeInsetsForIndex(index),
              // child: Column(
              //   children: <Widget>[gridview, SizedBox(height: 100)],
              // ),
              child: gridview,
              // child: Image.asset(  // add your staggered grid view here
              //   assetNames[index % assetNames.length],
              // ),
            );
          }, childCount: 1 //assetNames.length * 2,
                  ),
        ),
      ],
    ); //,
    //);
  }

  // EdgeInsets _edgeInsetsForIndex(int index) {
  //   if (index % 2 == 0) {
  //     return EdgeInsets.only(top: 4.0, left: 8.0, right: 4.0, bottom: 4.0);
  //   } else {
  //     return EdgeInsets.only(top: 4.0, left: 4.0, right: 8.0, bottom: 4.0);
  //   }
  // }
}
