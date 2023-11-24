import 'package:acme_airlines_pi/blocs/bloc_exports.dart';
import 'package:acme_airlines_pi/screens/cadastro.dart';
import 'package:acme_airlines_pi/screens/login.dart';
import 'package:acme_airlines_pi/screens/my_profile.dart';
import 'package:acme_airlines_pi/screens/tasks_screen.dart';
import 'package:acme_airlines_pi/screens/tabs_screen.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
          child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            color: Colors.white,
            child: Text(
              'Menu',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
               GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyProfile()));
                  },
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Meu Perfil'), 
                ),
          ),
          const Divider(),
          GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Cadastro()));
                  },
                child: ListTile(
                  leading: Icon(Icons.person_add),
                  title: Text('Cadastrar Usuario'), 
                ),
          ),
          const Divider(),
          GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Login()));
                  },
                child: ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Sair'), 
                ),
          ),
            ],
          ),
      ),
    );
  }
}
