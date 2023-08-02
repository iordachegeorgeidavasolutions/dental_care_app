import '../utils/classes.dart';
import 'package:dental_care_app/main.dart';
// import 'package:dental_care_app/pages/programari.dart';
import 'package:dental_care_app/pages/tratamente.dart';
import 'package:flutter/material.dart';

List<DosarulMeu> dosarulMeuList = [
  DosarulMeu(titlu: "Istoric Programari", widgetRoute: MyApp()),
  DosarulMeu(titlu: "Istoric tratamente", widgetRoute: TratamenteScreen())
];
