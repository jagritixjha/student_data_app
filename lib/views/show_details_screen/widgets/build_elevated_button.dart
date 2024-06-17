import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_data_app/utils/global_data.dart';
import 'package:student_data_app/utils/student_modal.dart';

ElevatedButton buildElevatedButton({
  required StudentData sd,
  required BuildContext context,
  required String text,
  required Color bg,
  required void Function()? onPressed,
  double? size,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: bg,
      fixedSize: Size(size ?? MediaQuery.of(context).size.width, 48),
      shadowColor: Colors.blue.shade50,
      elevation: 6,
    ),
    child: Text(
      text,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
          fontSize: 16,
          color: primaryTextColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}
