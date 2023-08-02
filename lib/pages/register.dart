// import 'package:flutter/cupertino.dart';
import 'package:dental_care_app/pages/home.dart';
import 'package:dental_care_app/widgets/dialogs/privacy_dialog.dart';

import '../utils/shared_pref_keys.dart' as pref_keys;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/api_call_functions.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

ApiCallFunctions apiCallFunctions = ApiCallFunctions();

class _RegisterScreenState extends State<RegisterScreen> {
  String? mtoken = " ";
  final registerKey = GlobalKey<FormState>();

  final controllerNume = TextEditingController();
  final controllerPrenume = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerTelefon = TextEditingController();
  final controllerPass = TextEditingController();
  final controllerPassConfirm = TextEditingController();
  final controllerBirthdate = TextEditingController();

  final FocusNode focusNodeNume = FocusNode();
  final FocusNode focusNodePrenume = FocusNode();
  final FocusNode focusNodeEmail = FocusNode();
  final FocusNode focusNodeTelefon = FocusNode();
  final FocusNode focusNodePass = FocusNode();
  final FocusNode focusNodePassConfirm = FocusNode();
  final FocusNode focusNodeBirthdate = FocusNode();

  String? errorEmail, errorTel, errorNume, errorPrenume, errorPass, errorPassConfirm, errorDDN, errorInfo = '';

  DateTime? dataNasterii;

