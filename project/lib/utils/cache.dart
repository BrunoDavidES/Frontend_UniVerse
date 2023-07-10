import 'package:hive_flutter/hive_flutter.dart';

class Cache {
  static final _instance = Cache._internal();

  Cache._internal();

  factory Cache.init() {
    return _instance;
  }

  factory Cache() {
    return _instance;
  }

  String read(String url) {
    Box cache = Hive.box('cache');

    return cache.get(url) ?? '';
  }

  write(String url, String data) {
    Box cache = Hive.box('cache');

    cache.put(url, data);
  }

}