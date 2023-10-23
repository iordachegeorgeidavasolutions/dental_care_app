// import 'package:flutter/cupertino.dart';
// import 'package:dental_care_app/screens/home.dart';
import 'package:dental_care_app/widgets/dialogs/privacy_dialog.dart';
import '../utils/shared_pref_keys.dart' as pref_keys;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/api_call_functions.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

ApiCallFunctions apiCallFunctions = ApiCallFunctions();

class _RegisterScreenState extends State<RegisterScreen> {
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

  bool isHidden = true;

  @override
  void dispose() {
    controllerNume.dispose();
    controllerPrenume.dispose();
    controllerEmail.dispose();
    controllerTelefon.dispose();
    controllerPass.dispose();
    controllerPassConfirm.dispose();
    controllerBirthdate.dispose();
    super.dispose();
  }

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
                  backgroundColor: Colors.red[400],
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
                  text: 'Ai deja un cont? ',
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.pop(context);
                    },
                  children: [
                    TextSpan(
                        text: 'Conecteaza-te aici!',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pop(context);
                          },
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
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
        const SizedBox(height: 3),
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
        const SizedBox(height: 3),
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
        const SizedBox(height: 3),
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
        const SizedBox(height: 3),
        TextFormField(
            focusNode: focusNodeBirthdate,
            controller: controllerBirthdate,
            autocorrect: false,
            // onTap: () => chooseBirthdate(context),
            onTap: () async {
              DateTime? date = await showDatePicker(
                  context: context, initialDate: DateTime.now(), firstDate: DateTime(1960), lastDate: DateTime(2024));
              controllerBirthdate.text = DateFormat('yyyyMMdd').format(date!).toString();
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
        const SizedBox(height: 3),
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
                return "Please enter a password";
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
        const SizedBox(height: 3),
        TextFormField(
            focusNode: focusNodePassConfirm,
            controller: controllerPassConfirm,
            obscureText: isHidden,
            autocorrect: false,
            onFieldSubmitted: (String s) {
              focusNodePassConfirm.requestFocus();
            },
            validator: (value) {
              if (value!.isEmpty) {
                return "Please enter a password";
              }
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? res = await apiCallFunctions.register(
      pNume: controllerNume.text,
      pPrenume: controllerPrenume.text,
      pTelefonMobil: controllerTelefon.text,
      pDataDeNastereYYYYMMDD: controllerBirthdate.text,
      pAdresaMail: controllerEmail.text.trim(),
      pParola: controllerPass.text,
      pFirebaseGoogleDeviceID: prefs.getString(pref_keys.fcmToken) ?? "FCM Token not available in Shared Preferences",
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
      prefs.setString(pref_keys.userEmail, controllerEmail.text);
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
    print(res);
  }

  void passVisibiltyToggle() {
    setState(() {
      isHidden = !isHidden;
    });
  }
}
