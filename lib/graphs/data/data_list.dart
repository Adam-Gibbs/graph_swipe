import 'package:graph_swipe/graphs/data/data.dart';
import 'package:graph_swipe/graphs/data/data_pair.dart';

class DataList {
  List<Data> data = [];

  List<Data> getData() {
    return data;
  }

  void add(double value) {
    data.add(new Data(value));
  }

  void addPair(List<double> valuePair) {
    data.add(new DataPair(valuePair));
  }

  @override
  String toString() {
    return data.toString();
  }
}
