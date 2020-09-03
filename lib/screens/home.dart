import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ignite_demo/common/genariclistitem.dart';
import 'package:ignite_demo/common/style.dart';
import 'package:after_layout/after_layout.dart';
import 'package:ignite_demo/screens/search.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with AfterLayoutMixin {
  @override
  void afterFirstLayout(BuildContext context) {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        color: backgroundColor,
        child: Column(
          children: <Widget>[
            Container(
              //margin: const EdgeInsets.only(left: 12.0, right: 12.0),
              height: MediaQuery.of(context).size.height / 2.5,
              decoration: BoxDecoration(
                  color: backgroundColor,
                  image: DecorationImage(
                    image: new AssetImage("assets/icons/Pattern.png"),
                    fit: BoxFit.cover,
                  )),
              child: Container(
                  margin: const EdgeInsets.only(left: 12.0, right: 12.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                            child: Text("Gutenberg Project",
                                style: TextStyle(
                                    fontSize: 48,
                                    color: kTeal50,
                                    fontWeight: FontWeight.w600))),
                        Center(
                            child: Text(
                                "A social cataloging website that allows you to freely search its database of books, annotations, and reviews.",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600)))
                      ])),
            ),
            GenericListItem(
              context: context,
              heading: 'FICTION',
              trailing: null,
              iconData: Image.asset("assets/icons/Fiction.png"),
              forwordIconData: Image.asset("assets/icons/Next.png"),
              onTap: navigateToSearchScreen,
            ),
            GenericListItem(
              context: context,
              heading: 'DRAMA',
              trailing: null,
              iconData: Image.asset("assets/icons/Drama.png"),
              forwordIconData: Image.asset("assets/icons/Next.png"),
              onTap: navigateDRAMAToSearchScreen,
            ),
            GenericListItem(
              context: context,
              heading: 'HUMOR',
              trailing: null,
              iconData: Image.asset("assets/icons/Humour.png"),
              forwordIconData: Image.asset("assets/icons/Next.png"),
              onTap: navigateFromHUMORtoSearchScreen,
            ),
            GenericListItem(
              context: context,
              heading: 'POLITICS',
              trailing: null,
              iconData: Image.asset("assets/icons/Politics.png"),
              forwordIconData: Image.asset("assets/icons/Next.png"),
              onTap: navigatePOLITICSToSearchScreen,
            ),
            GenericListItem(
              context: context,
              heading: 'PHILOSOPHY',
              trailing: null,
              iconData: Image.asset("assets/icons/Philosophy.png"),
              forwordIconData: Image.asset("assets/icons/Next.png"),
              onTap: navigatePHILOSOPHYToSearchScreen,
            ),
            GenericListItem(
              context: context,
              heading: 'HISTORY',
              trailing: null,
              iconData: Image.asset("assets/icons/History.png"),
              forwordIconData: Image.asset("assets/icons/Next.png"),
              onTap: navigateFromHistoryToSearchScreen,
            ),
            GenericListItem(
              context: context,
              heading: 'ADVENTURE',
              trailing: null,
              iconData: Image.asset("assets/icons/Adventure.png"),
              forwordIconData: Image.asset("assets/icons/Next.png"),
              onTap: navigateADVENTUREToSearchScreen,
            ),
          ],
        ),
      ),
    ));
  }

  void navigateFromHUMORtoSearchScreen() {
    Navigator.push(this.context, MaterialPageRoute(builder: (context) {
      return SearchScreen(
        category: "Humor",
      );
    }));
  }

  void navigatePOLITICSToSearchScreen() {
    Navigator.push(this.context, MaterialPageRoute(builder: (context) {
      return SearchScreen(
        category: "Politics",
      );
    }));
  }

  void navigatePHILOSOPHYToSearchScreen() {
    Navigator.push(this.context, MaterialPageRoute(builder: (context) {
      return SearchScreen(
        category: "Philosophy",
      );
    }));
  }

  void navigateADVENTUREToSearchScreen() {
    Navigator.push(this.context, MaterialPageRoute(builder: (context) {
      return SearchScreen(
        category: "Adventure",
      );
    }));
  }

  void navigateDRAMAToSearchScreen() {
    Navigator.push(this.context, MaterialPageRoute(builder: (context) {
      return SearchScreen(
        category: "Drama",
      );
    }));
  }

  void navigateToSearchScreen() {
    Navigator.push(this.context, MaterialPageRoute(builder: (context) {
      return SearchScreen(
        category: "Fiction",
      );
    }));
  }

  void navigateFromHistoryToSearchScreen() {
    Navigator.push(this.context, MaterialPageRoute(builder: (context) {
      return SearchScreen(
        category: "History",
      );
    }));
  }
}
