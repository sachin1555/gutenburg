import 'dart:convert';
import 'package:ignite_demo/models/bookmodel.dart';
import 'package:ignite_demo/models/searchModel.dart';
import 'package:ignite_demo/screens/search.dart';
import 'package:ignite_demo/services/index.dart';
import 'package:http/http.dart' as http;

class Api implements BaseServices {
  @override
  Future<List<Book>> searchBooks(
      {String name, String nextPage, String category}) async {
    String apiUrl;

    if (name != null && name != "") {
      apiUrl =
          "http://skunkworks.ignitesol.com:8000/books?category=$category&search=$name";
    } else if (nextPage != null) {
      apiUrl = nextPage;
    } else {
      apiUrl = "http://skunkworks.ignitesol.com:8000/books?category=$category";
    }
    print(apiUrl);
    Map<String, dynamic> decodedBody = await getJsonFromServers(apiUrl);
    print('Output json : $decodedBody');
    List<Book> bookList = (decodedBody["results"] as List)
        .map((element) => Book.fromJson(element))
        .toList();

    var bookData = BookData.fromJson(decodedBody);
    SearchScreen.nextPage = bookData.next;
    print("next page url${bookData.next}");
    print("return from api json::$bookList");
    return bookList;
  }
}

Future<Map<String, dynamic>> getJsonFromServers(var url) async {
  try {
    var response = await http.get(Uri.encodeFull(url), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json"
    });
    Map<String, dynamic> decodedBody = json.decode(response.body);
    return decodedBody;
  } catch (e) {
    print(e);
  }
}

// class Book {
//   int count;
//   String next;
//   String previous;
//   List result;
//   List book;
//   Book.fromJson(Map<String, dynamic> json) {
//     count = json['count'];
//     next = json['next'];
//     previous = json['previous'];
//     result = json["results"];
//     book = (result).map((element) => Books.fromJson(element)).toList();
//   }
// }
