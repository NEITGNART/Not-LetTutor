import 'package:hive_flutter/hive_flutter.dart';

class HiveBoxes {
  static final HiveBoxes _instance = HiveBoxes._internal();

  factory HiveBoxes() {
    return _instance;
  }
  HiveBoxes._internal();
  Future<Box<T>> openBox<T>(String name) async {
    // check if box is already open
    if (Hive.isBoxOpen(name)) {
      return Hive.box<T>(name);
    }
    return await Hive.openBox<T>(name);
  }
}
