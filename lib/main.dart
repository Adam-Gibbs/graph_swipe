// @dart=2.9
import 'package:flutter/material.dart';
import 'package:graph_swipe/pages/data_page.dart';
import 'package:graph_swipe/pages/explore_page.dart';
import 'package:graph_swipe/pages/favourite_page.dart';

void main() => runApp(MainApp());

class MainApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainAppState();
  }
}

class _MainAppState extends State<MainApp> {
  int selectedPage = 1;
  final _pageOptions = [DataPage(), ExplorePage(), FavouritePage()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TITLE',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Graph Swiper"),
        ),
        body: _pageOptions[selectedPage],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedPage,
          onTap: (int index) {
            setState(() {
              selectedPage = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.data_usage), label: 'Data'),
            BottomNavigationBarItem(
                icon: Icon(Icons.explore), label: 'Explore'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: 'Favourite')
          ],
        ),
      ),
    );
  }
}
