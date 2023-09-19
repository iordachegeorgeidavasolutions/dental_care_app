import 'package:dental_care_app/pages/password_reset_pin.dart';
import 'package:dental_care_app/pages/register.dart';
import 'package:flutter/material.dart';
import 'package:dental_care_app/utils/api_call_functions.dart';
import '../utils/functions.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({super.key});

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

ApiCallFunctions apiCallFunctions = ApiCallFunctions();

class _PasswordResetState extends State<PasswordReset> {
  bool verificationOk = false;
  final loginKey = GlobalKey<FormState>();
  bool isHidden = true;
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
            const SizedBox(height: 30),
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
                      "Inapoi",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400, color: Colors.black),
                    ),
                  )
                ]),
              ],
            ),
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
                    "Reseteaza parola!",
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: const Size.fromHeight(50), // NEW
                ),
                onPressed: () {
                  final isValidForm = loginKey.currentState!.validate();
                  if (isValidForm) {
                    resetPassword();
                  }
                },
                child: const Text(
                  'Trimite cererea de resetare',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            const SizedBox(height: 15),
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
            controller: controllerEmail,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide.none,
              ),
              focusedBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8.0)), borderSide: BorderSide.none),
              hoverColor: Colors.red,
              filled: true,
              fillColor: Colors.white,
              hintText: "E-mail",
            ),
            validator: (value) {
              if (value!.isEmpty || !RegExp(r'.+@.+\.+').hasMatch(value)) {
                return "Enter a valid Email Address";
              } else {
                return null;
              }
            },
          ),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            focusNode: focusNodePassword,
            controller: controllerPass,
            obscureText: isHidden,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: passVisibiltyToggle,
                    icon: isHidden ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off)),
                hintText: "Parola noua",
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

  resetPassword() async {
    String? res =
        await apiCallFunctions.reseteazaParola(pAdresaMail: controllerEmail.text, pParolaNoua: controllerPass.text);
    print(res);
    if (res == null) {
      showSnackbar(
        context,
        "E-mail gresit!",
      );
      return;
    } else if (res.startsWith('66')) {
      showSnackbar(context, "E-mail gresit!");
      return;
    } else if (res.startsWith('13')) {
      showSnackbar(context, "E-mail corect - cerere trimisa!");
      setState(() {
        verificationOk = true;
        if (verificationOk) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PasswordResetPin(
                    resetEmailOrPhoneNumber: false,
                    password: controllerPass.text,
                    email: controllerEmail.text,
                  )));
        }
      });

      return;
    }
  }
}
