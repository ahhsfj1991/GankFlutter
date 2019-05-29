import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewPage extends StatefulWidget {
  const WebviewPage({Key key, this.url});
  final String url;

  @override
  State<StatefulWidget> createState() {
    return WebviewState();
  }
}

class WebviewState extends State<WebviewPage> {
  String url;

  @override
  void initState() {
    super.initState();
    url = widget.url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: WebView(
                initialUrl: url,
                javascriptMode: JavascriptMode.unrestricted,
              ),
            )
          ],
        ),
      ),
    );
  }
}
