import 'package:dental_care_app/pages/create_appointment.dart';
import 'package:flutter/material.dart';

class ButtonNoUpcomingAppointments extends StatelessWidget {
  const ButtonNoUpcomingAppointments({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(30, 20, 20, 10),
          child: Row(
              children: [Text('Urmatoarea programare :', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))]),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const CreateAppointmentScreen(),
            ));
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height: 60,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)), color: Color.fromARGB(255, 243, 68, 68)),
            child: const Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Row(children: [
                          SizedBox(width: 8),
                          Text('Solicita o programare',
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                        ])
                      ])),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Icon(Icons.arrow_forward_ios, size: 35, color: Colors.white)],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
