import 'package:another_flushbar/flushbar.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
//import 'package:dental_care_app/screens/home.dart';
import 'package:flutter/material.dart';
import '../utils/api_call_functions.dart';
import '../utils/classes.dart';
import '../main.dart';

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

  bool solicitareNetrimisa = true;
  bool butonTrimiteSolicitare = true;

  @override
  void initState() {

    super.initState();
    loadData();
    solicitareNetrimisa = true;
    butonTrimiteSolicitare = true;

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
    return SingleChildScrollView(
      child: Container(
      height: MediaQuery.of(context).size.height * 0.95,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
        color: Colors.white,
      ),
      child: Padding(
      padding: const EdgeInsets.all(30),
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
            const SizedBox(height: 15),
            Container(
              height: MediaQuery.of(context).size.height*0.55,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 236, 236, 236),
              ), 
              padding: const EdgeInsets.symmetric(horizontal: 15),
              // height: MediaQuery.of(context).size.height,
              /*decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                color: Color.fromARGB(255, 236, 236, 236),
              ),
              */
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    const Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Text("Sediul dorit:", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18))
                    ]),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            //padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                color: Colors.white, borderRadius: BorderRadius.circular(10)),
                            width: MediaQuery.of(context).size.width*0.77,
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: selectedItem,
                              style: const TextStyle(color: Colors.black, fontSize: 18),
                              underline: SizedBox(),
                              hint: const Align(
                                alignment: Alignment.center,
                                child:Text("Alegeți o locație"),
                              ),
                              items: listaNumeSedii == null
                                  ? []
                                  : listaNumeSedii!.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Center(
                                          child: Text(value),
                                        ),  
                                      );
                                    }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedItem = value;
                                });
                              },
                            ),
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
                      Text("Adăugați detalii:", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18))
                    ]),
                    const SizedBox(height: 10),
                    TextField(
                      controller: controllerDetails,
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      decoration: const InputDecoration(
                          hintText: "Exemplu: Doresc programare pentru controlul periodic",
                          hintStyle: TextStyle(fontSize: 10),
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
                    solicitareNetrimisa && butonTrimiteSolicitare?
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[400],
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // <-- Radius
                        ), // NEW
                      ),
                      onPressed: () {
                
                        setState(() {
                        
                          butonTrimiteSolicitare = false;
                          solicitareNetrimisa = true;  
                        
                        });
                        
                        sendAppointmentRequest().then((value) {
                          value == null
                            ? null
                            : value == "13" ? 
                                solicitareNetrimisa = false
                                : solicitareNetrimisa = true;
                              if(solicitareNetrimisa == false)
                              {
                                showSuccesAlertDialog(context);
                              }  
                              else if (solicitareNetrimisa == true)
                              {
                                showErrorAlertDialog(context);
                              }
                              //Navigator.of(context).pop():
                                
                              /*
                              Future.delayed(Duration(seconds: 3), () {
                                  Navigator.of(context).pop();
                                });
                              */
                              //null;

                        });
                      },
                      child: const Text(
                        'Trimite solicitarea',
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ):
                    /*!butonTrimiteSolicitare && !solicitareNetrimisa? 
                    SizedBox(
                      child: const Text(
                        'Solicitarea a fost trimisa cu succes',
                        style: TextStyle(fontSize: 24),
                      ),):
                    !butonTrimiteSolicitare && solicitareNetrimisa? 
                    */
                    SizedBox(
                      child: const Text(
                        'Solicitarea se adaugă',
                        style: TextStyle(fontSize: 24),
                      ),),
                    /*  :
                    SizedBox(
                      child: const Text(
                        'A apărut o eroare la adăugarea solicitării',
                        style: TextStyle(fontSize: 24),
                      ),),
                    */
                  ],
                ),
              ),
            ),
          ],
        ),
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
    //old Andrei Bădescu

    
    if (selectedItem == null) {
      
      solicitareNetrimisa = true;
      butonTrimiteSolicitare = true;
      /*
      Flushbar(
        message: "Alegeți un sediu!",
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
      */
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
    
    else { //old Andrei Bădescu
      
      String? res = await apiCallFunctions.adaugaProgramare(
          pIdCategorie: '',
          pIdMedic: '',
          pDataProgramareDDMMYYYYHHmm: controllerDatePicker.toString(),
          pObservatiiProgramare: controllerDetails.text,
          pIdSediu: selectedItem!,
          pIdMembruFamilie: '');
      // ignore: avoid_print
      print(res);

      if (res!.startsWith("13")) {
        
        /*
        Flushbar(
          message: "Cerere trimisă cu succes!",
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
        */

        setState(() {

          solicitareNetrimisa = false;
          butonTrimiteSolicitare = false;

        });

        return "13";

      }

      else
      { 
        setState(() {
          solicitareNetrimisa = true;
          butonTrimiteSolicitare = true;
        });

        return "eroare";

      }
    }
  }
}

showSuccesAlertDialog(BuildContext context) {

  // set up the buttons
  Widget logInButton = TextButton(
    child: Text("Închide", 
      style: TextStyle(color: Colors.black),
    ),
    onPressed:  () {
      //Future.delayed(Duration(seconds: 1), () {
          Navigator.of(context)
              .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MyApp(fromPinPage: false,)), (route) => false);
        //});
    },
  );
  /*
  Widget cancelButton = TextButton(
    child: Text("Anulează"),
    onPressed:  () {
      //Navigator.of(context).pop();
      Navigator.of(context)
              .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MyApp()), (route) => false);
    },
  );
  */
  /*
  Widget launchButton = TextButton(
    child: Text("Launch missile"),
    onPressed:  () {},
  );
  */

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Center(child: Text("Succes")),
    content: Text("Solicitarea de programare a fost trimsă cu succes. În cel mai scurt timp veți fi contactat de către un operator pentru a stabili data și ora programării. Vă mulțumim!",
      textAlign: TextAlign.center,),
    actions: [
      logInButton,
      //cancelButton,
    ],
    actionsAlignment: MainAxisAlignment.center,
  );

  // show the dialog
  showDialog(

    context: context,
    builder: (BuildContext context) {
      return alert;
    },

  );
}

showErrorAlertDialog(BuildContext context) {

  Widget okButton = TextButton(
    child: Text("Ok", 
      style: TextStyle(color: Colors.black),
    ),
    onPressed:  () {
      Navigator.of(context).pop();
    },
  );
  /*
  Widget launchButton = TextButton(
    child: Text("Launch missile"),
    onPressed:  () {},
  );
  */

  // set up the AlertDialog
  AlertDialog alertError = AlertDialog(
    title: Text("Eroare"),
    content: Text("Vă rugăm completați cererea cu un sediu și dacă este cazul cu câteva detalii despre programare!"),
    actions: [
      //logInButton,
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alertError;
    },
  );
}