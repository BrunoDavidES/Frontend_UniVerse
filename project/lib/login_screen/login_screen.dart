import 'package:UniVerse/main_screen/app/homepage_app.dart';
import 'package:flutter/material.dart';

import 'functions/auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();

    super.initState();
  }

  void logInButtonPressed(String email, String password) {
    //TODO: Also check the email
    bool pwCompliant = Authentication.isPasswordCompliant(password);

    if (!pwCompliant) {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text("Invalid password format!"),
          );
        },
      );
    }
    // TODO: Check if the User can be logged in.
    //  API Call to your GoogleAppEngine or Dummy API
    else if (Authentication.loginUser(email, password)) {

      // TODO: Update the DB with the last active time of the user

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AppHomePage()),
      );
    } else {
      // Wrong credentials
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text("Wrong Password!"),
          );
        },
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: TextField(
            controller: emailController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              labelText: "Identificador"
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: TextField(
            obscureText: true,
            controller: passwordController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              labelText: 'Senha',
            ),
          ),
        ),
        Container(
            height: 80,
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(25),
              ),
              child: const Text('Log In'),
              onPressed: () => logInButtonPressed(
                  emailController.text, passwordController.text),
            )),
        TextButton(
          onPressed: () {},
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          ),
          child: const Text('Forgot Password?'),
        ),
      ],
    );
  }
}