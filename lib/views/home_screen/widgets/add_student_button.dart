import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_data_app/utils/global_data.dart';
import 'package:student_data_app/utils/routes.dart';

TextButton buildAddStudentButton(BuildContext context) {
  return TextButton.icon(
    onPressed: () {
      Navigator.pushNamed(
        context,
        Routes.navigateTo.addDetailsScreen,
      );
    },
    style: TextButton.styleFrom(
      backgroundColor: primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      minimumSize: const Size(100, 44),
    ),
    icon: Icon(
      Icons.add,
      size: 20,
      color: primaryTextColor,
    ),
    label: Text(
      'Add Student',
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: primaryTextColor,
        ),
      ),
    ),
  );
}
