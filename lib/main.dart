// @dart=2.9
import 'package:flutter/material.dart';
import 'package:graph_swipe/page_data/form/save_data/saved_form_data.dart';
import 'package:graph_swipe/pages/data_page.dart';
import 'package:graph_swipe/pages/explore_page.dart';
import 'package:graph_swipe/pages/favourite_page.dart';

void main() => runApp(MainApp());

class MainApp extends StatefulWidget {
  @override
  MainAppState createState() => MainAppState();
}

class MainAppState extends State<MainApp> {
  int selectedPage = 1;
  final SavedFormData savedFormData = new SavedFormData();

  @override
  Widget build(BuildContext context) {
    final _pageOptions = [
      DataPage(this, savedFormData),
      ExplorePage(savedFormData),
      FavouritePage()
    ];
    return MaterialApp(
      title: 'Graph Swiper',
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
