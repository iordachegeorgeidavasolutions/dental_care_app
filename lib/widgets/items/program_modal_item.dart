// ignore_for_file: sized_box_for_whitespace
import 'package:dental_care_app/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../utils/classes.dart';
import '../../utils/api_call_functions.dart';

class ProgramModalItem extends StatefulWidget {
  final Programare? programare;
  const ProgramModalItem({super.key, required this.programare});

  @override
  State<ProgramModalItem> createState() => _ProgramModalItemState();
}

class _ProgramModalItemState extends State<ProgramModalItem> {
  bool isDisabled = false;
  ApiCallFunctions apiCallFunctions = ApiCallFunctions();
  void disableButtons() {
    setState(() {
      isDisabled = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.programare == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Container(
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
                          child: const Column(
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
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(
                                DateFormat('EEEE, d.M.yyyy', 'ro').format(widget.programare!.inceput).capitalizeFirst(),
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
                                "Ora:",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(DateFormat.jm().format(widget.programare!.inceput),
                                maxLines: 9, style: const TextStyle(fontSize: 18)),
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
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(widget.programare!.nume, maxLines: 9, style: const TextStyle(fontSize: 18)),
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
                                "Status:",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(widget.programare!.status, maxLines: 9, style: const TextStyle(fontSize: 18)),
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
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(widget.programare!.idPacient, maxLines: 9, style: const TextStyle(fontSize: 18)),
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
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(widget.programare!.medic, maxLines: 9, style: const TextStyle(fontSize: 18)),
                          ]),
                        ),
                      ],
                    ),
                    const Divider(color: Colors.black12, thickness: 2),
                    const SizedBox(height: 30),
                    programariModalButtons(context, apiCallFunctions, isDisabled),
                  ],
                ),
              ],
            ),
          );
  }

  Column programariModalButtons(BuildContext context, ApiCallFunctions apiCallFunctions, isDisabled) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: isDisabled
                  ? ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(40, 15, 40, 15), backgroundColor: Colors.grey)
                  : ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                      backgroundColor: Colors.red,
                      // minimumSize: const Size.fromHeight(50), // NEW
                    ),
              onPressed: () {
                isDisabled
                    ? null
                    : showModalBottomSheet(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
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
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  const SizedBox(height: 40),
                                  const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                    Text("Confirmare", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                                  ]),
                                  const SizedBox(height: 20),
                                  const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                    Text(
                                        "Prin apasarea butonului 'Confirm', confirmati ca ca veti ajunge la programarea stabilita.",
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 16))
                                  ]),
                                  const SizedBox(height: 20),
                                  const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                    Text("Va multumim!", style: TextStyle(fontSize: 18)),
                                  ]),
                                  const SizedBox(height: 60),
                                  IntrinsicWidth(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                                            backgroundColor: Colors.red,
                                            // minimumSize: const Size.fromHeight(50), // NEW
                                          ),
                                          onPressed: () => {
                                            isDisabled ? null : print(widget.programare!.id),
                                            apiCallFunctions.confirmaProgramarea(widget.programare!.id),
                                            disableButtons,
                                            // Navigator.pop(context),
                                          },
                                          child: const Text(
                                            'Confirm',
                                            style: TextStyle(fontSize: 24),
                                          ),
                                        ),
                                        const SizedBox(height: 30),
                                        OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                            side: const BorderSide(color: Colors.red, width: 1),
                                            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                                            backgroundColor: Colors.white,
                                            // minimumSize: const Size.fromHeight(50), // NEW
                                          ),
                                          onPressed: () => {},
                                          child: const Text(
                                            'Nu confirm',
                                            style: TextStyle(fontSize: 24, color: Colors.red),
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
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
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
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            const SizedBox(height: 40),
                            const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                              Text("Atentie!", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                            ]),
                            const SizedBox(height: 20),
                            const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                              Text(
                                  "Doriti anularea programarii. Trebuie avut in vedere faptul ca timpul si locurile sunt limitate si astfel este posibil sa nu gasiti un interval orar disponibil in perioada imediat urmatoare.",
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16))
                            ]),
                            const SizedBox(height: 60),
                            IntrinsicWidth(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                                      backgroundColor: Colors.red,
                                      // minimumSize: const Size.fromHeight(50), // NEW
                                    ),
                                    onPressed: () => {
                                      print(widget.programare!.id),
                                      apiCallFunctions.anuleazaProgramarea(widget.programare!.id),
                                      Navigator.pop(context),
                                    },
                                    child: const Text(
                                      'Anulez',
                                      style: TextStyle(fontSize: 24),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(color: Colors.red, width: 1),
                                      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                                      backgroundColor: Colors.white,
                                      // minimumSize: const Size.fromHeight(50), // NEW
                                    ),
                                    onPressed: () => {
                                      Navigator.pop(context),
                                    },
                                    child: const Text(
                                      'Nu Anulez',
                                      style: TextStyle(fontSize: 24, color: Colors.red),
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
