import 'package:flutter/material.dart';
import 'package:ignite_demo/models/searchModel.dart';
import 'package:provider/provider.dart';
import 'screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _search = SearchModel();
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => _search)],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            fontFamily: 'Montserrat',
          ),
          home: MyHomePage(),
          routes: <String, WidgetBuilder>{
            "/home": (context) => MyHomePage(),
          },
        ));
  }
}
