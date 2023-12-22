import 'package:flutter/material.dart';

class MeniuGridItem extends StatelessWidget {
  final String nume;
  final String image;
  const MeniuGridItem({super.key, required this.nume, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //image != ''? 
                  Image.asset(
                    image,
                    height: 31,
                  )
                  /*
                  :
                  Icon(
                    Icons.info,
                    size: 31,
                  ),
                  */
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    nume,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 20),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
