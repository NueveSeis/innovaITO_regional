import 'dart:convert';

List<Semestre> semestreFromJson(String str) =>
    List<Semestre>.from(json.decode(str).map((x) => Semestre.fromJson(x)));

String semestreToJson(List<Semestre> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Semestre {
  String idSemestre;
  String numeroSemestre;

  Semestre({
    required this.idSemestre,
    required this.numeroSemestre,
  });

  factory Semestre.fromJson(Map<String, dynamic> json) => Semestre(
        idSemestre: json["Id_semestre"],
        numeroSemestre: json["Numero_semestre"],
      );

  Map<String, dynamic> toJson() => {
        "Id_semestre": idSemestre,
        "Numero_semestre": numeroSemestre,
      };
}
