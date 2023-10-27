import 'package:another_flushbar/flushbar.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import '../utils/api_call_functions.dart';
import '../utils/classes.dart';

class CreateAppointmentScreen extends StatefulWidget {
  const CreateAppointmentScreen({super.key});

  @override
  State<CreateAppointmentScreen> createState() => _CreateAppointmentScreenState();
}

class _CreateAppointmentScreenState extends State<CreateAppointmentScreen> {
  // String? _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  ApiCallFunctions apiCallFunctions = ApiCallFunctions();
  final controllerStartDate = TextEditingController();
  final controllerEndDate = TextEditingController();
  var controllerDatePicker = DatePickerController();
  final controllerDetails = TextEditingController();
  // final List<String> sedii = ["Coltea", "Virtutii", "Minulescu", "Lujerului"];
  // String _startTime = "8:00 AM";
  // String _endTime = "8:00 PM";
  String? selectedItem;
  List<Sediu>? listaSedii;
  List<String>? listaNumeSedii;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    List<Sediu> s = await apiCallFunctions.getListaSedii();
    List<String> ss = createOfficeNameList(s);
    print(s);
    setState(() {
      listaSedii = s;
      listaNumeSedii = ss;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Solicita o programare"), backgroundColor: Colors.black, centerTitle: true),
      // backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(children: [
              IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  color: Colors.black,
                  onPressed: () => Navigator.pop(context)),
              GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Text("Înapoi",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black)))
            ]),
            const SizedBox(height: 20),
            const Center(
                child: Text(
              "Solicită o programare",
              style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.w500),
            )),
            const SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              // height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                color: Color.fromARGB(255, 236, 236, 236),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        DropdownButton<String>(
                          value: selectedItem,
                          hint: const Text("Alegeti o locatie"),
                          items: listaNumeSedii == null
                              ? []
                              : listaNumeSedii!.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedItem = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  // DO NOT DELETE

                  // Elements from the previous version of this screen, where you could select a Day and a time frame
                  // const SizedBox(height: 40),
                  // const Row(
                  //   children: [Text("Alegeti o data", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22))],
                  // ),
                  // const SizedBox(height: 10),
                  // Container(
                  //   decoration: BoxDecoration(
                  //       border: Border.all(
                  //         width: 2.0,
                  //         color: Colors.white,
                  //       ),
                  //       borderRadius: BorderRadius.circular(12.0)),
                  //   child: DatePicker(
                  //     DateTime.now(),
                  //     initialSelectedDate: DateTime.now(),
                  //     selectionColor: Colors.red.shade500,
                  //     controller: controllerDatePicker,
                  //     locale: 'ro',
                  //   ),
                  // ),
                  // const SizedBox(height: 20),
                  // const Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Text("Selectati un interal orar", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22))
                  //   ],
                  // ),
                  // Row(
                  //   // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     Expanded(
                  //       child: InputField(
                  //           controller: controllerStartDate,
                  //           hint: _startTime,
                  //           title: 'Pick a date',
                  //           // width: MediaQuery.of(context).size.width * 0.5,
                  //           widget: IconButton(
                  //               icon: const Icon(Icons.alarm_add_outlined),
                  //               onPressed: () {
                  //                 _getTimeFromUser(isStartTime: true);
                  //               })),
                  //     ),
                  //     const SizedBox(width: 10),
                  //     Expanded(
                  //       child: InputField(
                  //           controller: controllerEndDate,
                  //           hint: _endTime,
                  //           title: 'Pick a date',
                  //           // width: MediaQuery.of(context).size.width * 0.5,
                  //           widget: IconButton(
                  //               icon: const Icon(Icons.alarm_add_outlined),
                  //               onPressed: () {
                  //                 _getTimeFromUser(isStartTime: false);
                  //               })),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(height: 20),
                  const Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Text("Adaugati detalii", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22))
                  ]),
                  const SizedBox(height: 10),
                  TextField(
                    controller: controllerDetails,
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    decoration: const InputDecoration(
                        hintText: " ",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[400],
                      minimumSize: const Size.fromHeight(50), // NEW
                    ),
                    onPressed: () {
                      sendAppointmentRequest().then((value) {
                        value == null
                            ? null
                            : value == "13"
                                ? Future.delayed(Duration(seconds: 3), () {
                                    Navigator.of(context).pop();
                                  })
                                : null;
                      });
                    },
                    child: const Text(
                      'Trimite solicitarea',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  // DO NOT DELETE

  // _getTimeFromUser({required bool isStartTime}) async {
  //   var pickedTime = await _showTimePicker();
  //   String formattedTime = pickedTime.format(context);
  //   if (pickedTime == null) {
  //     // ignore: avoid_print
  //     print("Time cancelled");
  //   } else if (isStartTime) {
  //     setState(() {
  //       _startTime = formattedTime;
  //       controllerStartDate.text = formattedTime;
  //     });
  //   } else if (!isStartTime) {
  //     setState(() {
  //       _endTime = formattedTime;
  //       controllerEndDate.text = formattedTime;
  //     });
  //   }
  // }

  // _showTimePicker() {
  //   return showTimePicker(
  //     context: context,
  //     initialEntryMode: TimePickerEntryMode.input,
  //     initialTime: const TimeOfDay(hour: 8, minute: 00),
  //   );
  // }

  List<String> createOfficeNameList(List<Sediu>? asd) {
    List<String> futureList = [];
    if (asd == null) {
      // ignore: avoid_print
      print("Empty list");
      return [];
    }
    for (var i = 0; i < asd.length; i++) {
      futureList.add(asd[i].denumire);
    }
    return futureList;
  }

  Future<String?> sendAppointmentRequest() async {
    if (controllerDetails.text.isEmpty) {
      Flushbar(
        message: "Adaugati cateva detalii!",
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.red[400],
        ),
        borderColor: Colors.red[400],
        borderWidth: 2,
        isDismissible: false,
        margin: const EdgeInsets.all(6.0),
        flushbarStyle: FlushbarStyle.FLOATING,
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(12),
        duration: const Duration(seconds: 3),
        leftBarIndicatorColor: Colors.red[400],
      ).show(context);
      return null;
    }
    // } else if (controllerDatePicker.toString().isEmpty) {
    //   print("error 2");
    //   return;
    // }
    // } else if (controllerEndDate.text.isEmpty) {
    //   controllerStartDate.text = _startTime;
    //   print("error 3");
    // } else if (controllerStartDate.text.isEmpty) {
    //   controllerStartDate.text = _endTime;
    //   print("error 4");
    // }
    // TO-DO : implement snackbar message please fill all the fields
    else {
      String? res = await apiCallFunctions.adaugaProgramare(
          pIdCategorie: '',
          pIdMedic: '',
          pDataProgramareDDMMYYYYHHmm: controllerDatePicker.toString(),
          pObservatiiProgramare: controllerDetails.text,
          pIdSediu: '',
          pIdMembruFamilie: '');
      // ignore: avoid_print
      print(res);

      if (res!.startsWith("13")) {
        Flushbar(
          message: "Cerere trimisa cu succes!",
          icon: const Icon(
            Icons.info_outline,
            size: 28.0,
            color: Colors.green,
          ),
          borderColor: Colors.green,
          borderWidth: 2,
          isDismissible: false,
          margin: const EdgeInsets.all(6.0),
          flushbarStyle: FlushbarStyle.FLOATING,
          flushbarPosition: FlushbarPosition.BOTTOM,
          borderRadius: BorderRadius.circular(12),
          duration: const Duration(seconds: 3),
          leftBarIndicatorColor: Colors.green,
        ).show(context);
        return "13";
      }
      return "eroare";
    }
  }
}
