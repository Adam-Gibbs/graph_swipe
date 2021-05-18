import 'package:flutter/material.dart';
import 'package:graph_swipe/graph_manager/graph_manager.dart';
import 'package:graph_swipe/graphs/graph.dart';
import 'package:graph_swipe/page_data/favourite_graphs.dart';

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
        : Center(child: const Text('No items'));
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
    );
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
