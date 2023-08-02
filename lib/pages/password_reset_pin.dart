import 'package:flutter/material.dart';

class PasswordResetPin extends StatefulWidget {
  const PasswordResetPin({super.key});

  @override
  State<PasswordResetPin> createState() => _PasswordResetPinState();
}

class _PasswordResetPinState extends State<PasswordResetPin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 236, 236),
      body: SafeArea(
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
                    "Inapoi",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400, color: Colors.black),
                  ),
                )
              ]),
            ],
          ),
          const SizedBox(height: 80),
          const Text('Introduceti codul de verificare', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23)),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Form(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 68,
                  width: 64,
                  child: TextField(
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      if (value.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                    style: Theme.of(context).textTheme.headlineLarge,
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(
                  height: 68,
                  width: 64,
                  child: TextField(
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      if (value.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                    style: Theme.of(context).textTheme.headlineLarge,
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(
                  height: 68,
                  width: 64,
                  child: TextField(
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      if (value.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                    style: Theme.of(context).textTheme.headlineLarge,
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(
                  height: 68,
                  width: 64,
                  child: TextField(
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      if (value.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                    style: Theme.of(context).textTheme.headlineLarge,
                    keyboardType: TextInputType.number,
                  ),
                )
              ],
            )),
          )
        ],
      )),
    );
  }
}
