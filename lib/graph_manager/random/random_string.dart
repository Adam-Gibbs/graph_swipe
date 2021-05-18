import 'package:english_words/english_words.dart';

class RandomString {
  static String randTitle() {
    return WordPair.random().join(" ").toUpperCase();
  }

  static String randWord() {
    return WordPair.random().first;
  }
}
