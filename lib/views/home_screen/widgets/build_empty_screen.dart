import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_data_app/views/home_screen/widgets/add_student_button.dart';

Center buildEmptyScreen(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 200,
          child: Image.asset('assets/empty-screen.png'),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'No student record found!',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        buildAddStudentButton(context),
      ],
    ),
  );
}
