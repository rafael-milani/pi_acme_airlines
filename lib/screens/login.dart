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
  String erro = "";
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.airplanemode_active,
                  size: 150,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Acme Airlines',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                ),
                SizedBox(height: 10),
                Text(
                  'Bem vindo de volta!',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: "Email"),
                        controller: _usernameController,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: "Senha"),
                        controller: _passwordController,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: () {
                      if (_usernameController.text.isEmpty ||
                          _passwordController.text.isEmpty) {
                        setState(() {
                          erro = "Os campos não podem estar vazios!";
                        });
                      }
                      else if (_usernameController.text == "user" &&
                          _passwordController.text == "123") {
                        Navigator.pushNamed(context, "principal/");
                      } else {
                        setState(() {
                          erro = "Usuário e/ou senha inválidos";
                        });
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                          child: Text(
                        'Entrar',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      )),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(erro, 
                style: const TextStyle(color: Colors.red, fontSize: 20.0),
                ),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
