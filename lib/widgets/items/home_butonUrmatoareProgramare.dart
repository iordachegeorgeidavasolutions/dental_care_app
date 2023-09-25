import 'package:dental_care_app/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ButonUrmatoareaProgramare extends StatefulWidget {
  final DateTime numeZiUltimaProg;
  final DateTime oraInceputUltimaProg;
  const ButonUrmatoareaProgramare({super.key, required this.numeZiUltimaProg, required this.oraInceputUltimaProg});

  @override
  State<ButonUrmatoareaProgramare> createState() => _ButonUrmatoareaProgramareState();
}

class _ButonUrmatoareaProgramareState extends State<ButonUrmatoareaProgramare> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(30, 20, 20, 10),
          child: Row(children: [
            Text('Urmatoarea programare : ', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))
          ]),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height * 0.16,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)), color: Color.fromARGB(255, 243, 68, 68)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 15, 0, 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.calendar_month_outlined, color: Colors.white, size: 30),
                              const SizedBox(width: 8),
                              Text(DateFormat('EEEE, d.M.yyyy', 'ro').format(widget.numeZiUltimaProg).capitalizeFirst(),
                                  style:
                                      const TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold)),
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
                              DateFormat.jm().format(widget.oraInceputUltimaProg),
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
            ],
          ),
        ),
      ],
    );
  }

  // loadData() async {
  //   Programari? ultimaProgramare = await apiCallFunctions.getListaProgramari();
  //   ultimaProgramareP = ultimaProgramare!.viitoare[ultimaProgramare.viitoare.length - 1];
  // }
}
