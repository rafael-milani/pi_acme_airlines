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

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tela de cadastro"),
        actions: [
          TextButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, "principal/");
              },
              icon: const Icon(Icons.home),
              label: const Text(""))
        ],
      ),
      body: Form(
          key: _globalKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(
                  hintText: "Nome completo",
                  labelText: "Nome",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(26.0)),
                ),
                validator: (value) {
                  if (_nomeController.text.isEmpty) {
                    return "Este campo não pode ser vazio!";
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "exemplo@exemplo.com",
                  labelText: "Email",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(26.0)),
                ),
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
              TextFormField(
                controller: _dataController,
                decoration: InputDecoration(
                  hintText: "DD/MM/AAAA",
                  labelText: "Data de Nascimento",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(26.0)),
                ),
                validator: (value) {
                  if (_dataController.text.isEmpty) {
                    return "Este campo não pode ser vazio!";
                  } else if (!_dataController.text.contains('/')) {
                    return "O compo precisa ser um formato válido contendo '/' ";
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                controller: _cpfController,
                decoration: InputDecoration(
                  hintText: "xxx.xxx.xxx-xx",
                  labelText: "CPF",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(26.0)),
                ),
                validator: (value) {
                  if (_cpfController.text.isEmpty) {
                    return "Este campo não pode ser vazio!";
                  } else {
                    return null;
                  }
                },
              ),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                    onPressed: () {
                      if (_globalKey.currentState!.validate()) {
                        if (validation([
                          _nomeController,
                          _emailController,
                          _dataController,
                          _cpfController
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
                    icon: const Icon(Icons.save),
                    label: const Text("Salvar")),
              ),
              Text(
                erro,
                style: const TextStyle(color: Colors.red, fontSize: 20.0),
              ),
            ],
          )),
    );
  }
}

bool validation(List<TextEditingController> l) {
  if ((l[0].text.isNotEmpty) &&
      (l[1].text.isNotEmpty) &&
      (l[2].text.isNotEmpty) &&
      (l[3].text.isNotEmpty)) {
    return true;
  } else {
    return false;
  }
}
