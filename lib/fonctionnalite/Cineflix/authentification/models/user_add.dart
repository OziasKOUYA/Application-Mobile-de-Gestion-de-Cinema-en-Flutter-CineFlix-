
class User_add {
   String? nom;
   String? prenom;
   String? username;
   String? email;
   String? password1;
   String? password2;

   User_add({
     this.nom,
     this.prenom,
     this.username,
     this.email,
     this.password1,
     this.password2,
  });

   factory User_add.fromJson(Map<String, dynamic> json) {
     return User_add(
       username: json['username'],
       email: json['email'],
       nom: json['nom'],
       prenom: json['prenom'],

     );
   }





}
