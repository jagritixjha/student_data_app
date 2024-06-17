import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_data_app/utils/global_data.dart';
import 'package:student_data_app/utils/routes.dart';
import 'package:student_data_app/utils/student_modal.dart';

Expanded buildListView({required void Function(void Function()) setState}) {
  return Expanded(
    child: ListView.separated(
      itemCount: studentObj.length,
      itemBuilder: (context, index) {
        StudentData student = studentObj[index];
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.navigateTo.showDetailsScreen,
              arguments: student,
            );
          },
          child: Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.blueGrey.shade100.withOpacity(0.4),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundImage: FileImage(
                    File(student.image!.path),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text.rich(
                  TextSpan(
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    children: [
                      TextSpan(
                        text: student.name,
                      ),
                      TextSpan(
                        text: '\nStandard: ${student.standard}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    setState(() {
                      studentObj.removeAt(index);
                      log('${studentObj.isEmpty}');
                    });
                  },
                  icon: const Icon(Icons.delete_outline_outlined),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 8),
    ),
  );
}
