import 'package:flutter/material.dart';

import '../home/home_screen.dart';

class RoutesManager {
  static const String home = '/home';
  static Map<String, WidgetBuilder> routes = {
    home: (context) => const HomeScreen(),
  };
}
