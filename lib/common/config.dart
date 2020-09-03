import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const serverConfig = {
  "url": "http://skunkworks.ignitesol.com:8000/books​ ",
};
Widget kLoadingWidget(context) => Center(
      child: SpinKitFadingCube(
        color: Theme.of(context).primaryColor,
        size: 30.0,
      ),
    );
