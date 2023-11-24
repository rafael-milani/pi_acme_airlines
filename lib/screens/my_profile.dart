import 'package:flutter/material.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
            child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.account_circle_outlined,
              size: 300,
              ),
              SizedBox(
                  height: 30,
                ),
                Text(
                  'Perfil',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                ),
          ],
        )),
      ),
    );
  }
}
