class Book {
  int count;
  String next;
  String previous;
  int id;
  List authors;
  List bookshelves;
  int downloadCount;
  Map<String, dynamic> formats;
  List languages;
  List subjects;
  String title;
  Book({
    this.count,
    this.next,
    this.previous,
  });
  Book.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    id = json["id"];
    authors = json["authors"];
    bookshelves = json["bookshelves"];
    downloadCount = json["download_count"];
    formats = json["formats"];
    // Formats(
    //     application_x_mobipocket_ebook: json["formats"]
    //         ["application/x-mobipocket-ebook"],
    //     application_pdf: json["formats"]["application/pdf"],
    //     text_plain_us_ascii: json["formats"]["text/plain; charset=us-ascii"],
    //     text_plain_utf_8: json["formats"]["text/plain; charset=utf-8"],
    //     application_rdf_xml: json["formats"]["application/rdf+xml"],
    //     text_plain_charset_iso_8859_1: json["formats"]
    //         ["text/plain; charset=iso-8859-1"],
    //     application_zip: json["formats"]["application/zip"],
    //     application_epub_zip: json["formats"]["application/epub+zip"],
    //     text_html_utf_8: json["formats"]["text/html; charset=utf-8"],
    //     text_plain: json["formats"]["text/plain"],
    //     image_jpeg: json["image/jpeg"],
    //     text_html_charset_iso_8859_1: json["formats"]
    //         ["text/html; charset=iso-8859-1"]);
    languages = json["languages"];
    subjects = json["subjects"];
    title = json["title"];
  }
}

class Formats {
  String application_x_mobipocket_ebook;
  String application_pdf;
  String text_plain_us_ascii;
  String text_plain_utf_8;
  String application_rdf_xml;
  String text_plain_charset_iso_8859_1;
  String application_zip;
  String application_epub_zip;
  String text_html_utf_8;
  String text_plain;
  String image_jpeg;
  String text_html_charset_iso_8859_1;

  Formats(
      {this.application_x_mobipocket_ebook,
      this.text_plain_us_ascii,
      this.text_plain_utf_8,
      this.application_rdf_xml,
      this.text_plain_charset_iso_8859_1,
      this.application_zip,
      this.application_epub_zip,
      this.text_html_utf_8,
      this.application_pdf,
      this.text_plain,
      this.image_jpeg,
      this.text_html_charset_iso_8859_1});
}

// class Author {
//   String birth_year;
//   String death_year;
//   String name;
//   Author({this.birth_year, this.death_year, this.name});
// }
class BookData {
  int count;
  String next;
  String previous;
  BookData.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
  }
}
