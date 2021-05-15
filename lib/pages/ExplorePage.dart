import 'package:flutter/material.dart';
import 'package:graph_swipe/pages/Content.dart';
import 'package:swipe_cards/swipe_cards.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  List<SwipeItem> _swipeItems = <SwipeItem>[];
  late MatchEngine _matchEngine;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  String chartData =
      "{type:'bar',data:{labels:[2012,2013,2014,2015,2016],datasets:[{label:'Users',data:[120,60,50,180,120]}]}}";

  double _getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  double _getThreeQuarterHeight(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final EdgeInsets padding = MediaQuery.of(context).padding;
    var fullHeight = height - padding.top - padding.bottom;
    return fullHeight * 0.8;
  }

  void addSwipeItems(int quantity) {
    for (int i = 0; i < quantity; i++) {
      _swipeItems.add(SwipeItem(
          content: Content(
              text: "Default",
              color: Colors.red,
              image: "https://quickchart.io/chart?c=" +
                  chartData +
                  "&width=" +
                  _getWidth(context).toString() +
                  "&height=" +
                  _getThreeQuarterHeight(context).toString()),
          likeAction: () {
            print("like");
          },
          nopeAction: () {
            print("dislike");
          },
          superlikeAction: () {
            print("custom");
          }));
    }
  }

  @override
  void initState() {
    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    addSwipeItems(5);
    return Scaffold(
        key: _scaffoldKey,
        body: Container(
            child: Column(children: [
          Container(
            height: _getThreeQuarterHeight(context),
            width: _getWidth(context),
            child: SwipeCards(
              matchEngine: _matchEngine,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 17),
                        blurRadius: 23.0,
                        spreadRadius: -13.0,
                        color: Colors.black54,
                      )
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.network(_swipeItems[index].content.image),
                  ),
                );
              },
              onStackFinished: () {
                print("Done");
                addSwipeItems(10);
              },
            ),
          ),
        ])));
  }
}
