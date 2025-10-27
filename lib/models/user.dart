class User {
  final String nom;
  final String prenom;
  final String sexe;
  final String adresse;
  final DateTime dateNaissance;
  final String email;
  final String motDePasse;

  User({
    required this.nom,
    required this.prenom,
    required this.sexe,
    required this.adresse,
    required this.dateNaissance,
    required this.email,
    required this.motDePasse,
  });
}
