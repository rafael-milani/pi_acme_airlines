import 'package:flutter/material.dart';
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
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                        labelText: "Username",
                        hintText: "Digite seu usuário"),
                    controller: _usernameController,
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
                        if (_usernameController.text == "user" &&
                            _passwordController.text == "123") {
                          Navigator.pushNamed(context, "principal/");
                        } else {
                          setState(() {
                            error = "Usuário e/ou senha inválidos";
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(
                            10.0), // Adjust the padding as needed
                        child: Text("Entrar"),
                      ),
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
