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
