import 'package:flutter/material.dart';

class ProfileModalItem extends StatelessWidget {
  final String icon;
  final String text;
  const ProfileModalItem({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Image.asset(
            icon,
            height: 30,
          ),
          title: Text(
            text,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          ),
        ),
        Divider(
          color: Colors.black12,
          height: 7,
          thickness: 0.5,
        ),
      ],
    );
  }
}
