import 'package:flutter/material.dart';
import 'package:student_data_app/views/add_details_screen/add_details_screen.dart';
import 'package:student_data_app/views/home_screen/home_screen.dart';
import 'package:student_data_app/views/pdf_preview_screen.dart';
import 'package:student_data_app/views/show_details_screen/show_details_screen.dart';

class Routes {
  Routes._();
  static Routes navigateTo = Routes._();

  String homeScreen = '/',
      showDetailsScreen = '/showDetailsScreen',
      addDetailsScreen = '/addDetailsScreen',
      pdfPreviewScreen = '/pdfPreview';

  static Map<String, WidgetBuilder> screens = {
    '/': (context) => const HomeScreen(),
    '/showDetailsScreen': (context) => const ShowDetailsScreen(),
    '/addDetailsScreen': (context) => const AddDetailsScreen(),
    '/pdfPreview': (context) => const PdfPreviewScreen(),
  };
}
