import 'package:flutter/material.dart';
import '../../utils/classes.dart';
import '../items/program_modal_item.dart';

class ProgramariModal extends StatelessWidget {
  final Programare programare;
  const ProgramariModal({super.key, required this.programare});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
          ),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(children: [
                IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_outlined),
                    color: Colors.red,
                    onPressed: () => Navigator.pop(context)),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Text(
                    "Inapoi",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400, color: Colors.red),
                  ),
                )
              ]),
              const SizedBox(height: 15),
              Column(
                children: [
                  const SizedBox(height: 20),
                  ProgramModalItem(
                    programare: programare,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
