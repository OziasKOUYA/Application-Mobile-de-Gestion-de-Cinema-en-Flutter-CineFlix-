class Salle{
  String? libelle;
  int? nombre_de_place;
  Salle({
    this.libelle,
    this.nombre_de_place,

});

  factory Salle.fromJson(Map<String, dynamic> json) {
    return Salle(
      libelle: json['libelle'],
      nombre_de_place: json['nombre_de_place'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'libelle': libelle,
      'nombre_de_place': nombre_de_place,


    };
  }
}
