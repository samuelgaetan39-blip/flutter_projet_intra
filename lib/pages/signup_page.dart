import 'package:flutter/material.dart';
import '../services/user_service.dart';
import '../models/user.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  // Kontwolè pou chan yo
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _adresseController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _motDePasseController = TextEditingController();

  String? _sexe;
  DateTime? _dateNaissance;

  /// Selektè dat
  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      locale: const Locale('fr', 'FR'),
    );
    if (picked != null && picked != _dateNaissance) {
      setState(() {
        _dateNaissance = picked;
      });
    }
  }

  /// Fonksyon enskripsyon
  void _inscrire() {
    if (_formKey.currentState!.validate()) {
      if (_sexe == null || _dateNaissance == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Veuillez remplir tous les champs.")),
        );
        return;
      }

      final email = _emailController.text.trim();

      // Verifikasyon itilizatè egzistan
      if (UserService.emailExiste(email)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Cet e-mail est déjà utilisé.")),
        );
        return;
      }

      // Kreyasyon nouvo itilizatè
      final nouvelUtilisateur = User(
        nom: _nomController.text.trim(),
        prenom: _prenomController.text.trim(),
        sexe: _sexe!,
        adresse: _adresseController.text.trim(),
        dateNaissance: _dateNaissance!,
        email: email,
        motDePasse: _motDePasseController.text.trim(),
      );

      // Ajou nouvo itilizatè a nan yon lis
      UserService.ajouterUtilisateur(nouvelUtilisateur);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Inscription réussie !")));

      // Redireksyon pou ale nan paj koneksyon an
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Inscription",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _prenomController,
                decoration: const InputDecoration(labelText: "Prénom·s"),
                validator: (value) => value == null || value.isEmpty
                    ? "Veuillez entrer votre ou vos prénoms."
                    : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _nomController,
                decoration: const InputDecoration(labelText: "Nom"),
                validator: (value) => value == null || value.isEmpty
                    ? "Veuillez entrer votre nom."
                    : null,
              ),
              const SizedBox(height: 12),

              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: "Sexe"),
                items: const [
                  DropdownMenuItem(value: "Homme", child: Text("Homme")),
                  DropdownMenuItem(value: "Femme", child: Text("Femme")),
                ],
                onChanged: (value) => setState(() => _sexe = value),
                validator: (value) =>
                    value == null ? "Veuillez sélectionner votre sexe." : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _adresseController,
                decoration: const InputDecoration(labelText: "Adresse"),
                validator: (value) => value == null || value.isEmpty
                    ? "Veuillez entrer votre adresse."
                    : null,
              ),
              const SizedBox(height: 12),

              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Date de naissance",
                      hintText: "Sélectionnez votre date",
                      suffixIcon: const Icon(Icons.calendar_today),
                    ),
                    controller: TextEditingController(
                      text: _dateNaissance == null
                          ? ''
                          : "${_dateNaissance!.day}/${_dateNaissance!.month}/${_dateNaissance!.year}",
                    ),
                    validator: (_) => _dateNaissance == null
                        ? "Veuillez sélectionner votre date de naissance."
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: "E-mail"),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez entrer un e-mail.";
                  } else if (!value.contains('@')) {
                    return "E-mail invalide.";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _motDePasseController,
                decoration: const InputDecoration(labelText: "Mot de passe"),
                obscureText: true,
                validator: (value) => value == null || value.length < 6
                    ? "Le mot de passe doit contenir au moins 6 caractères."
                    : null,
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _inscrire,
                child: const Text("S'inscrire"),
              ),
              const SizedBox(height: 10),

              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: const Text(
                  "Déjà inscrit·e ? Connectez-vous.",
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
