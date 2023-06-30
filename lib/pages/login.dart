import 'package:dental_care_app/main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import './register.dart';
import '../utils/shared_pref_keys.dart' as pref_keys;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginKey = GlobalKey<FormState>();

  final ControllerEmail = TextEditingController();
  final ControllerPass = TextEditingController();

  final FocusNode focusNodeEmail = FocusNode();
  final FocusNode focusNodePassword = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 236, 236),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50),
            // LOGO
            Image.asset(
              './assets/images/logo_dtc.png',
              height: 200,
            ),
            SizedBox(height: 25),

            // Welcome message
            const Padding(
              padding: EdgeInsets.only(left: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Bine ai revenit!",
                    style: TextStyle(color: Colors.black, fontSize: 30),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Text Fields
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23),
              child: loginForm(),
            ),
            const SizedBox(height: 25),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 22),
            //   child: ClipRRect(
            //     borderRadius: BorderRadius.circular(10),
            //     child: ElevatedButton(
            //       onPressed: () {
            //         // Do something when the button is pressed
            //       },
            //       style: ElevatedButton.styleFrom(
            //         minimumSize: const Size.fromHeight(50),
            //         backgroundColor: Colors.red,
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(10),
            //         ),
            //       ),
            //       child: const Text(
            //         'Intra in cont',
            //         style: TextStyle(
            //           color: Colors.white,
            //           fontSize: 16,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: const Size.fromHeight(50), // NEW
                ),
                onPressed: () {
                  login(context);
                },
                child: const Text(
                  'Intra in cont',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Ai uitat parola?",
                    style: TextStyle(fontSize: 17, color: Colors.black),
                  ),
                  RichText(
                    text: TextSpan(
                        text: 'Nu ai cont?',
                        style: const TextStyle(fontSize: 17, color: Colors.black),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterScreen(),
                                ));
                          }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Form loginForm() {
    return Form(
      key: loginKey,
      child: Column(
        children: [
          TextFormField(
            onFieldSubmitted: (String s) {
              focusNodePassword.requestFocus();
            },
            controller: ControllerEmail,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
                hintText: 'E-mail',
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 236, 231, 231))),
                filled: true,
                fillColor: Colors.white),
            validator: (value) {
              if (value!.isEmpty || !RegExp(r'.+@.+\.+').hasMatch(value)) {
                return "Enter a valid Email Address";
              } else {
                return null;
              }
            },
          ),
          TextFormField(
            focusNode: focusNodePassword,
            controller: ControllerPass,
            decoration: const InputDecoration(
                hintText: "Parola",
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 236, 231, 231))),
                filled: true,
                fillColor: Colors.white),
            validator: (value) {
              if (value!.isEmpty) {
                return "Please Enter New Password";
              } else if (value.length < 6) {
                return "Password must be atleast 6 characters long";
              } else {
                return null;
              }
            },
          ),
        ],
      ),
    );
  }

  login(BuildContext context) async {
    String mail = ControllerEmail.text;
    String pass = ControllerPass.text;
    // final token = await FirebaseMessaging.instance.getToken() ?? '';

    String? res = await apiCallFunctions.login(
        pAdresaEmail: mail.trim(), pParolaMD5: apiCallFunctions.generateMd5(pass), pFirebaseGoogleDeviceID: "uniqueID");
    if (res!.contains('\$#\$')) {
      List<String> info = res.split('\$#\$');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(pref_keys.userPassMD5, apiCallFunctions.generateMd5(ControllerPass.text));
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
          ControllerEmail.text.trim()); //mail din info poate fi diferit si nu vor mai merge metodele
      prefs.setString(pref_keys.userNumarPuncteAcumulate, info[15]);
      prefs.setString(pref_keys.userUltimaDataAsociere, info[16]);
      prefs.setString(pref_keys.userTotalPuncteNivelMediu, info[17]);
      prefs.setString(pref_keys.userTotalPuncteNivelSuperior, info[18]);
      prefs.setString(pref_keys.idSediuUser, info[19]);
      prefs.setString(pref_keys.permiteIntroducereaDeProgramari, info[20]);
      prefs.setBool(pref_keys.loggedIn, true);
      prefs.setBool(pref_keys.firstTime, false);
      if (context.mounted) {
        Navigator.of(context)
            .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const MyApp()), (route) => false);
      }
      return;
    }
  }
}
