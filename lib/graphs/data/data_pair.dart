import 'package:graph_swipe/graphs/data/data.dart';

class DataPair extends Data {
  late double value;
  late double min;
  late double max;

  DataPair(List<double> inList) : super((inList[0] + inList[1]) / 2) {
    this.min = inList[0];
    this.max = inList[1];
    // TODO: is this needed?
    this.value = (inList[0] + inList[1]) / 2;
  }

  List<double> getvalues() {
    return <double>[this.min, this.max];
  }

  @override
  String toString() {
    return "[" + min.toString() + ", " + max.toString() + "],";
  }
}
