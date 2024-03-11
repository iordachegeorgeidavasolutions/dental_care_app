import 'package:dental_care_app/main.dart';
import 'package:dental_care_app/screens/login.dart';
import 'package:dental_care_app/utils/api_call_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/shared_pref_keys.dart' as pref_keys;

class PasswordResetPin extends StatefulWidget {
  
  final bool resetDoarTelefon;
  final bool resetEmailOrPhoneNumber;
  final String? telefon;
  final String email;
  final String password;
  const PasswordResetPin({
    super.key,
    required this.email,
    required this.password,
    this.telefon,
    required this.resetEmailOrPhoneNumber,
    required this.resetDoarTelefon,
  });

  @override
  State<PasswordResetPin> createState() => _PasswordResetPinState();

}

ApiCallFunctions apiCallFunctions = ApiCallFunctions();

class _PasswordResetPinState extends State<PasswordResetPin> {
  String controllerOTP = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 236, 236),
      body: SafeArea(
          child: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            Row(
              children: [
                Row(children: [
                  IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                      color: Colors.black,
                      onPressed: () => Navigator.pop(context)),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Text(
                      "Înapoi",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400, color: Colors.black),
                    ),
                  )
                ]),
              ],
            ),

            Image.asset(
              './assets/images/password_reset_pin.png',
              height: 250,
            ),
            RichText(
                text: const TextSpan(
                    //text: 'Verificare OTP', //old Andrei Bădescu
                    text: 'Cod de securitate',
                    style: TextStyle(color: Colors.black, fontSize: 35, fontWeight: FontWeight.bold))),
            const SizedBox(height: 25),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Introduceți codul de 4 cifre trimis la:\n',
                style: const TextStyle(color: Colors.black, fontSize: 18),
                children: [
                  TextSpan(
                    text: widget.email,
                    style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 15),
            //   child: Form(
            //       child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       SizedBox(
            //         height: 68,
            //         width: 64,
            //         child: TextField(
            //           inputFormatters: [
            //             LengthLimitingTextInputFormatter(1),
            //             FilteringTextInputFormatter.digitsOnly,
            //           ],
            //           textAlign: TextAlign.center,
            //           onChanged: (value) {
            //             if (value.length == 1) {
            //               FocusScope.of(context).nextFocus();
            //             }
            //           },
            //           style: Theme.of(context).textTheme.headlineLarge,
            //           keyboardType: TextInputType.number,
            //         ),
            //       ),
            //       SizedBox(
            //         height: 68,
            //         width: 64,
            //         child: TextField(
            //           inputFormatters: [
            //             LengthLimitingTextInputFormatter(1),
            //             FilteringTextInputFormatter.digitsOnly,
            //           ],
            //           textAlign: TextAlign.center,
            //           onChanged: (value) {
            //             if (value.length == 1) {
            //               FocusScope.of(context).nextFocus();
            //             }
            //           },
            //           style: Theme.of(context).textTheme.headlineLarge,
            //           keyboardType: TextInputType.number,
            //         ),
            //       ),
            //       SizedBox(
            //         height: 68,
            //         width: 64,
            //         child: TextField(
            //           inputFormatters: [
            //             LengthLimitingTextInputFormatter(1),
            //             FilteringTextInputFormatter.digitsOnly,
            //           ],
            //           textAlign: TextAlign.center,
            //           onChanged: (value) {
            //             if (value.length == 1) {
            //               FocusScope.of(context).nextFocus();
            //             }
            //           },
            //           style: Theme.of(context).textTheme.headlineLarge,
            //           keyboardType: TextInputType.number,
            //         ),
            //       ),
            //       SizedBox(
            //         height: 68,
            //         width: 64,
            //         child: TextField(
            //           inputFormatters: [
            //             LengthLimitingTextInputFormatter(1),
            //             FilteringTextInputFormatter.digitsOnly,
            //           ],
            //           textAlign: TextAlign.center,
            //           onChanged: (value) {
            //             if (value.length == 1) {
            //               FocusScope.of(context).nextFocus();
            //             }
            //           },
            //           style: Theme.of(context).textTheme.headlineLarge,
            //           keyboardType: TextInputType.number,
            //         ),
            //       )
            //     ],
            //   )),
            // ),
            OtpTextField(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              numberOfFields: 4,
              borderColor: Colors.black,
              fillColor: Colors.white,
              showFieldAsBox: true,
              borderWidth: 1,
              enabledBorderColor: Colors.black,
              filled: true,
              keyboardType: TextInputType.number,
              focusedBorderColor: Colors.red.shade400,
              fieldWidth: 45,
              onSubmit: (value) {
                controllerOTP = value;
              },
            ),
            const SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 52),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // <-- Radius
                  ), // NEW
                ),
                child: const Text(
                  'Verifică codul',
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
                onPressed: widget.resetEmailOrPhoneNumber
                ? () async {
                    
                  //print('password_reset_pin: ${widget.resetEmailOrPhoneNumber}');
                  await verifyPinResetEmailOrPhone();

                  //print('controllerOTP $controllerOTP widget.resetDoarTelefon ${widget.resetDoarTelefon} telefon vechi: ${prefs.getString(pref_keys.userTelefon)!} telefon nou: ${widget.telefon}');


                  //print('Aici resetEmailOrPhoneNumber ${widget.telefon!}');

                  /*
                  if (widget.resetDoarTelefon)
                  {

                    if (context.mounted) {
                      Future.delayed(const Duration(milliseconds: 100), () {
                        Navigator.of(context)
                            .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const HomePage()), (route) => false);
                      });
                    }

                    //Navigator.of(context).pushAndRemoveUntil(
                    //  MaterialPageRoute(builder: (context) => HomePage()), (route) => false);

                  }
                  else {    
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
                  }
                  */
                }
                : () async {
                  await verifyPinResetPassword();
                  print(controllerOTP);
                  /*Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
                  */    
                }
              ),
            ),
            SizedBox(height:30),
          ],
        ),
      )),
    );
  }

  verifyPinResetPassword() async {
    String? res = await apiCallFunctions.reseteazaParolaValidarePIN(
        pAdresaMail: widget.email, pParolaNoua: widget.password, pPINDinMail: controllerOTP);

    if (res!.startsWith('13')) {
      
      showSuccesAlertDialog(context);
      print('Rezultat: $res');

    }

    else {
      
      showErrorAlertDialog(context);
      print('Rezultat: $res');

    }
  }

  verifyPinResetEmailOrPhone() async {
    
    
    print('verifyPinResetEmailOrPhone params pAdresaMail: ${widget.email}, pParola: ${widget.password}, pPINDinMail: ${controllerOTP}');

    String? res = await apiCallFunctions.schimbaDateleDeContactValidarePin(
        pAdresaMail: widget.email, pParola: widget.password, pPINDinMail: controllerOTP);
    print('verifyPinResetEmailOrPhone $res');

    if (res!.startsWith('13') && (widget.resetDoarTelefon == true)) {

      SharedPreferences prefs = await SharedPreferences.getInstance();
      //print('Aici resetEmailOrPhoneNumber ${widget.telefon!}');
      prefs.setString(pref_keys.userTelefon, widget.resetDoarTelefon? widget.telefon?? prefs.getString(pref_keys.userTelefon)!: prefs.getString(pref_keys.userTelefon)!);

      print('Rezultat: $res');

      showSuccesAlertModificareTelefonDialog(context);

      /*if (context.mounted) {
        Future.delayed(const Duration(milliseconds: 100), () {
          Navigator.of(context)
              .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const HomePage()), (route) => false);
        });
      }
      */

    }
    else if (res.startsWith('13'))
    {

      showSuccesAlertModificareEmailTelefonDialog(context);

    }

    else {
      
      showErrorAlertDialog(context);
      print('Rezultat: $res');

    } 
    
  }
}

