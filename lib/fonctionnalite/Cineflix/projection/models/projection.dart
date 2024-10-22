class Projection{
  String? film;
  String?salle;
  String?date;
  String?heure;

  Projection({
    this.film,
    this.salle,
    this.date,
    this.heure,
});

  factory Projection.fromJson(Map<String, dynamic> json) {
    return Projection(
      film: json['film'],
      salle: json['salle'],
      date: json['date'],
      heure: json['heure'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'film': film,
      'salle': salle,
      'date': date,
      'heure': heure,


    };
  }
}