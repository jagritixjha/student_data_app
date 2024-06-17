import 'package:flutter/material.dart';
import 'package:student_data_app/utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Data App',
      // home: const PdfPreviewScreen(),
      routes: Routes.screens,
    );
  }
}