  bool isHidden = true;
  @override
  void initState() {
    super.initState();
    // requestPermission();
    // getToken();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   final controllerNume = TextEditingController();
  //   final controllerPrenume = TextEditingController();
  //   final controllerEmail = TextEditingController();
  //   final controllerTelefon = TextEditingController();
  //   final controllerBirthdate = TextEditingController();
  //   final controllerPass = TextEditingController();
  //   final controllerPassConfirm = TextEditingController();

  //   final FocusNode focusNodeNume = FocusNode();
  //   final FocusNode focusNodePrenume = FocusNode();
  //   final FocusNode focusNodeEmail = FocusNode();
  //   final FocusNode focusNodeTelefon = FocusNode();
  //   final FocusNode focusNodePass = FocusNode();
  //   final FocusNode focusNodePassConfirm = FocusNode();
  //   final FocusNode focusNodeBirthdate = FocusNode();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 236, 236),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Image.asset(
                './assets/images/logo_dtc.png',
                height: 130,
              ),
              const SizedBox(height: 15),
              const Row(
                children: [
                  Text(
                    "Inregistrare",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  )
                ],
              ),
              const SizedBox(height: 15),
              registrationFields(),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: () {
                  final isValidForm = registerKey.currentState!.validate();
                  if (isValidForm) {
                    // requestPermission();
                    // getToken();
                    register(context);
                  }
                },
                child: const Text(
                  'Creeaza cont',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              const SizedBox(height: 15),
              RichText(
                text: TextSpan(
                    text: 'Ai deja un cont? Conecteaza-te aici!',
                    style: const TextStyle(fontSize: 17, color: Colors.black),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pop(context);
                      }),
              ),
              const SizedBox(height: 15),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: 'Prin crearea unui cont, sunteti de acord cu \n',
                    style: const TextStyle(fontSize: 15, color: Colors.black),
                    children: [
                      TextSpan(
                          text: "Termenii & Conditiile",
                          style: const TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return const PrivacyDialog(mdFileName: 'terms_and_conditions.md', radius: 5);
                                },
                              );
                            }),
                      const TextSpan(
                        text: " si ",
                      ),
                      TextSpan(
                          text: "Politica de confidentialitate!",
                          style: const TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return const PrivacyDialog(mdFileName: 'privacy.md', radius: 5);
                                },
                              );
                            }),
                    ]),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  Form registrationFields() {
    String? confirmPassCheck;
    return Form(
      key: registerKey,
      child: Column(children: [
        TextFormField(
            focusNode: focusNodePrenume,
            controller: controllerNume,
            autocorrect: false,
            onFieldSubmitted: (String s) {
              focusNodeNume.requestFocus();
            },
            validator: (value) {
              if (value!.isEmpty || value.length < 3 || RegExp(r'\d').hasMatch(value)) {
                return "Enter a valid username";
              } else {
                return null;
              }
            },
            decoration: const InputDecoration(
                hintText: 'Prenume',
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 236, 231, 231))),
                filled: true,
                fillColor: Colors.white)),
        TextFormField(
            focusNode: focusNodeNume,
            controller: controllerPrenume,
            autocorrect: false,
            onFieldSubmitted: (String s) {
              focusNodeEmail.requestFocus();
            },
            validator: (value) {
              if (value!.isEmpty || value.length < 3 || RegExp(r'^[0-9]+$').hasMatch(value)) {
                return "Enter a valid username";
              } else {
                return null;
              }
            },
            decoration: const InputDecoration(
                hintText: 'Nume',
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 236, 231, 231))),
                filled: true,
                fillColor: Colors.white)),
        TextFormField(
            focusNode: focusNodeEmail,
            controller: controllerEmail,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            onFieldSubmitted: (String s) {
              focusNodeTelefon.requestFocus();
            },
            validator: (value) {
              if (value!.isEmpty || !RegExp(r'.+@.+\.+').hasMatch(value)) {
                return "Enter a valid Email Address";
              } else {
                return null;
              }
            },
            decoration: const InputDecoration(
                hintText: 'E-mail',
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 236, 231, 231))),
                filled: true,
                fillColor: Colors.white)),
        TextFormField(
            focusNode: focusNodeTelefon,
            keyboardType: TextInputType.number,
            controller: controllerTelefon,
            autocorrect: false,
            validator: (value) {
              if (value!.isEmpty || !RegExp(r'^[0-9]+$').hasMatch(value)) {
                return "Introduceti un numar de telefon valid";
              } else {
                return null;
              }
            },
            decoration: const InputDecoration(
                hintText: 'Telefon mobil',
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 236, 231, 231))),
                filled: true,
                fillColor: Colors.white)),
        TextFormField(
            focusNode: focusNodeBirthdate,
            controller: controllerBirthdate,
            autocorrect: false,
            // onTap: () => chooseBirthdate(context),
            onTap: () async {
              DateTime? date = await showDatePicker(
                  context: context, initialDate: DateTime.now(), firstDate: DateTime(1960), lastDate: DateTime(2024));
              controllerBirthdate.text = DateFormat('yyyy.MM.dd').format(date!);

              // ScaffoldMessenger.of(context)
              //     .showSnackBar(const SnackBar(content: Text('Success')));
            },
            onFieldSubmitted: (String s) {
              focusNodePass.requestFocus();
            },
            validator: (value) {
              if (value!.isEmpty) {
                return "Alegeti o data de nastere!";
              } else {
                return null;
              }
            },
            decoration: const InputDecoration(
                hintText: 'Data de nastere',
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 236, 231, 231))),
                filled: true,
                fillColor: Colors.white)),
        TextFormField(
            focusNode: focusNodePass,
            controller: controllerPass,
            obscureText: isHidden,
            autocorrect: false,
            onFieldSubmitted: (String s) {
              focusNodePassConfirm.requestFocus();
            },
            validator: (value) {
              confirmPassCheck = value;
              if (value!.isEmpty) {
                return "Please Enter New Password";
              } else if (value.length < 6) {
                return "Password must be atleast 6 characters long";
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: passVisibiltyToggle,
                    icon: isHidden ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off)),
                hintText: 'Parola',
                enabledBorder:
                    const OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 236, 231, 231))),
                filled: true,
                fillColor: Colors.white)),
        TextFormField(
            focusNode: focusNodePassConfirm,
            controller: controllerPassConfirm,
            obscureText: isHidden,
            autocorrect: false,
            onFieldSubmitted: (String s) {
              focusNodePassConfirm.requestFocus();
            },
            validator: (value) {
              if (value != confirmPassCheck) {
                return "Parolele nu se potrivesc!";
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: passVisibiltyToggle,
                    icon: isHidden ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off)),
                hintText: 'Parola',
                enabledBorder:
                    const OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 236, 231, 231))),
                filled: true,
                fillColor: Colors.white)),
      ]),
    );
  }

  void register(BuildContext context) async {
    // final uniqueId = await FirebaseMessaging.instance.getToken() ?? '';

    String? res = await apiCallFunctions.register(
      pNume: controllerNume.text,
      pPrenume: controllerPrenume.text,
      pTelefonMobil: controllerTelefon.text,
      pDataDeNastereYYYYMMDD: controllerBirthdate.text,
      pAdresaMail: controllerEmail.text,
      pParola: controllerPass.text,
      pFirebaseGoogleDeviceID: "uniqueID",
    );

    if (!mounted) {
      return;
    }
    // var l = LocalizationsApp.of(context)!;
    if (res == null) {
      // errorInfo = l.universalEroare;
      // infoWidget = InfoWidget.error;
      print("Eroare null");
      return;
    }
    if (res.startsWith('13\$#\$')) {
      print("success");
      Navigator.pop(context);
    }
    if (res.startsWith('66\$#\$')) {
      print("dategresite");
      return;
    }

    if (res.startsWith('132\$#\$')) {
      print("register error");
      return;
    }
    if (res.contains('\$#\$')) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      List<String> info = res.split('\$#\$');

      prefs.setString(pref_keys.userPassMD5, apiCallFunctions.generateMd5(controllerPass.text));
      prefs.setString(pref_keys.userIdInregistrare, info[0]);
      prefs.setString(pref_keys.userNume, info[1]);
      prefs.setString(pref_keys.userPrenume, info[2]);
      prefs.setString(pref_keys.userIdPacientAsociat, info[3]);
      prefs.setString(pref_keys.userVip, info[4]);
      prefs.setString(pref_keys.userNeserios, info[5]);
      prefs.setString(pref_keys.userDDN, info[6]);
      prefs.setString(pref_keys.userSex, info[7]);
      prefs.setString(pref_keys.userIdAjustareCurenta, info[8]);
      prefs.setString(pref_keys.userDataInceputAjustare, info[9]);
      prefs.setString(pref_keys.userDataSfarsitAjustare, info[10]);
      prefs.setString(pref_keys.dataAsociere, info[11]);
      prefs.setString(pref_keys.userDataFisa, info[12]);
      prefs.setString(pref_keys.userTelefon, info[13]);
      prefs.setString(pref_keys.userEmail,
          controllerEmail.text.trim()); //mail din info poate fi diferit si nu vor mai merge metodele
      prefs.setString(pref_keys.userNumarPuncteAcumulate, info[15]);
      prefs.setString(pref_keys.userUltimaDataAsociere, info[16]);
      prefs.setString(pref_keys.userTotalPuncteNivelMediu, info[17]);
      prefs.setString(pref_keys.userTotalPuncteNivelSuperior, info[18]);
      prefs.setString(pref_keys.idSediuUser, info[19]);
      prefs.setString(pref_keys.permiteIntroducereaDeProgramari, info[20]);
      if (!mounted) {
        return;
      }
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
      return;
    }

    print(res);
  }

  void passVisibiltyToggle() {
    setState(() {
      isHidden = !isHidden;
    });
  }

