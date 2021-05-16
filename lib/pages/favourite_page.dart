import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:graph_swipe/api_manager/graph_manager.dart';

class FavouritePage extends StatefulWidget {
  @override
  FavouritePageState createState() {
    return FavouritePageState();
  }
}

class FavouritePageState extends State<FavouritePage> {
  TextEditingController editingController = TextEditingController();
  List<WordPair> items = [];
  List<WordPair> _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 20);
  GraphManager graphManager = new GraphManager();

  @override
  void initState() {
    _suggestions.addAll(generateWordPairs().take(100));
    items.addAll(_suggestions);
    super.initState();
  }

  void filterSearchResults(String query) {
    List<WordPair> dummySearchList = [];
    dummySearchList.addAll(_suggestions);
    if (query.isNotEmpty) {
      List<WordPair> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.join(" ").contains(query)) {
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
        items.addAll(_suggestions);
      });
    }
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: items.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (BuildContext _context, int i) {
          if (i.isOdd) {
            return Divider();
          }
          return _buildRow(items[i]);
        });
  }

  Widget _buildRow(WordPair pair) {
    graphManager.createGraph("");
    return ListTile(
      title: Text(
        pair.join(" "),
        style: _biggerFont,
      ),
      leading: FadeInImage(
        placeholder:
            AssetImage('res/circular_progress_indicator_selective.gif'),
        image: NetworkImage(graphManager.getGraphImage("250", "150")),
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
