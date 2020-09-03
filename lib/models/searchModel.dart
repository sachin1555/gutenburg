import 'package:flutter/material.dart';
import 'package:ignite_demo/services/index.dart';
import 'bookmodel.dart';

class SearchModel extends ChangeNotifier {
  SearchModel() {
    //searchBooks();
  }
  List<Book> books = [];
  bool loading = false;
  String errMsg;
  Services _services = Services();
  bool endPage = false;

  searchBook({String name, String nextPage, String category}) async {
    if (nextPage != null) {
      try {
        loading = true;
        notifyListeners();
        var _books;
        _books = await Services()
            .searchBooks(name: name, nextPage: nextPage, category: category);
        books = [...books, ..._books];
        if (_books.length == 0)
          endPage = true;
        else
          endPage = false;
        loading = false;
        errMsg = null;
        notifyListeners();
      } catch (err) {
        loading = false;
        books = [];
        errMsg = "${err.toString()}";
        notifyListeners();
      }
    }
    loading = true;
    books = await _services.searchBooks(
        name: name, nextPage: nextPage, category: category);
    loading = false;
    endPage = false;
    notifyListeners();
  }
}
