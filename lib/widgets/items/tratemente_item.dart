import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TratamenteItem extends StatelessWidget {
  final String doctor;
  final DateTime data;
  final String procedure;
  final String price;
  const TratamenteItem(
      {super.key, required this.doctor, required this.data, required this.procedure, required this.price});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat('yMd', 'ro').format(data),
                style: const TextStyle(color: Colors.red, fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text(
                doctor,
                style: const TextStyle(color: Colors.red, fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Divider(
            thickness: 2,
            color: Colors.black26,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  procedure,
                  style: const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w400),
                ),
              ),
              Text(
                price,
                style: const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w400),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
