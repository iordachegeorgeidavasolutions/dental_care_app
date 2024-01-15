// import 'package:flutter/cupertino.dart';
// import 'package:dental_care_app/screens/home.dart';
import 'package:dental_care_app/widgets/dialogs/privacy_dialog.dart';
import '../utils/shared_pref_keys.dart' as pref_keys;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/api_call_functions.dart';
import 'package:another_flushbar/flushbar.dart';
import './login.dart';

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

  String birthdate = '';

  bool afiseazaButonCreazaCont = true;

  @override
  void initState() {
    super.initState();
    
    setState(() {

      afiseazaButonCreazaCont = true;

    });
  }
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
                    "Înregistrare",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  )
                ],
              ),
              const SizedBox(height: 15),
              registrationFields(),
              const SizedBox(height: 20),
              if (afiseazaButonCreazaCont) ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[400],
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // <-- Radius
                  ),
                ),
                onPressed: () {
                  final isValidForm = registerKey.currentState!.validate();
                  if (isValidForm) {
                    // requestPermission();
                    // getToken();
                    
                    setState(() {
                      afiseazaButonCreazaCont = false;
                    });
                    register(context);
                  }
                },
                child: const Text(
                  'Creează cont',
                  style: TextStyle(fontSize: 24, color: Colors.white),
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
                        text: 'Conectează-te aici!',
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
                    text: 'Prin crearea unui cont, sunteți de acord cu \n',
                    style: const TextStyle(fontSize: 15, color: Colors.black),
                    children: [
                      TextSpan(
                          text: "Termenii & Condițiile",
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
                          text: "Politica de confidențialitate!",
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
                //return "Enter a valid username"; //old Andrei Bădescu
                return "Introdu un utilizator valid";
              } else {
                return null;
              }
            },
            decoration: const InputDecoration(
                hintText: 'Prenume',
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 236, 231, 231))
                  ),
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
                //return "Enter a valid username"; //old Andrei Bădescu
                return "Introdu un utilizator valid";
              } else {
                return null;
              }
            },
            decoration: const InputDecoration(
                hintText: 'Nume',
                border: InputBorder.none,
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
                //return "Enter a valid Email Address"; //old Andrei Bădescu
                return "Introduceți o adresă de Email validă";

              } else {
                return null;
              }
            },
            decoration: const InputDecoration(
                hintText: 'E-mail',
                border: InputBorder.none,
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
                return "Introduceți un număr de telefon valid";
              } else {
                return null;
              }
            },
            decoration: const InputDecoration(
                hintText: 'Telefon mobil',
                border: InputBorder.none,
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
                context: context, 
                locale : const Locale("ro","RO"),
                initialDate: DateTime.now(), firstDate: DateTime(1960), lastDate: DateTime(2040),
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      splashColor: Color.fromARGB(255,200,200,200), //Colors.red,
                      colorScheme: ColorScheme.light(
                        surface: Colors.white,
                        primary: Colors.red, // // <-- SEE HERE
                        //onSurface: Colors.white,  // <-- SEE HERE
                      ),
                      textButtonTheme: TextButtonThemeData(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black, // button text color
                        ),
                      ),
                    ),
                    child: child!,
                  );
                },
              ); 
              //controllerBirthdate.text = DateFormat('yyyyMMdd').format(date!).toString(); // old Andrei Bădescu
              controllerBirthdate.text = DateFormat('dd/MM/yyyy').format(date!).toString(); // old Andrei Bădescu
              birthdate = DateFormat('yyyyMMdd').format(date).toString();
            },
            onFieldSubmitted: (String s) {
              focusNodePass.requestFocus();
            },
            validator: (value) {
              if (value!.isEmpty) {
                return "Alegeți o dată de naștere!";
              } else {
                return null;
              }
            },
            decoration: const InputDecoration(
                hintText: 'Data de naștere',
                border: InputBorder.none,
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
                //return "Please enter a password"; //old Andrei Bădescu
                return "Introduceți o parolă";
              } else if (value.length < 6) {
                //return "Password must be atleast 6 characters long"; //old Andrei Bădescu
                return "Parola trebuie să aibă cel puțin 6 caractere";
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: passVisibiltyToggle,
                    icon: isHidden ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off)),
                hintText: 'Parola',
                border: InputBorder.none,
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
                //return "Please enter a password"; //old Andrei Bădescu
                return "Introduceți o parolă";
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
                hintText: 'Confirmă parola',
                border: InputBorder.none,
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
      pDataDeNastereYYYYMMDD: birthdate,
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

      setState(() {
        afiseazaButonCreazaCont = false;
      });

      if (context.mounted) {

        Flushbar(
          message: "Înregistrare încheiată cu succes!", //old Andrei Bădescu
          //message: Shared.limba.textMesajSuccessfullRegister, //cu dictionar
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

      }

      Future.delayed(Duration(seconds: 5), () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
      });
      //Navigator.pop(context);
    }
    if (res.startsWith('66\$#\$')) {
      
      setState(() {
        afiseazaButonCreazaCont = true;
      });

      Flushbar(
        message: "Date greșite, verificați cu atenție datele introduse și încercați încă o dată!", //old Andrei Bădescu
        //message: Shared.limba.textMesajDateGresiteRegister, IGV cu dictionar
        icon: const Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.red,
        ),
        borderColor: Colors.red,
        borderWidth: 2,
        isDismissible: false,
        margin: const EdgeInsets.all(6.0),
        flushbarStyle: FlushbarStyle.FLOATING,
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(12),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.red,
      ).show(context);
      print("dategresite");
      return;
    }

    if (res.startsWith('132')) {
      
      setState(() {
        afiseazaButonCreazaCont = true;
      });
      
      showAlertDialog(context);
      /*
      Flushbar(
        message: "Un pacient cu datele introduse este deja înregistrat!", //old Andrei Bădescu
        //message: Shared.limba.textMesajPacientDejaExistentRegister,
        icon: const Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.red,
        ),
        borderColor: Colors.red,
        borderWidth: 2,
        isDismissible: false,
        margin: const EdgeInsets.all(6.0),
        flushbarStyle: FlushbarStyle.FLOATING,
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(12),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.red,
      ).show(context);
      */
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

showAlertDialog(BuildContext context) {

  // set up the buttons
  Widget logInButton = TextButton(
    child: Text("Log in"),
    onPressed:  () {
      //Future.delayed(Duration(seconds: 1), () {
          Navigator.of(context)
              .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
        //});
    },
  );
  Widget cancelButton = TextButton(
    child: Text("Anulează"),
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
  AlertDialog alert = AlertDialog(
    title: Text("Eroare"),
    content: Text("Există deja un cont creat cu numărul acesta de telefon sau email, parcurgeți pașii de recuperare parolă în ecranul de login"),
    actions: [
      logInButton,
      cancelButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