showSuccesAlertModificareTelefonDialog(BuildContext context) {

  // set up the buttons
  Widget logInButton = TextButton(
    child: Text("Către pagina principală", 
      style: TextStyle(color: Colors.red),
    ),
    onPressed:  () {
      //Future.delayed(Duration(seconds: 1), () {
      //    Navigator.of(context)
      //        .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
      //});
      if (context.mounted) {
        Future.delayed(const Duration(milliseconds: 100), () {
          Navigator.of(context)
          .push(
            MaterialPageRoute(builder: (context) => const MyApp(fromPinPage: true,)));
            //.pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const MyApp()), (route) => false);
        });
      }
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Succes"),
    content: Text("Telefon modificat cu succes"),
    actions: [
      logInButton,
      //cancelButton,
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

showSuccesAlertModificareEmailTelefonDialog(BuildContext context) {

  // set up the buttons
  Widget logInButton = TextButton(
    child: Text("Log in"),
    onPressed:  () {
      //Future.delayed(Duration(seconds: 1), () {
      //    Navigator.of(context)
      //        .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
        //});
      if (context.mounted) {
        Future.delayed(const Duration(milliseconds: 100), () {
          Navigator.of(context)
              .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
        });
      }
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Succes"),
    content: Text("Email și/sau telefon modificat cu succes"),
    actions: [
      logInButton,
      //cancelButton,
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

showSuccesAlertDialog(BuildContext context) {

  // set up the buttons
  Widget logInButton = TextButton(
    child: Text("Intră în cont", 
      style: TextStyle(color: Colors.black)),
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
    title: Text("Succes"),
    content: Text("Parolă modificată cu succes"),
    actions: [
      logInButton,
      //cancelButton,
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

showErrorAlertDialog(BuildContext context) {

  Widget okButton = TextButton(
    child: Text("Ok"),
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
    content: Text("Codul introdus este incorect. Încearcă din nou."),
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
