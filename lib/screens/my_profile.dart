import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:acme_airlines_pi/globals.dart' as globals;

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  var userInfo = [];
  
  @override
  void initState() {
    loadUser();

    super.initState();
  }

  void loadUser() async {
    final url = Uri.parse('https://skystop.onrender.com/user');
    final jsonBody = {
      'email': globals.userEmail,
    };
    final body = jsonEncode(jsonBody);
    final response = await http.post(url, headers: {"Content-Type": "application/json"}, body: body);

    setState((){
      userInfo = jsonDecode(response.body);
    });
    
    print(userInfo);
  }

  @override
  Widget build(BuildContext context) {

     //final Map<String, dynamic> args =
      //ModalRoute.of(context).arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
            child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.account_circle_outlined,
              size: 300,
            ),
            Text(
              "Supervisor",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  Text(
                    "Informações do usuario",
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
                   Container(
                  decoration: BoxDecoration(
                    border:Border.all(
                      color: Colors.black,
                      width: 2.0
                      )
                  ),
                  padding: const EdgeInsets.only(left: 15, bottom: 15, right: 15),
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Nome Completo",
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                          ),
                          Icon(Icons.person, color: Colors.grey)
                          
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          for(var user in userInfo) Text("${user['name']} ${user['surname']}",
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("E-mail",
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                          ),
                          Icon(Icons.email, color: Colors.grey),
                        ],
                      ),
                      Row(
                        children: [
                          for(var user in userInfo) Expanded(
                            child: Text(user['email'].toString(),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                        
                    ],
                  ),
              ),
          ],
        )),
      ),
    );
  }
}
