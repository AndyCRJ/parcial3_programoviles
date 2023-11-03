// Implementar login con la validación de datos que se tiene en el archivo services/data.dart

import 'package:flutter/material.dart';
import 'package:parcial3/screens/home.dart';
import 'package:parcial3/classes/userData.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    /* return ElevatedButton(
        onPressed: (() => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: ((context) => const HomeScreen())))),
        child: const Text('Iniciar sesión')); */
    return LoginForm();
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    String enteredUsername = _usernameController.text;
    String enteredPassword = _passwordController.text;

    bool isValidUser = false;

    for (var user in users) {
      if (user.username == enteredUsername &&
          user.password == enteredPassword) {
        isValidUser = true;
        break;
      }
    }

    if (isValidUser) {
      // Navigator.push(context, MaterialPageRoute(builder: (context) => NextScreen()));
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: ((context) => const HomeScreen())));
      print('Inicio de sesión exitoso');
    } else {
      print('Nombre de usuario o contraseña incorrectos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(labelText: 'Nombre de usuario'),
          ),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Contraseña'),
            obscureText: true,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _login,
            child: const Text('Iniciar sesión'),
          ),
        ],
      ),
    );
  }
}
