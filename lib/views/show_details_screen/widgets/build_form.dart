import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_data_app/utils/global_data.dart';
import 'package:student_data_app/utils/student_modal.dart';
import 'package:student_data_app/views/common_widgets/text_field_widget.dart';

final formKey = GlobalKey<FormState>();

class BuildMarksheetForm {
  static Widget marksheetForm(
      {required StudentData sd,
      required BuildContext context,
      required void Function()? onPressed}) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.indigo.shade50,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade50,
                  offset: const Offset(0, 0),
                  blurRadius: 20,
                  spreadRadius: 10,
                )
              ],
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 70,
                    foregroundImage: FileImage(
                      File(sd.image!.path),
                    ),
                    child: Text(
                      'Update',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 16,
                          color: primaryTextColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: CircleAvatar(
                      backgroundColor: Colors.indigo.shade200.withOpacity(0.8),
                      child: IconButton(
                          icon: Icon(
                            Icons.edit_outlined,
                            color: primaryTextColor,
                          ),
                          onPressed: onPressed),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFieldWidget(
            hint: 'Jagriti Jha',
            labelText: 'Name',
            validatorVariable: sd.name,
            validatorFunc: (value) {
              return value!.isEmpty ? 'enter student name' : null;
            },
            saveData: (value) => sd.name = value!,
          ),
          TextFieldWidget(
            labelText: 'GRID',
            hint: '6844',
            validatorVariable: sd.grid,
            validatorFunc: (value) {
              return value!.isEmpty ? 'enter GRID' : null;
            },
            saveData: (value) => sd.grid = value!,
          ),
          TextFieldWidget(
            hint: '12',
            labelText: 'Standard',
            validatorVariable: sd.standard,
            validatorFunc: (value) {
              return value!.isEmpty ? 'enter Standard' : null;
            },
            saveData: (value) => sd.standard = value!,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width / 5,
                color: Colors.blueGrey.shade100,
              ),
              Text(
                'Enter Marks Obtained',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.indigo.shade400,
                  ),
                ),
              ),
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width / 5,
                color: Colors.blueGrey.shade100,
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          TextFieldWidget(
              hint: 'Out Of 100',
              labelText: 'English',
              validatorVariable: sd.englishMarks.toString(),
              validatorFunc: (value) {
                return value!.isEmpty ? 'enter Standard' : null;
              },
              saveData: (value) {
                sd.englishMarks = double.parse(value!);
              }),
          TextFieldWidget(
            hint: 'Out Of 100',
            labelText: 'Science',
            validatorVariable: sd.scienceMarks.toString(),
            validatorFunc: (value) {
              return value!.isEmpty ? 'enter Standard' : null;
            },
            saveData: (value) => sd.scienceMarks = double.parse(value!),
          ),
          TextFieldWidget(
            hint: 'Out Of 100',
            labelText: 'Maths',
            validatorVariable: sd.mathsMarks.toString(),
            validatorFunc: (value) {
              return value!.isEmpty ? 'enter Standard' : null;
            },
            saveData: (value) => sd.mathsMarks = double.parse(value!),
          ),
          TextFieldWidget(
            hint: 'Out Of 100',
            labelText: 'Social Studies',
            validatorVariable: sd.socialStudiesMarks.toString(),
            validatorFunc: (value) {
              return value!.isEmpty ? 'enter Standard' : null;
            },
            saveData: (value) => sd.socialStudiesMarks = double.parse(value!),
          ),
          TextFieldWidget(
            hint: 'Out Of 100',
            labelText: 'Computer',
            validatorVariable: sd.computerMarks.toString(),
            validatorFunc: (value) {
              return value!.isEmpty ? 'enter Standard' : null;
            },
            saveData: (value) => sd.computerMarks = double.parse(value!),
          ),
        ],
      ),
    );
  }
}
