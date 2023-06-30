import 'package:flutter/material.dart';

class ButonUrmatoareaProgramare extends StatelessWidget {
  final String ora;
  final String data;
  const ButonUrmatoareaProgramare(
      {super.key, required this.data, required this.ora});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 100,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color.fromARGB(255, 243, 68, 68)),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.fromLTRB(15, 10, 10, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Icon(Icons.calendar_month_outlined,
                          color: Colors.white, size: 30),
                      SizedBox(width: 8),
                      Text(data,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(children: [
                    Icon(
                      Icons.access_time_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                    SizedBox(width: 8),
                    Text(
                      ora,
                      style: TextStyle(
                          fontSize: 23,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )
                  ])
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_forward_ios,
                  size: 50,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
