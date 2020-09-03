import 'package:ignite_demo/models/bookmodel.dart';

import 'package:connectivity/connectivity.dart';
import 'package:ignite_demo/services/api.dart';

abstract class BaseServices {
  Future<List<Book>> searchBooks(
      {String name, String nextPage, String category});
}

class Services implements BaseServices {
  // BaseServices serviceApi;
  Api serviceApi = Api();
  static final Services _instance = Services._internal();
  factory Services() => _instance;
  Services._internal();

  @override
  Future<List<Book>> searchBooks(
      {String name, String nextPage, String category}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      List<Book> books = await serviceApi.searchBooks(
          name: name, nextPage: nextPage, category: category);
      return books;
    } else {
      throw Exception("No internet connection");
    }
  }
}
