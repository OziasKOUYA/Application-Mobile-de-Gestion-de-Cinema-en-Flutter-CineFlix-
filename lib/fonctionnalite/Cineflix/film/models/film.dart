class Film{
  int?id;
  String?affiche;
  String?titre;
  String?description;
  String?acteur_principal;
  String?duree;

  Film({
    this.id,
    this.affiche,
    this.titre,
    this.description,
    this.acteur_principal,
    this.duree,
});

  factory Film.fromJson(Map<String, dynamic> json) {
    return Film(
      id: json['id'],
      affiche: json['affiche'],
      titre: json['titre'],
      description: json['description'],
      acteur_principal: json['acteur_principal'],
      duree: json['duree'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'affiche': affiche,
      'titre': titre,
      'description': description,
      'acteur_principal': acteur_principal,
      'duree': duree,


    };
  }

}
