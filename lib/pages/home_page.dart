import 'package:flutter/material.dart';
import '../services/user_service.dart';
import '../models/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<User> utilisateurs = [];

  @override
  void initState() {
    super.initState();
    // Chaje itilizatè yo lè lansman
    utilisateurs = UserService.getUtilisateurs();
  }

  void _deconnexion() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Page d'accueil",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: _deconnexion,
            icon: const Icon(Icons.logout),
            tooltip: 'Déconnexion',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: utilisateurs.isEmpty
            ? const Center(
                child: Text(
                  "Aucun utilisateur inscrit pour le moment.",
                  style: TextStyle(fontSize: 16),
                ),
              )
            : ListView.builder(
                itemCount: utilisateurs.length,
                itemBuilder: (context, index) {
                  final user = utilisateurs[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: const Icon(Icons.person),
                      title: Text("${user.prenom} ${user.nom}"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Sexe : ${user.sexe}"),
                          Text("E-mail : ${user.email}"),
                          Text("Adresse : ${user.adresse}"),
                          Text(
                            "Date de naissance : ${user.dateNaissance.day}/${user.dateNaissance.month}/${user.dateNaissance.year}",
                          ),
                        ],
                      ),
                      isThreeLine: true,
                    ),
                  );
                },
              ),
      ),
    );
  }
}
