// ignore_for_file: avoid_print

import 'package:another_flushbar/flushbar.dart';
import 'package:dental_care_app/main.dart';
import 'package:dental_care_app/screens/password_reset.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../utils/functions.dart';
import './register.dart';
import '../utils/shared_pref_keys.dart' as pref_keys;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dental_care_app/utils/api_call_functions.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

ApiCallFunctions apiCallFunctions = ApiCallFunctions();

class _LoginPageState extends State<LoginPage> {
  final loginKey = GlobalKey<FormState>();
  bool isHidden = true;
  bool loginPhoneOrEmail = false;

  final controllerEmail = TextEditingController();
  final controllerPass = TextEditingController();

  final FocusNode focusNodeEmail = FocusNode();
  final FocusNode focusNodePassword = FocusNode();

  void passVisibiltyToggle() {
    setState(() {
      isHidden = !isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 236, 236),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            // LOGO
            Image.asset(
              './assets/images/logo_dtc.png',
              height: 200,
            ),
            const SizedBox(height: 25),

            // Welcome message
            const Padding(
              padding: EdgeInsets.only(left: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Bine ai venit!",
                    style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.w400),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[400],
                  minimumSize: const Size.fromHeight(50), 
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // <-- Radius
                  ),
                  // NEW
                ),
                onPressed: () {
                  final isValidForm = loginKey.currentState!.validate();
                  if (isValidForm) {
                    loginPhoneOrEmail ? loginByPhone(context) : login(context);
                  }
                },
                child: const Text(
                  'Intră în cont',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 15),
            otherLoginOptions(context),
          ],
        ),
      ),
    );
  }

  Padding otherLoginOptions(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PasswordReset())),
            child: const Text(
              "Ai uitat parola?",
              style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w600),
            ),
          ),
          RichText(
            text: TextSpan(
                text: 'Nu ai cont?',
                style: const TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w600),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ));
                  }),
          ),
        ],
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
            controller: controllerEmail,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide.none,
              ),
              focusedBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8.0)), borderSide: BorderSide.none),
              hoverColor: Colors.red[400],
              filled: true,
              fillColor: Colors.white,
              hintText: "E-mail sau telefon",
            ),
            validator: (value) {
              if (value!.isEmpty || !RegExp(r'.+@.+\.+').hasMatch(value) && !RegExp(r'^-?[0-9]+$').hasMatch(value)) {
                //return "Enter a valid Email Address or Password"; //old Andrei Bădescu
                return "Introduceți o adresă de e-mail sau telefon valide"; //old Andrei Bădescu
              } else {
                if (RegExp(r'.+@.+\.+').hasMatch(value)) {
                  setState(() {
                    loginPhoneOrEmail = false;
                  });
                  return null;
                } else if (RegExp(r'^-?[0-9]+$').hasMatch(value)) {
                  setState(() {
                    loginPhoneOrEmail = true;
                  });
                  return null;
                } else {
                  return null;
                }
              }
            },
          ),
          const SizedBox(height: 5),
          TextFormField(
            focusNode: focusNodePassword,
            controller: controllerPass,
            obscureText: isHidden,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: passVisibiltyToggle,
                    icon: isHidden ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off)),
                hintText: "Parolă",
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white),
            validator: (value) {
              if (value!.isEmpty) {
                //return "Please Enter New Password"; //old Andrei Bădescu
                return "Introduceți o parolă nouă";
              } else if (value.length < 6) {
                //return "Password must be atleast 6 characters long"; //old Andrei Bădescu
                return "Parola trebuie să aibă cel puțin 6 caractere";

              } else {
                return null;
              }
            },
          ),
        ],
      ),
    );
  }

  loginByPhone(BuildContext context) async {
    String mail = controllerEmail.text;
    String pass = controllerPass.text;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // final token = await FirebaseMessaging.instance.getToken() ?? '';

    String? res = await apiCallFunctions.loginByPhone(
        pTelefon: mail.trim(),
        pParolaMD5: apiCallFunctions.generateMd5(pass),
        pFirebaseGoogleDeviceID:
            prefs.getString(pref_keys.fcmToken) ?? "FCM Token not available in Shared Preferences");

    print(res);
    if (res == null) {
      showSnackbar(
        context,
        "Eroare server!",
      );
      return;
      // } else if (res.startsWith('161')) {
      //   showsnackbar(
      //     context,
      //     "Date de login varule!",
      //   );
      // return;
    } else if (res.startsWith('66')) {
      Flushbar(
        //message: "Date greșite, verifică cu atenție datele introduse și încearcă încă o dată!", //old Andrei Bădescu
        message: 'Mail-ul sau parola au fost introduse greșit, încearcă iar.',
        icon: const Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.red,
        ),
        borderColor: Colors.red,
        borderWidth: 2,
        isDismissible: false,
        margin: EdgeInsets.all(6.0),
        flushbarStyle: FlushbarStyle.FLOATING,
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(12),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.red,
      ).show(context);
      return;
    } else if (res.contains('\$#\$')) {
      // ignore: use_build_context_synchronously
      //old Andrei Bădescu
      /*
      Flushbar(
        message: "Login încheiat cu succes!",
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

      // showsnackbar(context, "Succes!");
      List<String> info = res.split('\$#\$');
      SharedPreferences prefs = await SharedPreferences.getInstance();
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
      prefs.setString(pref_keys.userEmail, info[14]);
      prefs.setString(pref_keys.userNumarPuncteAcumulate, info[15]);
      prefs.setString(pref_keys.userUltimaDataAsociere, info[16]);
      prefs.setString(pref_keys.userTotalPuncteNivelMediu, info[17]);
      prefs.setString(pref_keys.userTotalPuncteNivelSuperior, info[18]);
      prefs.setString(pref_keys.idSediuUser, info[19]);
      prefs.setString(pref_keys.permiteIntroducereaDeProgramari, info[20]);
      prefs.setBool(pref_keys.loggedIn, true);
      prefs.setBool(pref_keys.firstTime, false);
      if (context.mounted) {
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.of(context)
              .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const MyApp(fromPinPage: false,)), (route) => false);
        });
      }
      return;
    }
  }

  login(BuildContext context) async {
    String mail = controllerEmail.text;
    String pass = controllerPass.text;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // final token = await FirebaseMessaging.instance.getToken() ?? '';

    String? res = await apiCallFunctions.login(
        pAdresaEmail: mail.trim(),
        pParolaMD5: apiCallFunctions.generateMd5(pass),
        pFirebaseGoogleDeviceID:
            prefs.getString(pref_keys.fcmToken) ?? "FCM Token not available in Shared Preferences");
    print(res);
    if (res == null) {
      showSnackbar(
        context,
        "Date de login greșite!",
      );
      return;
      // } else if (res.startsWith('161')) {
      //   showsnackbar(
      //     context,
      //     "Date de login varule!",
      //   );
      // return;
    } else if (res.startsWith('66')) {
      Flushbar(
        //message: "Date greșite, verifică cu atenție datele introduse și încearcă încă o dată!",
        message: 'Mail-ul sau parola au fost introduse greșit, încearcă iar.',
        icon: const Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.red,
        ),
        borderColor: Colors.red,
        borderWidth: 2,
        isDismissible: false,
        margin: EdgeInsets.all(6.0),
        flushbarStyle: FlushbarStyle.FLOATING,
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(12),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.red,
      ).show(context);
      return;
    } else if (res.contains('\$#\$')) {
      // ignore: use_build_context_synchronously
      //old Andrei Bădescu
      /*Flushbar(
        message: "Login încheiat cu succes!",
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
      // showsnackbar(context, "Succes!");
      List<String> info = res.split('\$#\$');
      SharedPreferences prefs = await SharedPreferences.getInstance();
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
      prefs.setString(pref_keys.userEmail, info[14]);
      prefs.setString(pref_keys.userNumarPuncteAcumulate, info[15]);
      prefs.setString(pref_keys.userUltimaDataAsociere, info[16]);
      prefs.setString(pref_keys.userTotalPuncteNivelMediu, info[17]);
      prefs.setString(pref_keys.userTotalPuncteNivelSuperior, info[18]);
      prefs.setString(pref_keys.idSediuUser, info[19]);
      prefs.setString(pref_keys.permiteIntroducereaDeProgramari, info[20]);
      prefs.setBool(pref_keys.loggedIn, true);
      prefs.setBool(pref_keys.firstTime, false);
      if (context.mounted) {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context)
              .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const MyApp(fromPinPage: false)), (route) => false);
        });
      }
      return;
    }
  }
}
