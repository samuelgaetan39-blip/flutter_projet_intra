import '../models/user.dart';

class UserService {
  static final List<User> _utilisateurs = [];

  /// Ajoute yon itilizatè nan lis la
  static void ajouterUtilisateur(User user) {
    _utilisateurs.add(user);
  }

  /// Verifye si yon imel egziste deja
  static bool emailExiste(String email) {
    return _utilisateurs.any(
      (u) => u.email.toLowerCase() == email.toLowerCase(),
    );
  }

  /// Rekipere lis itilizatè yo
  static List<User> getUtilisateurs() {
    return _utilisateurs;
  }

  /// Vide lis la (sa ki opsyonèl, men ki ka itil pou tès oswa risèt)
  static void clear() {
    _utilisateurs.clear();
  }
}
