import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _errorMessage;

  void _login() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      // Verifikasyon idantifyan yo
      if (email == "admin@gmail.com" && password == "admin1234#") {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        setState(() {
          _errorMessage = "Identifiants incorrects.";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Connexion",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),

                // Chan imel
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: "E-mail",
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Veuillez entrer votre e-mail.";
                    } else if (!value.contains('@')) {
                      return "E-mail invalide.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Chan modpas
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: "Mot de passe",
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Veuillez entrer votre mot de passe.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // Mesaj erè
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),

                // Bouton koneksyon
                ElevatedButton(
                  onPressed: _login,
                  child: const Text("Se connecter"),
                ),
                const SizedBox(height: 10),

                // Lyen pou ale nan paj enskripsyon
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/signup');
                  },
                  child: const Text(
                    "Pas encore inscrit·e ? Créez un compte.",
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
