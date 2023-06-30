class Programare {
  final String data;
  final String ora;
  final String locatie;
  final String status;
  final String tratament;
  final String financiar;
  final String doctor;
  final String state;
  bool isConfirmata = true;

  Programare(
      {required this.data,
      required this.isConfirmata,
      required this.ora,
      required this.locatie,
      required this.status,
      required this.tratament,
      required this.financiar,
      required this.doctor,
      required this.state});
}
