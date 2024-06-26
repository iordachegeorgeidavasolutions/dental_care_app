import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class EducatieScreen extends StatefulWidget {
  @override
  _EducatieScreenState createState() => new _EducatieScreenState();
}

class _EducatieScreenState extends State<EducatieScreen> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  late PullToRefreshController pullToRefreshController;
  //String url = "https://www.dentocare.ro"; //old Andrei Bădescu
  String url = "https://app.dentocare.ro";
  
  double progress = 0;
  final urlController = TextEditingController();

  @override
  void initState() {
    super.initState();

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: <Widget>[
      // TextField(
      //   // decoration: InputDecoration(prefixIcon: Icon(Icons.search)),
      //   controller: urlController,
      //   keyboardType: TextInputType.url,
      //   onSubmitted: (value) {
      //     var url = Uri.parse(value);
      //     if (url.scheme.isEmpty) {
      //       // url = Uri.parse("https://www.google.com/search?q=" + value);
      //     }
      //     webViewController?.loadUrl(urlRequest: URLRequest(url: url));
      //   },
      // ),

      //navigationButtons(), // old Andrei Bădescu

      Expanded(
        child: Stack(
          children: [
            InAppWebView(
              key: webViewKey,
              //initialUrlRequest: URLRequest(url: Uri.parse("https://www.dentocare.ro")), //old Andrei Bădescu
              initialUrlRequest: URLRequest(url: Uri.parse('https://app.dentocare.ro')),
              initialOptions: options,
              pullToRefreshController: pullToRefreshController,
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
              onLoadStart: (controller, url) {
                setState(() {
                  this.url = url.toString();
                  urlController.text = this.url;
                });
              },
              androidOnPermissionRequest: (controller, origin, resources) async {
                return PermissionRequestResponse(resources: resources, action: PermissionRequestResponseAction.GRANT);
              },
              shouldOverrideUrlLoading: (controller, navigationAction) async {
                var uri = navigationAction.request.url!;

                if (!["http", "https", "file", "chrome", "data", "javascript", "about"].contains(uri.scheme)) {
                  if (await canLaunchUrlString(url)) {
                    // Launch the App
                    await launchUrlString(
                      url,
                    );
                    // and cancel the request
                    return NavigationActionPolicy.CANCEL;
                  }
                }

                return NavigationActionPolicy.ALLOW;
              },
              onLoadStop: (controller, url) async {
                pullToRefreshController.endRefreshing();
                setState(() {
                  this.url = url.toString();
                  urlController.text = this.url;
                });
              },
              onLoadError: (controller, url, code, message) {
                pullToRefreshController.endRefreshing();
              },
              onProgressChanged: (controller, progress) {
                if (progress == 100) {
                  pullToRefreshController.endRefreshing();
                }
                setState(() {
                  this.progress = progress / 100;
                  urlController.text = this.url;
                });
              },
              onUpdateVisitedHistory: (controller, url, androidIsReload) {
                setState(() {
                  this.url = url.toString();
                  urlController.text = this.url;
                });
              },
              onConsoleMessage: (controller, consoleMessage) {
                print(consoleMessage);
              },
            ),
            progress < 1.0 ? LinearProgressIndicator(value: progress) : Container(),
          ],
        ),
      ),

      // ButtonBar(
      //   alignment: MainAxisAlignment.center,
      //   children: <Widget>[
      //     ElevatedButton(
      //       child: Icon(Icons.arrow_back),
      //       onPressed: () {
      //         webViewController?.goBack();
      //       },
      //     ),
      //     ElevatedButton(
      //       child: Icon(Icons.arrow_forward),
      //       onPressed: () {
      //         webViewController?.goForward();
      //       },
      //     ),
      //     ElevatedButton(
      //       child: Icon(Icons.refresh),
      //       onPressed: () {
      //         webViewController?.reload();
      //       },
      //     ),
      //   ],
      // ),
    ])));
  }

  /* //old Andrei Bădescu
  Container navigationButtons() {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )),
      child: 
      //Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [ //old Andrei Bădescu
      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        //old Andrei Bădescu
        /*
        IconButton(
            onPressed: () {
              webViewController?.goBack();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        IconButton(
          onPressed: () {
            webViewController?.goForward();
          },
          icon: Icon(
            Icons.arrow_forward_ios,
            color: Colors.black,
          ),
        ),
        IconButton(
          onPressed: () {
            webViewController?.reload();
          },
          icon: Icon(
            Icons.refresh,
            color: Colors.black,
          ),
        ),
        */
      ]),
    );
  }
  */
}
