import 'package:flutter/material.dart';

class DosarulMeu {
  final String titlu;
  final Widget widgetRoute;

  DosarulMeu({
    required this.titlu,
    required this.widgetRoute,
  });
}

class Programare {
  final String id;
  final DateTime inceput, sfarsit;
  final String medic, categorie, status;
  final bool anulata;
  final String idPacient, nume, prenume;

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
      required this.prenume});
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

class DetaliiProgramare {
  final String idInterventie;
  final String medicResponsabil;
  final String denumireInterventie;
  final String observatii;
  final String valoareInterventie;

  DetaliiProgramare(
      this.idInterventie, this.medicResponsabil, this.denumireInterventie, this.observatii, this.valoareInterventie);
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
