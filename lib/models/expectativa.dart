import 'dart:convert';

List<Expectativa> expectativaFromJson(String str) => List<Expectativa>.from(
    json.decode(str).map((x) => Expectativa.fromJson(x)));

String expectativaToJson(List<Expectativa> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Expectativa {
  String idExpectativa;
  String expectativa;

  Expectativa({
    required this.idExpectativa,
    required this.expectativa,
  });

  factory Expectativa.fromJson(Map<String, dynamic> json) => Expectativa(
        idExpectativa: json["Id_expectativa"],
        expectativa: json["Expectativa"],
      );

  Map<String, dynamic> toJson() => {
        "Id_expectativa": idExpectativa,
        "Expectativa": expectativa,
      };
}
