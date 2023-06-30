import 'package:flutter/material.dart';

class ServiciuItem extends StatelessWidget {
  final String nume;
  final String image;
  const ServiciuItem({super.key, required this.nume, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        margin: const EdgeInsets.all(10),
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              image,
              height: 70,
            ),
            Text(
              nume,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ));
  }
}
