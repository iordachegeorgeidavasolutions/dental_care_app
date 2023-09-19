import 'package:flutter/material.dart';

class DosarulMeuItem extends StatelessWidget {
  final String titlu;
  final Widget widgetRoute;

  const DosarulMeuItem({
    required this.titlu,
    required this.widgetRoute,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
          width: 100,
          padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
          decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(10), color: const Color.fromARGB(255, 236, 236, 236)),
          child: Center(
            child: Text(titlu, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.red)),
          )),
    );
  }
}
