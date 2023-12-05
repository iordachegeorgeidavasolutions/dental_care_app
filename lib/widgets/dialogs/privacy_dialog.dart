import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class PrivacyDialog extends StatelessWidget {
  const PrivacyDialog({super.key, required this.mdFileName, required this.radius});
  final String mdFileName;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      child: Column(children: [
        Expanded(
          child: FutureBuilder(
            future: Future.delayed(const Duration(milliseconds: 150)).then((value) {
              return rootBundle.loadString('assets/terms&conditions/$mdFileName');
            }),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Markdown(data: snapshot.data!);
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(
              // backgroundColor: Colors.black,
              ),
          child: Text(
            'Am luat la cunoștință',
            style: TextStyle(color: Colors.red[400]),
          ),
        ),
      ]),
    );
  }
}
