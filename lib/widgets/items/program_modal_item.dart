import 'package:flutter/material.dart';
import '../../data/programari_data.dart';

class ProgramModalItem extends StatelessWidget {
  final int selectedIndex;
  const ProgramModalItem({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tratament:",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(programariList[selectedIndex].tratament,
                              maxLines: 9,
                              style: const TextStyle(fontSize: 18)),
                        ]),
                  ),
                ],
              ),
              const Divider(color: Colors.black12, thickness: 2),
              const SizedBox(height: 20),
            ],
          ),
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ora:",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(programariList[selectedIndex].ora,
                              maxLines: 9,
                              style: const TextStyle(fontSize: 18)),
                        ]),
                  ),
                ],
              ),
              const Divider(color: Colors.black12, thickness: 2),
              const SizedBox(height: 20),
            ],
          ),
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Data:",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(programariList[selectedIndex].data,
                              maxLines: 9,
                              style: const TextStyle(fontSize: 18)),
                        ]),
                  ),
                ],
              ),
              const Divider(color: Colors.black12, thickness: 2),
              const SizedBox(height: 20),
            ],
          ),
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Locatie:",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(programariList[selectedIndex].locatie,
                              maxLines: 9,
                              style: const TextStyle(fontSize: 18)),
                        ]),
                  ),
                ],
              ),
              const Divider(color: Colors.black12, thickness: 2),
              const SizedBox(height: 20),
            ],
          ),
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Financiar:",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(programariList[selectedIndex].financiar,
                              maxLines: 9,
                              style: const TextStyle(fontSize: 18)),
                        ]),
                  ),
                ],
              ),
              const Divider(color: Colors.black12, thickness: 2),
              const SizedBox(height: 20),
            ],
          ),
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Doctor:",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(programariList[selectedIndex].doctor,
                              maxLines: 9,
                              style: const TextStyle(fontSize: 18)),
                        ]),
                  ),
                ],
              ),
              const Divider(color: Colors.black12, thickness: 2),
              const SizedBox(height: 30),
              programariModalButtons(context),
            ],
          ),
        ],
      ),
    );
  }

  Column programariModalButtons(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                backgroundColor: Colors.red,
                // minimumSize: const Size.fromHeight(50), // NEW
              ),
              onPressed: () {
                showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            SizedBox(height: 40),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Confirmare",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold)),
                                ]),
                            SizedBox(height: 20),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      "Prin apasarea butonului 'Confirm', confirmati ca ca veti ajunge la programarea stabilita.",
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 16))
                                ]),
                            SizedBox(height: 20),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Va multumim!",
                                      style: TextStyle(fontSize: 18)),
                                ]),
                            SizedBox(height: 60),
                            IntrinsicWidth(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding:
                                          EdgeInsets.fromLTRB(30, 10, 30, 10),
                                      backgroundColor: Colors.red,
                                      // minimumSize: const Size.fromHeight(50), // NEW
                                    ),
                                    onPressed: () => {},
                                    child: const Text(
                                      'Confirm',
                                      style: TextStyle(fontSize: 24),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(
                                          color: Colors.red, width: 1),
                                      padding:
                                          EdgeInsets.fromLTRB(30, 10, 30, 10),
                                      backgroundColor: Colors.white,
                                      // minimumSize: const Size.fromHeight(50), // NEW
                                    ),
                                    onPressed: () => {},
                                    child: const Text(
                                      'Nu confirm',
                                      style: TextStyle(
                                          fontSize: 24, color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: const Text(
                'Confirma programarea',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                backgroundColor: const Color.fromARGB(255, 218, 215, 215),
                // minimumSize: const Size.fromHeight(50), // NEW
              ),
              onPressed: () {
                showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            SizedBox(height: 40),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Atentie!",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold)),
                                ]),
                            SizedBox(height: 20),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      "Doriti anularea programarii. Trebuie avut in vedere faptul ca timpul si locurile sunt limitate si astfel este posibil sa nu gasiti un interval orar disponibil in perioada imediat urmatoare.",
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 16))
                                ]),
                            SizedBox(height: 60),
                            IntrinsicWidth(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding:
                                          EdgeInsets.fromLTRB(30, 10, 30, 10),
                                      backgroundColor: Colors.red,
                                      // minimumSize: const Size.fromHeight(50), // NEW
                                    ),
                                    onPressed: () => {},
                                    child: const Text(
                                      'Anulez',
                                      style: TextStyle(fontSize: 24),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(
                                          color: Colors.red, width: 1),
                                      padding:
                                          EdgeInsets.fromLTRB(30, 10, 30, 10),
                                      backgroundColor: Colors.white,
                                      // minimumSize: const Size.fromHeight(50), // NEW
                                    ),
                                    onPressed: () => {},
                                    child: const Text(
                                      'Nu Anulez',
                                      style: TextStyle(
                                          fontSize: 24, color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: const Text(
                'Anuleaza programarea',
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
