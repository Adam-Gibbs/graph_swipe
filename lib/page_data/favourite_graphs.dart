import 'package:graph_swipe/graphs/graph.dart';
import 'package:graph_swipe/page_data/disk_save.dart';
import 'package:json_annotation/json_annotation.dart';

part 'favourite_graphs.g.dart';

@JsonSerializable()
class FavouriteGraphs {
  List<Graph> graphs = [];

  FavouriteGraphs();

  factory FavouriteGraphs.fromJson(Map<String, dynamic> json) =>
      _$FavouriteGraphsFromJson(json);
  Map<String, dynamic> toJson() => _$FavouriteGraphsToJson(this);

  void addAll(List<Graph> graphs) {
    this.graphs.addAll(graphs);
    DiskSave.saveToDisk(this);
  }

  void favourite(Graph graph) {
    this.graphs.add(graph);
    DiskSave.saveToDisk(this);
  }

  void unFavourite(Graph graph) {
    this.graphs.remove(graph);
    DiskSave.saveToDisk(this);
  }

  void clear() {
    this.graphs.clear();
  }
}
