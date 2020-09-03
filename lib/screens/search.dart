import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ignite_demo/common/config.dart';
import 'package:ignite_demo/common/style.dart';
import 'package:ignite_demo/models/bookmodel.dart';
import 'package:ignite_demo/models/searchModel.dart';

import 'package:provider/provider.dart';
import 'booklistscreen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:after_layout/after_layout.dart';

class SearchScreen extends StatefulWidget {
  final isModal;
  final String query;
  final onBackPress;
  final String category;
  static String nextPage;
  SearchScreen({this.isModal, this.query, this.onBackPress, this.category});

  @override
  _StateSearchScreen createState() => _StateSearchScreen();
}

class _StateSearchScreen extends State<SearchScreen> with AfterLayoutMixin {
  bool isVisibleSearch = true;
  String searchText;
  bool ifsearchEmpty;

  final _formKey = GlobalKey<FormState>();
  List<Book> _books = [];
  var textController = new TextEditingController();
  final RefreshController _controller = RefreshController();
  Timer _timer;
  FocusNode _focus;
  int page = 1;
  @override
  void initState() {
    super.initState();
    if (widget.query != null) {
      setState(() {
        searchText = widget.query;
        textController.text = searchText;
      });
    }
  }

  @override
  didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget);
    Provider.of<SearchModel>(context).searchBook(category: widget.category);
  }

  void _onLoading(SearchModel model) async {
    await model.searchBook(
        nextPage: SearchScreen.nextPage,
        name: searchText,
        category: widget.category);
    _controller.loadComplete();
  }

  Widget _renderSearchLayout(BuildContext context) {
    return ListenableProvider.value(
        value: Provider.of<SearchModel>(context),
        child: Consumer<SearchModel>(builder: (context, model, child) {
          if (model.loading == true) {
            return Container(
              color: Colors.transparent,
              child: kLoadingWidget(context),
            );
          }

          if (model.loading && model.books.length <= 0) {
            return Container(
              color: Colors.transparent,
              child: kLoadingWidget(context),
            );
          }
          if (!model.loading && model.errMsg != null) {
            return Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/empty_search.png',
                      height: 150,
                    ),
                    Padding(
                        child:
                            Text(model.errMsg.replaceFirst("Exception: ", "")),
                        padding: EdgeInsets.symmetric(horizontal: 16.0)),
                  ],
                ));
          }
          if (!model.loading && model.books.length <= 0) {
            return emptySearch(text: "No result found.");
          }
          return SmartRefresher(
              controller: _controller,
              enablePullUp: !model.endPage,
              enablePullDown: true,
              onLoading: model.endPage
                  ? null
                  : () {
                      _onLoading(model);
                    },
              child: model.books.length == 0 && !model.loading
                  ? Center(
                      child: Text('No Book'),
                    )
                  : GestureDetector(
                      child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).backgroundColor),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 0.0, vertical: 0.0),
                              child: BookListScreen(
                                name: searchText,
                                books: model.books,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )));
        }));
  }

  Align emptySearch({@required String text}) {
    return Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/empty_search.png',
              height: 150,
            ),
            Padding(
                child: Text(
                  text,
                  style: TextStyle(fontSize: 22),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.0)),
          ],
        ));
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    textController.dispose();
    super.dispose();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<SearchModel>(context).searchBook(category: widget.category);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: widget.onBackPress,
      child: Stack(
        children: <Widget>[
          Scaffold(
              key: _formKey,
              backgroundColor: Theme.of(context).backgroundColor,
              drawerEdgeDragWidth: 0,
              appBar: AppBar(
                backgroundColor: Theme.of(context).backgroundColor,
                leading: new IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: ImageIcon(
                      AssetImage('assets/icons/Back.png'),
                      color: kTeal50,
                    )),
                title: Container(
                  width: screenSize.width,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Container(
                      width: screenSize.width /
                          (2 / (screenSize.height / screenSize.width)),
                      child: Text(
                        widget.category,
                        style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            color: kTeal50),
                      ),
                    ),
                  ),
                ),
              ),
              body: ListenableProvider.value(
                value: Provider.of<SearchModel>(context),
                child: SafeArea(
                  child: Column(
                    children: <Widget>[
                      Container(),
                      Container(
                        width: screenSize.width,
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: Container(
                            width: screenSize.width /
                                (1.9 / (screenSize.height / screenSize.width)),
                            child: Row(children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    //color: Theme.of(context).accentColor,
                                    // color: Theme.of(context).primaryColorLight,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      //SizedBox(width: 10),
                                      Expanded(
                                          child: Container(
                                              margin: EdgeInsets.only(
                                                  left: 10,
                                                  right: 10,
                                                  bottom: 5),
                                              height: 50,
                                              width: 300,
                                              child: Center(
                                                child: TextField(
                                                  controller: textController,
                                                  focusNode: _focus,
                                                  onChanged: (text) {
                                                    if (_timer != null) {
                                                      _timer.cancel();
                                                    }
                                                    _timer = Timer(
                                                        Duration(
                                                            milliseconds: 1000),
                                                        () {
                                                      setState(() {
                                                        searchText = text;
                                                        if (searchText == "") {
                                                          ifsearchEmpty = true;
                                                        }
                                                      });
                                                      FocusScope.of(context)
                                                          .requestFocus(
                                                              FocusNode());
                                                      Provider.of<SearchModel>(
                                                              context)
                                                          .searchBook(
                                                              name: text,
                                                              category: widget
                                                                  .category,
                                                              nextPage:
                                                                  SearchScreen
                                                                      .nextPage);
                                                    });
                                                  },
                                                  decoration: InputDecoration(
                                                      fillColor:
                                                          Theme.of(context)
                                                              .backgroundColor,
                                                      //border: InputBorder.none,
                                                      hintText: "Search",
                                                      border: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          borderSide: BorderSide(
                                                              color: Color(
                                                                  0xFF252525))),
                                                      prefixIcon: Container(
                                                        //child:SvgPicture.asset("assets/User.svg",),
                                                        child:
                                                            Icon(Icons.search),
                                                      ),
                                                      suffixIcon:
                                                          AnimatedContainer(
                                                        width: (searchText ==
                                                                    null ||
                                                                searchText
                                                                    .isEmpty)
                                                            ? 0
                                                            : 50,
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              searchText = "";
                                                              isVisibleSearch =
                                                                  false;
                                                            });
                                                            textController
                                                                .text = "";
                                                            // FocusScope.of(context)
                                                            //     .requestFocus(
                                                            //         new FocusNode());
                                                          },
                                                          child: Center(
                                                              child: Icon(
                                                                  Icons.cancel,
                                                                  color: (searchText ==
                                                                              null ||
                                                                          searchText
                                                                              .isEmpty)
                                                                      ? Colors
                                                                          .transparent
                                                                      : Colors
                                                                          .black45)),
                                                        ),
                                                        duration: Duration(
                                                            milliseconds: 200),
                                                      )),
                                                ),
                                              ))),
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ),
                      Expanded(child: _renderSearchLayout(context)),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}
