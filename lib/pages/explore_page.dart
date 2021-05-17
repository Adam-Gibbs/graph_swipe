import 'package:flutter/material.dart';
import 'package:graph_swipe/api_manager/graph_manager.dart';
import 'package:graph_swipe/page_data/page_size.dart';
import 'package:graph_swipe/page_data/swipe_card_content.dart';
import 'package:graph_swipe/pages/customise_page.dart';
import 'package:swipe_cards/swipe_cards.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  List<SwipeItem> _swipeItems = <SwipeItem>[];
  int _swipeIndex = -1;
  late MatchEngine _matchEngine;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  GraphManager graphManager = new GraphManager();

  void addSwipeItems(int quantity) {
    for (int i = 0; i < quantity; i++) {
      graphManager.createGraph("");
      _swipeItems.add(SwipeItem(
          content: Content(
            graphData: graphManager.getGraphData(),
            image: graphManager.getGraphImage(PageSize.getWidth(context),
                PageSize.getThreeQuarterHeight(context)),
          ),
          likeAction: () {
            // TODO: trigger save, take content.graphData to save
            _swipeIndex++;
            print("like");
          },
          nopeAction: () {
            // TODO: probs nothing here
            _swipeIndex++;
            print("dislike");
          },
          superlikeAction: () {
            // TODO: launch customise menu, take content.graphData to use
            _swipeIndex++;
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
    addSwipeItems(2);
    return Scaffold(
        key: _scaffoldKey,
        body: Container(
            child: Column(children: [
          Container(
            height: PageSize.getThreeQuarterHeight(context),
            width: PageSize.getWidth(context),
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
                    child: FadeInImage(
                      placeholder: AssetImage(
                          'res/circular_progress_indicator_selective.gif'),
                      image: NetworkImage(_swipeItems[index].content.image),
                    ),
                  ),
                );
              },
              onStackFinished: () {
                print("Done");
                addSwipeItems(20);
              },
            ),
          ),
        ])));
  }
}
