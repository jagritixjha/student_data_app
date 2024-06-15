import 'package:flutter/material.dart';
import 'package:student_data_app/views/add_details_screen.dart';
import 'package:student_data_app/views/home_screen.dart';
import 'package:student_data_app/views/show_details_screen/show_details_screen.dart';

class Routes {
  Routes._();
  static Routes navigateTo = Routes._();

  String homeScreen = '/',
      showDetailsScreen = 'showDetailsScreen',
      addDetailsScreen = 'addDetailsScreen';

  static Map<String, WidgetBuilder> screens = {
    '/': (context) => const HomeScreen(),
    'showDetailsScreen': (context) => const ShowDetailsScreen(),
    'addDetailsScreen': (context) => const AddDetailsScreen(),
  };
}
