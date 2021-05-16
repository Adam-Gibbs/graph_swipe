class Data {
  late double value;

  Data(double inValue) {
    this.value = inValue;
  }

  double getvalue() {
    return value;
  }

  void set(double inValue) {
    this.value = inValue;
  }

  @override
  String toString() {
    return value.toString();
  }
}
