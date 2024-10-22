class Ticket{
int? numero;
String? type;
double? prix;
Ticket({
  this.numero,
  this.prix,
  this.type,
});

factory Ticket.fromJson(Map<String, dynamic> json) {
  return Ticket(
    numero: json['numero'],
    type: json['type'],
    prix: json['prix'],

  );
}

Map<String, dynamic> toJson() {
  return {
    'numero': numero,
    'type': type,
    'prix': prix,

  };
}
}