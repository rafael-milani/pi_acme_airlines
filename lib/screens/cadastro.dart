import 'package:flutter/material.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() {
    return CadastroState();
  }
}

class CadastroState extends State<Cadastro> {
  String erro = "";
  final _globalKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _globalKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person_add,
                    size: 150,
                  ),
                  Text(
                    'Cadastro',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                  ),
                  SizedBox(
                    height: 40,
                  ),
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
                              border: InputBorder.none, hintText: "Nome"),
                          controller: _nameController,
                          validator: (value) {
                            if (_nameController.text.isEmpty) {
                              return "Este campo não pode ser vazio!";
                            } else {
                              return null;
                            }
                          },
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
                          decoration: const InputDecoration(
                              border: InputBorder.none, hintText: "Email"),
                          controller: _emailController,
                          validator: (value) {
                            if (_emailController.text.isEmpty) {
                              return "Este campo não pode ser vazio!";
                            } else if (!_emailController.text.contains('@')) {
                              return "Este campo precisa ser um email válido (@)";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: GestureDetector(
                      onTap: () {
                       if (_globalKey.currentState!.validate()) {
                        if (validation([
                          _nameController,
                          _emailController,
                        ])) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Salvando os dados"),
                            padding: EdgeInsets.all(10.0),
                            duration: Duration(seconds: 3),
                            //showCloseIcon: true,
                          ));
                          setState(() {
                            erro = "";
                          });
                          Navigator.pop(context);
                        }
                      } else {
                        setState(() {
                          erro = "Preencha todos os campos corretamente!";
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
                          'Cadastrar',
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
                  Text(
                erro,
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
      ),
    );
  }
}

bool validation(List<TextEditingController> l) {
  if ((l[0].text.isNotEmpty) && (l[1].text.isNotEmpty)) {
    return true;
  } else {
    return false;
  }
}
