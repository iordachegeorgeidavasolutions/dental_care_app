import 'package:flutter/material.dart';

class DosarulMeu {
  final String titlu;
  final Widget widgetRoute;

  DosarulMeu({
    required this.titlu,
    required this.widgetRoute,
  });
}

class Sediu {
  final String id, denumire, adresa, telefon;

  Sediu({required this.id, required this.denumire, required this.adresa, required this.telefon});
}

class DetaliiProgramare {
  final String dataInceput;
  final String oraFinal;
  final String numeMedic;
  final String idCategorie;
  final String statusProgramare;
  final String esteAnulat;
  final String numeLocatie;
  final List<String> listaInterventii;

  DetaliiProgramare({
    required this.dataInceput,
    required this.oraFinal,
    required this.numeMedic,
    required this.idCategorie,
    required this.statusProgramare,
    required this.esteAnulat,
    required this.numeLocatie,
    required this.listaInterventii,
  });

  double GetTotal() {
    // print(listaInterventii.map((e) => e.split("*\$*")[6]).toList()[0]);
    // return listaInterventii
    //     .map((e) => e.split("*\$*"))
    //     .where((element) => element.length >= 7)
    //     .map((e) => e[6])
    //     .map((e) => e.replaceAll(RegExp(r'([A-Z\s,])'), ""))
    //     .map((e) => double.parse(e))
    //     .reduce((value, element) => value + element);
    double total = 0;
    print(listaInterventii);
    for (var interv in listaInterventii) {
      if (interv.isEmpty) continue;
      String pretstr = interv.split("*\$*")[6];
      pretstr = pretstr.replaceAll(RegExp(r'([A-Z\s,])'), "");
      print(pretstr);
      double pret = double.parse(pretstr);
      total += pret;
    }
    return total;
  }
}

class Programare {
  final String locatie;
  final String idMedic;
  String hasFeedback;
  final String id;
  final DateTime inceput, sfarsit;
  final String medic, categorie;
  String status, anulata;
  final String idPacient, nume, prenume;

  static const String statusConfirmat = "Confirmat";
  static const String statusAnulat = "Anulat";

  Programare(
      {required this.id,
      required this.medic,
      required this.anulata,
      required this.categorie,
      required this.inceput,
      required this.sfarsit,
      required this.status,
      required this.idPacient,
      required this.nume,
      required this.prenume,
      required this.locatie,
      required this.idMedic,
      required this.hasFeedback,});
}

class LinieFisaTratament {
  final String tipObiect;
  final String idObiect;
  final String numeMedic;
  final String denumireInterventie;
  final String dinti;
  final String observatii;
  final DateTime dataDateTime;
  final String dataString;
  final String pret;
  final Color culoare;
  final DateTime? dataCreareDateTime;
  final String? dataCreareString;
  final String valoareInitiala;

  LinieFisaTratament(
      {required this.tipObiect,
      required this.pret,
      required this.idObiect,
      required this.numeMedic,
      required this.denumireInterventie,
      required this.dinti,
      required this.observatii,
      required this.dataDateTime,
      required this.dataString,
      required this.culoare,
      this.dataCreareDateTime,
      this.dataCreareString,
      required this.valoareInitiala});
}

class Programari {
  List<Programare> viitoare;
  List<Programare> trecute;

  Programari({required this.viitoare, required this.trecute});
}

class MembruFamilie {
  final String id, nume, prenume;

  MembruFamilie({required this.id, required this.nume, required this.prenume});
}

class Shared {
  
  static GlobalKey<NavigatorState> sharedNavigatorKey = GlobalKey<NavigatorState>();
  // static String flavor = '';
  static String FCMtoken = '';
  static String idMembruFamilieConectat = '_';
  static String sediuPacient = '';
  //static List<Medic> medici = <Medic>[];
  //static List<MedicSlotLiber> mediciFiltrati = <MedicSlotLiber>[];
  //static List<CategorieProgramare> categorii = <CategorieProgramare>[];
  static List<MembruFamilie> familie = <MembruFamilie>[];
  static List<Sediu> sedii = <Sediu>[];
  static String idPacientAsociat = '0';

  //static GenericLanguage limba = LanguageEN();

}