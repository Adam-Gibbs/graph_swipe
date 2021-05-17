import 'package:flutter/material.dart';
import 'package:graph_swipe/api_manager/graph_manager.dart';
import 'package:graph_swipe/graphs/graph.dart';
import 'package:graph_swipe/page_data/page_size.dart';

class CusomisePage extends StatelessWidget {
  late GraphManager currentGraph = new GraphManager();

  CusomisePage(Graph newGraph) {
    this.currentGraph.setGraph(newGraph);
  }

  @override
  Widget build(BuildContext context) {
    String url = currentGraph.getGraphImage(200, 200);
    return Scaffold(
      appBar: AppBar(
        title: Text("Customise Graph"),
      ),
      body: FadeInImage(
        placeholder:
            AssetImage('res/circular_progress_indicator_selective.gif'),
        image: NetworkImage(currentGraph.getGraphImage(
            PageSize.getWidth(context), PageSize.getThirdHeight(context))),
      ),
    );
  }
}
