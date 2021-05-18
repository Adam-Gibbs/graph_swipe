import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graph_swipe/graph_manager/graph_manager.dart';
import 'package:graph_swipe/graphs/graph.dart';
import 'package:graph_swipe/page_data/favourite_graphs.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:graph_swipe/page_data/page_size.dart';
import 'package:graph_swipe/pages/customise_page.dart';

class FavouritePage extends StatefulWidget {
  final FavouriteGraphs favouriteGraphs;
  FavouritePage(this.favouriteGraphs);
  @override
  _FavouritePageState createState() => _FavouritePageState(favouriteGraphs);
}

class _FavouritePageState extends State<FavouritePage> {
  final FavouriteGraphs favouriteGraphs;
  TextEditingController editingController = TextEditingController();
  List<Graph> items = [];
  final _biggerFont = const TextStyle(fontSize: 20);
  GraphManager graphManager = new GraphManager();

  _FavouritePageState(this.favouriteGraphs);

  @override
  void initState() {
    items.addAll(favouriteGraphs.graphs);
    super.initState();
  }

  void filterSearchResults(String query) {
    List<Graph> dummySearchList = [];
    dummySearchList.addAll(favouriteGraphs.graphs);
    if (query.isNotEmpty) {
      List<Graph> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.options.title.toUpperCase().contains(query.toUpperCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(favouriteGraphs.graphs);
      });
    }
  }

  Widget _buildSuggestions() {
    return items.length > 0
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: items.length * 2,
            padding: const EdgeInsets.all(16),
            itemBuilder: (BuildContext _context, int i) {
              if (i.isOdd) {
                return Divider();
              }
              return _buildRow(items[i ~/ 2]);
            })
        : Center(
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
            Icon(Icons.sentiment_dissatisfied, size: 70),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              alignment: Alignment.center,
              child: Text(
                'You have no favourites,\n swipe right in explore to add some',
                style: TextStyle(fontSize: 25),
                textAlign: TextAlign.center,
              ),
            )
          ])));
  }

  Widget alertButton(String text, Graph graph, BuildContext context,
      {Function? doPress}) {
    return TextButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.blue),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(9.0))))),
      onPressed: () {
        Navigator.of(context).pop();
        doPress!(graph);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }

  void _deleteGraph(Graph graph) {
    favouriteGraphs.unFavourite(graph);
  }

  void _shareImage(Graph graph) async {
    try {
      GraphManager shareGraph = new GraphManager().setGraph(graph);
      var request = await HttpClient().getUrl(Uri.parse(
          shareGraph.getGraphImage(
              PageSize.getWidth(context), PageSize.getHeight(context))));
      var response = await request.close();
      Uint8List bytes = await consolidateHttpClientResponseBytes(response);
      await Share.file('ESYS AMLOG', 'amlog.jpg', bytes, 'image/png');
    } catch (e) {
      print('error: $e');
    }
  }

  void showAlert(Graph graph) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: AlertDialog(
                backgroundColor: Colors.white60,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0))),
                contentPadding:
                    const EdgeInsets.only(bottom: 0, left: 8, right: 8, top: 8),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      graph.type == "line"
                          ? Icons.show_chart_sharp
                          : Icons.bar_chart,
                      color: Colors.blue,
                      size: 50.0,
                    ),
                    Flexible(
                        child: Text(
                      graph.options.title,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    )),
                    alertButton("Share", graph, context, doPress: _shareImage),
                    alertButton("Delete", graph, context,
                        doPress: _deleteGraph),
                    alertButton("Customise", graph, context,
                        doPress: _goToCustomise),
                    alertButton("Close", graph, context),
                  ],
                ),
              ));
        });
  }

  void _goToCustomise(Graph graph) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CusomisePage(graph)));
  }

  Widget _buildRow(Graph graph) {
    graphManager.setGraph(graph);
    return ListTile(
        title: Text(
          graph.options.title,
          style: _biggerFont,
        ),
        leading: FadeInImage(
          placeholder:
              AssetImage('res/circular_progress_indicator_selective.gif'),
          image: NetworkImage(graphManager.getGraphImage(600, 300)),
        ),
        onTap: () {
          showAlert(graph);
        });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Container(
            child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              filterSearchResults(value);
            },
            controller: editingController,
            decoration: InputDecoration(
                labelText: "Search",
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)))),
          ),
        ),
        Expanded(
          child: _buildSuggestions(),
        ),
      ],
    )));
  }
}
