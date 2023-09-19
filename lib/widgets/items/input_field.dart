// import 'package:flutter/material.dart';

// class MyTextField extends StatelessWidget {
//   final String title;
//   final String hint;
//   final TextEditingController? controller;
//   final Widget? widget;
//   // final double? width;

//   const MyTextField({super.key, required this.title, required this.hint, this.controller, this.widget});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(top: 10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(title, style: const TextStyle(fontSize: 22)),
//           Container(
//               // width: width,
//               height: 55,
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               margin: const EdgeInsets.only(top: 10),
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey, width: 1),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Row(
//                 children: [
//                   TextFormField(
//                     readOnly: widget == null ? false : true,
//                     autocorrect: false,
//                     autofocus: false,
//                     controller: controller,
//                     decoration: InputDecoration(
//                       hintText: hint,
//                     ),
//                   ),
//                   widget == null ? Container() : Container(child: widget)
//                 ],
//               )),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final String? hint;
  final Widget? widget;

  const InputField({super.key, required this.title, this.controller, required this.hint, this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Container(
              padding: const EdgeInsets.only(left: 14.0),
              height: 52,
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 2.0,
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(12.0)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      autofocus: false,
                      readOnly: widget == null ? false : true,
                      controller: controller,
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hint,
                      ),
                    ),
                  ),
                  widget == null ? Container() : widget!,
                ],
              ),
            )
          ],
        ));
  }
}
