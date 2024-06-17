import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_data_app/utils/global_data.dart';
import 'package:student_data_app/utils/routes.dart';
import 'package:student_data_app/utils/student_modal.dart';

Widget showActionChip() {
  return DropdownButton(
    items: List.generate(
        2,
        (index) => DropdownMenuItem(
              child: Text(
                'Gallery',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )),
    onChanged: (value) {},
  );
}

Expanded buildGridView({required void Function(void Function()) setState}) {
  return Expanded(
    child: GridView.builder(
      itemCount: studentObj.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 10,
      ),
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
            margin: index % 2 != 0
                ? const EdgeInsets.only(right: 16)
                : const EdgeInsets.only(left: 16),
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade100.withOpacity(0.4),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 44,
                      backgroundImage: FileImage(
                        File(student.image!.path),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      student.name,
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      'Standard: ${student.standard}',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: PopupMenuButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    color: primaryColor.withOpacity(0.8),
                    shadowColor: Colors.blueGrey.shade100,
                    position: PopupMenuPosition.under,
                    onSelected: (value) {
                      if (value == 'pdf_preview') {
                        Navigator.pushNamed(
                            context, Routes.navigateTo.pdfPreview);
                      } else {
                        setState(() {
                          studentObj.removeAt(index);
                          log('removed ------------- ${studentObj.isEmpty}');
                        });
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        value: 'pdf_preview',
                        child: Row(
                          children: [
                            const Icon(
                              Icons.picture_as_pdf_rounded,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              'View PDF',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  fontSize: 14,
                                  height: 0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 2),
                        value: 'delete',
                        child: Row(
                          children: [
                            const Icon(
                              Icons.delete_rounded,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Delete',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    icon: Icon(
                      Icons.more_vert,
                      color: Colors.blueGrey.shade400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}
