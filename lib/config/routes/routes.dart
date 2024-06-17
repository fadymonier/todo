import 'package:flutter/material.dart';
import 'package:todo/features/home/presentation/pages/home.dart';

import '../../features/login/presentation/pages/login.dart';

class RoutesName {
  static const String login = "/";
  static const String home = "home";
}

class AppRoutes {
  static Route onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.login:
        return MaterialPageRoute(
          builder: (context) => LoginScreen(),
        );
      case RoutesName.home:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => unDefineRoute(),
        );
    }
  }

  static Widget unDefineRoute() {
    return const Scaffold(
      body: Center(child: Text("Route not Found")),
    );
  }
}
