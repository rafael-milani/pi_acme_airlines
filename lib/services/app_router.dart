import 'package:acme_airlines_pi/screens/pending_screen.dart';
import 'package:acme_airlines_pi/screens/recycle_bin.dart';
import 'package:acme_airlines_pi/screens/tabs_screen.dart';
import 'package:flutter/material.dart';

class AppRouter{
  Route? onGenerateRoute(RouteSettings routeSettings){
    switch(routeSettings.name){
      case RecycleBin.id:
      return MaterialPageRoute(
        builder: (_)=> const RecycleBin(),
        );
      case TabsScreen.id:
      return MaterialPageRoute(
        builder: (_)=> TabsScreen(),
        );
        default: 
          return null;
    }
  }  
}