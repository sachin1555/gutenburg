import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ignite_demo/common/style.dart';
import 'package:ignite_demo/models/bookmodel.dart';
import 'package:ignite_demo/services/index.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class BookListScreen extends StatefulWidget {
  final name;
  final padding;
  final books;
  final bool isCart;
  final bool loading;

  BookListScreen(
      {this.books, this.name, this.padding = 10.0, this.isCart, this.loading});

  @override
  _BookListScreenState createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  RefreshController _refreshController;
  Services _service = Services();
  ScrollContext scrollController;
  List<Book> _books;
  int _page = 1;
  List<Widget> _simpleList = [];
  bool isfetching = false;

  @override
  initState() {
    super.initState();
    _books = widget.books ?? [];
    _refreshController = RefreshController(initialRefresh: _books.length == 0);
  }

  @override
  didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_books != widget.books) {
      setState(() {
        _books = widget.books;
      });
    }
  }

  _onLoading() async {
    setState(() {
      isfetching = true;
    });
  }

  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight + 60) / 2;
    final double itemWidth = size.width / 2;
    List<Widget> _list = [];
    _books.forEach((book) {
      _list.add(SimpleList(
        item: book,
      ));
    });

    _simpleList = _list;

    _simpleList.insert(
        _simpleList.length,
        isfetching && _books.length > 0
            ? Center(
                child: Padding(
                //child: kLoadingWidget(context),
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ))
            : Container(
                height: 56,
              ));

    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height / 1.3,
      child: GestureDetector(
        onPanDown: (_) => FocusScope.of(context).requestFocus(FocusNode()),
        child: LazyLoadScrollView(
          child: GridView.builder(
            scrollDirection: Axis.vertical,
            addAutomaticKeepAlives: true,
            shrinkWrap: true,
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: (itemWidth / itemHeight),
            ),
            itemBuilder: (context, index) {
              return _simpleList[index];
            },
            itemCount: _simpleList.length,
          ),
          onEndOfPage: _onLoading,
          isLoading: isfetching,
        ),
      ),
    ));
  }
}

class SimpleList extends StatefulWidget {
  final Book item;
  // final SimpleListType type;
  SimpleList({
    this.item,
  });
  @override
  _SimpleListState createState() {
    return _SimpleListState();
  }
}

class _SimpleListState extends State<SimpleList> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      cardView(),
    ]);
  }

  Widget cardView() {
    return widget.item.count != "Loading..."
        ? GestureDetector(
            onTap: () {
              onPressed();
            },
            child: Column(
              children: <Widget>[
                Container(
                  height: 155,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: backgroundColor),
                  child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image.asset(
                      'assets/images/books.jpg',
                      fit: BoxFit.fill,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.all(5),
                  ),
                ),
                Container(
                    margin: EdgeInsets.all(5),
                    height: 45,
                    child: Column(
                      children: <Widget>[
                        Center(
                            child: Text(
                          widget.item.title,
                          style: TextStyle(fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        )),
                        Text(
                          (widget.item.authors.length) != 0
                              ? (widget.item.authors[0]["name"]).toString()
                              : "",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black54),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ))
              ],
            ))
        : Container();
  }

  onPressed() async {
    var url = fileFormatCheck();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  alertDialog() {
    return Alert(
      context: context,
      type: AlertType.warning,
      title: "ALERT",
      desc: "No viewable version available.Do you really want to Exit?.",
      buttons: [
        DialogButton(
          child: Text(
            "Yes",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => exit(0),
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
        DialogButton(
          child: Text(
            "No",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        )
      ],
    ).show();
  }

  getFileExtension({String str}) {
    var newStr = str.substring(str.length - 3);
    return newStr;
  }

  fileFormatCheck() {
    var urlFormat = widget.item.formats.values.toList();
    print(urlFormat);
    for (int i = 0; i < widget.item.formats.length; i++) {
      var ext = getFileExtension(str: urlFormat[i]);
      if (ext == "pdf") {
        return urlFormat[i];
      } else if (ext == "htm") {
        return urlFormat[i];
      } else if (ext == "txt") {
        return urlFormat[i];
      } else {
        if (i == widget.item.formats.length - 1) {
          return alertDialog();
        }
      }
    }
  }
}
