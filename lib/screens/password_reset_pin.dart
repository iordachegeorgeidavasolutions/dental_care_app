import 'package:dental_care_app/screens/login.dart';
import 'package:dental_care_app/utils/api_call_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class PasswordResetPin extends StatefulWidget {
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
                    text: 'Verificare OTP',
                    style: TextStyle(color: Colors.black, fontSize: 35, fontWeight: FontWeight.bold))),
            const SizedBox(height: 25),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: 'Introduceti codul de 4 cifre trimis la:\n',
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    children: [
                      TextSpan(
                        text: widget.email,
                        style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ])),
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
                    minimumSize: const Size.fromHeight(50), // NEW
                  ),
                  child: const Text(
                    'Verifica codul',
                    style: TextStyle(fontSize: 22),
                  ),
                  onPressed: widget.resetEmailOrPhoneNumber
                      ? () {
                          verifyPinResetEmailOrPhone();
                          print(controllerOTP);
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
                        }
                      : () {
                          verifyPinResetPassword();
                          print(controllerOTP);
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
                        }),
            ),
          ],
        ),
      )),
    );
  }

  verifyPinResetPassword() async {
    String? res = await apiCallFunctions.reseteazaParolaValidarePIN(
        pAdresaMail: widget.email, pParolaNoua: widget.password, pPINDinMail: controllerOTP);
    print(res);
  }

  verifyPinResetEmailOrPhone() async {
    String? res = await apiCallFunctions.schimbaDateleDeContactValidarePin(
        pAdresaMail: widget.email, pParola: widget.password, pPINDinMail: controllerOTP);
    print(res);
  }
}