//   void requestPermission() async {
//     FirebaseMessaging messaging = FirebaseMessaging.instance;
//     NotificationSettings settings = await messaging.requestPermission(
//       alert: true,
//       announcement: true,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );

//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print("User granted permission");
//     }
//   }

//   void getToken() async {
//     await FirebaseMessaging.instance.getToken().then(
//       (token) {
//         setState(() {
//           mtoken = token;
//           print("My token is $mtoken");
//         });
//       },
//     );
//   }
// }

  // chooseBirthdate(BuildContext context) async {
  //   DateTime? d = dataNasterii;
  //   DateTime now = DateTime.now();
  //   DateTime check = DateTime(now.year - 18, now.month, now.day);
  //   showBottomSheet(
  //       context: context,
  //       builder: (context) {
  //         return Center(
  //           child: SizedBox(
  //             height: 300,
  //             child: Column(
  //               children: [
  //                 Expanded(
  //                     child: CupertinoTheme(
  //                   data: const CupertinoThemeData(),
  //                   child: CupertinoDatePicker(
  //                       maximumDate: DateTime.now(),
  //                       initialDateTime: d?.add(const Duration(minutes: 11)) ?? check,
  //                       mode: CupertinoDatePickerMode.date,
  //                       onDateTimeChanged: onDateTimeChanged),
  //                 )),
  //                 const SizedBox(
  //                   height: 20,
  //                 ),
  //                 ElevatedButton(
  //                     onPressed: () {
  //                       dataNasterii = dataNasterii?.add(const Duration(minutes: 11)) ?? check;
  //                       controllerBirthdate.text = DateFormat('dd.MM.yyyy').format(dataNasterii!);

  //                       Navigator.of(context).pop();
  //                       bool ok = true;
  //                       if (controllerBirthdate.text.isEmpty) {
  //                         ok = false;
  //                         errorDDN = "Campul nu poate fi lasat liber";
  //                         setState(() {});
  //                       } else {
  //                         DateTime d = dataNasterii!;
  //                         DateTime selected = DateTime.utc(d.year, d.month, d.day);
  //                         DateTime now = DateTime.now();
  //                         DateTime check = DateTime.utc(now.year - 18, now.month, now.day);
  //                         if (selected.isAfter(check)) {
  //                           ok = false;
  //                           errorDDN = "Trebuie sa ai macar 18 ani";
  //                         } else {
  //                           errorDDN = null;
  //                         }
  //                         setState(() {});
  //                       }
  //                       if (ok) {
  //                         focusNodePass.requestFocus();
  //                       }
  //                     },
  //                     child: const Text("Okay",
  //                         style: TextStyle(
  //                           fontSize: 20,
  //                           fontWeight: FontWeight.bold,
  //                         )))
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }

  // void onDateTimeChanged(DateTime d) {
  //   dataNasterii = d;
  //   controllerBirthdate.text = DateFormat('dd.MM.yyyy', Localizations.localeOf(context).languageCode).format(d);
  //   DateTime selected = DateTime.utc(d.year, d.month, d.day);
  //   DateTime now = DateTime.now();
  //   DateTime check = DateTime.utc(now.year - 18, now.month, now.day);
  //   if (selected.isAfter(check)) {
  //     errorDDN = "Trebuie sa ai cel putin 18 ani ";
  //   } else {
  //     errorDDN = null;
  //   }
  //   setState(() {});
  // }
}
