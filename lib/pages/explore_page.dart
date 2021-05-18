import 'package:flutter/material.dart';
import 'package:graph_swipe/graph_manager/graph_manager.dart';
import 'package:graph_swipe/page_data/form/save_data/saved_form_data.dart';
import 'package:graph_swipe/page_data/page_size.dart';
import 'package:graph_swipe/page_data/swipe_card_content.dart';
import 'package:graph_swipe/pages/customise_page.dart';
import 'package:swipe_cards/swipe_cards.dart';

class ExplorePage extends StatefulWidget {
  final SavedFormData savedFormData;
  ExplorePage(this.savedFormData);

  @override
  _ExplorePageState createState() => _ExplorePageState(savedFormData);
}

class _ExplorePageState extends State<ExplorePage> {
  List<SwipeItem> _swipeItems = <SwipeItem>[];
  int _swipeIndex = -1;
  late MatchEngine _matchEngine;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  GraphManager graphManager = new GraphManager();
  final SavedFormData savedFormData;

  _ExplorePageState(this.savedFormData);

  void addSwipeItems(int quantity) {
    for (int i = 0; i < quantity; i++) {
      graphManager.createGraph(title: savedFormData.graphName);
      _swipeItems.add(SwipeItem(
          content: Content(
            graphData: graphManager.getGraphData(),
            image: graphManager.getGraphImage(
                PageSize.getWidth(context), PageSize.getCardHeight(context)),
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
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      CusomisePage(_swipeItems[_swipeIndex].content.graphData)),
            );
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
            height: PageSize.getCardHeight(context),
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
