import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebviewPage extends StatefulWidget {
  final String webUrl;
  WebviewPage({this.webUrl});
  @override
  _WebviewPageState createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.webUrl,
      withJavascript: true,
      withZoom: false,
      appBar: AppBar(
        title: Text("Flutter"),
        elevation: 1,
        actions: <Widget>[
          InkWell(
            child: Icon(Icons.refresh),
            onTap: () {
              flutterWebviewPlugin.reload();
              // flutterWebviewPlugin.reloadUrl("any link");
            },
          ),
        ],
      ),
    );
  }
}
