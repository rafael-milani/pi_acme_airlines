import 'package:acme_airlines_pi/screens/tabs_screen.dart';
import 'package:flutter/material.dart';

class AppRouter{
  Route? onGenerateRoute(RouteSettings routeSettings){
    switch(routeSettings.name){
      case TabsScreen.id:
      return MaterialPageRoute(
        builder: (_)=> TabsScreen(),
        );
        default: 
          return null;
    }
  }  
}