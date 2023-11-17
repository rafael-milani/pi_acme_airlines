import 'package:acme_airlines_pi/screens/principal.dart';
import 'package:acme_airlines_pi/screens/recycle_bin.dart';
import 'package:flutter/material.dart';

class AppRouter{
  Route? onGenerateRoute(RouteSettings routeSettings){
    switch(routeSettings.name){
      case RecycleBin.id:
      return MaterialPageRoute(
        builder: (_)=> const RecycleBin(),
        );
      case Principal.id:
      return MaterialPageRoute(
        builder: (_)=> const Principal(),
        );
        default: 
          return null;
    }
  }  
}