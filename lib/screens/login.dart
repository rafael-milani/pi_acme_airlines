import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:acme_airlines_pi/screens/cadastro.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() {
    return LoginState();
  }
}


class LoginState extends State<Login> {
  String error = "";
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void authenticate(String email, String password) async {
    if(email.length == 0 || password.length == 0){
      return setState(() {
        error = "Email e/ou senha devem ser preenchidos.";
      });
    }

    final url = Uri.parse('https://skystop.onrender.com/user/authenticate');
    final jsonBody = {
      'email': email,
      'password': password
    };
    final body = jsonEncode(jsonBody);

    final response = await http.post(url, headers: {"Content-Type": "application/json"}, body: body);
    final responseBody = jsonDecode(response.body);
    final authenticated = responseBody['authenticated'];

    authenticated ? Navigator.pushNamed(context, "principal/") : setState(() { error = "Usuário e/ou senha inválidos"; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
        margin: const EdgeInsets.only(top: 20.0),
        padding: const EdgeInsets.all(10.0),
        height: 360,
        alignment: Alignment.topLeft,
        child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Align(
                alignment: Alignment.center,
                child: Text(
                  "Acme Airlines",
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Align(
                alignment: Alignment.center,
                child: Text(
                  "Fazer Login",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(
              child: TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(26.0),
                      ),
                    ),
                    labelText: "Email",
                    hintText: "Digite seu email"),
                controller: _emailController,
                validator: (value) {
                  if (value == null || value == "") {
                    return "Campo não pode estar vazio!";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            SizedBox(
              child: TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(26.0),
                      ),
                    ),
                    labelText: "Password",
                    hintText: "*****"),
                controller: _passwordController,
                obscureText: true,
                validator: (value) {
                  if (value == null || value == "") {
                    return "Campo não pode estar vazio!";
                  } else {
                    return null;
                  }
                },
              ),
            ),

             Row( 
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const Cadastro()));
                  },
                    child: const Text("Cadastre-se"),
                    ),
                    ElevatedButton(
                      onPressed: () => authenticate(_emailController.text, _passwordController.text),
                      child: const Text("Entrar"),
                    ),
                  ],
                ),
                Text(
                  error,
                  style: const TextStyle(color: Colors.red, fontSize: 20.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}