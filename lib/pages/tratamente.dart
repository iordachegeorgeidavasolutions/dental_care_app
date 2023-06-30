import 'package:flutter/material.dart';
import '../data/clienti_data.dart';
import '../widgets/items/tratemente_item.dart';

class TratamenteScreen extends StatelessWidget {
  const TratamenteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 236, 236),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Image.asset('./assets/images/person-icon.jpg', height: 40),
                  const SizedBox(height: 10),
                  const Text('Tratamente',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold))
                ]),
              ],
            ),
          ),
          const SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: userList.length,
            itemBuilder: (context, index) {
              return const TratamenteItem();
            },
          )
        ],
      ),
    );
  }
}
