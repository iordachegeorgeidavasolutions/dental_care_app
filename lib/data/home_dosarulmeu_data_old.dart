import 'package:dental_care_app/screens/lista_programari_eu_copii.dart';
import 'package:dental_care_app/screens/programari.dart';
import 'package:dental_care_app/screens/tratamente.dart';
import '../utils/classes.dart';

List<DosarulMeu> dosarulMeuList = [
  //DosarulMeu(titlu: "Istoric Programări", widgetRoute: ProgramariScreen()),
  //DosarulMeu(titlu: "Istoric Programări", widgetRoute: ListaProgramariEuCopii()), //old IGV
  //DosarulMeu(titlu: "Istoric Programări", widgetRoute: ProgramariScreen()), //old Andrei Bădescu
  //DosarulMeu(titlu: "Istoric Programări", widgetRoute: ProgramariScreen(fromOtherPage: true, currentIndex: 0, isSelectedTrecute: true, isSelectedViitoare: false,)), //old IGV
  DosarulMeu(titlu: "Istoric Tratamente", widgetRoute: TratamenteScreen()),
];
