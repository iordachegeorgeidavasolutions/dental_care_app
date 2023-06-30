import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class EducatieScreen extends StatefulWidget {
  const EducatieScreen({super.key});

  @override
  State<EducatieScreen> createState() => _EducatieScreenState();
}

class _EducatieScreenState extends State<EducatieScreen> {
  final url = "https://www.google.com";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 236, 236, 236),
      ),
      body: InAppWebView(initialUrlRequest: URLRequest(url: Uri.parse(url))),
    );
  }
}
