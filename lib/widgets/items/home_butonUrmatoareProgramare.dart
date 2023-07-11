import 'package:dental_care_app/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../utils/api_call_functions.dart';
import '../../utils/classes.dart';

class ButonUrmatoareaProgramare extends StatefulWidget {
  const ButonUrmatoareaProgramare({super.key});

  @override
  State<ButonUrmatoareaProgramare> createState() => _ButonUrmatoareaProgramareState();
}

class _ButonUrmatoareaProgramareState extends State<ButonUrmatoareaProgramare> {
  ApiCallFunctions apiCallFunctions = ApiCallFunctions();
  late Programare ultimaProgramareP;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 100,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)), color: Color.fromARGB(255, 243, 68, 68)),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.calendar_month_outlined, color: Colors.white, size: 30),
                      const SizedBox(width: 8),
                      Text(DateFormat('EEEE, d.M.yyyy', 'ro').format(ultimaProgramareP.inceput).capitalizeFirst(),
                          style: const TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(children: [
                    const Icon(
                      Icons.access_time_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      DateFormat.jm().format(ultimaProgramareP.inceput),
                      style: const TextStyle(fontSize: 23, color: Colors.white, fontWeight: FontWeight.bold),
                    )
                  ])
                ],
              ),
            ),
          ),
          const Expanded(
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

  loadData() async {
    Programari? ultimaProgramare = await apiCallFunctions.getListaProgramari();
    if (ultimaProgramare != null) {
      setState(() {
        ultimaProgramareP = ultimaProgramare.viitoare[ultimaProgramare.viitoare.length - 1];
      });
    }
  }
}
