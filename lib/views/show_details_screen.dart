import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_data_app/utils/global_data.dart';
import 'package:student_data_app/utils/routes.dart';
import 'package:student_data_app/utils/student_modal.dart';
import 'package:student_data_app/views/common_widgets/text_field_widget.dart';

class ShowDetailsScreen extends StatefulWidget {
  const ShowDetailsScreen({super.key});

  @override
  State<ShowDetailsScreen> createState() => _ShowDetailsScreenState();
}

class _ShowDetailsScreenState extends State<ShowDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  File? imagee;

  void Function()? onPressedd(File pfp) {
    _pickImage(pfp);
  }

  Future<void> _pickImage(File pfp) async {
    {
      final ImageSource? source = await showModalBottomSheet<ImageSource>(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.only(top: 16, left: 16),
                  leading: const Icon(Icons.photo_library_outlined),
                  title: Text(
                    'Gallery',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  onTap: () => Navigator.of(context).pop(ImageSource.gallery),
                ),
                ListTile(
                  leading: const Icon(Icons.camera_outlined),
                  title: Text(
                    'Camera',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  onTap: () => Navigator.of(context).pop(ImageSource.camera),
                )
              ],
            ),
          );
        },
      );

      if (source != null) {
        ImagePicker? image = ImagePicker();
        XFile? file = await image.pickImage(source: source);
        if (file != null) {
          imagee = File(file.path);
          pfp = imagee!;
          setState(() {});
        }
      }
    }
  }

  void handleSubmit() {
    bool validation = _formKey.currentState!.validate();
    bool imageValidation = imagee != null;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          validation && imageValidation
              ? 'Form saved'
              : 'Please complete the form and upload a profile pic',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );

    if (validation && imageValidation) {
      _formKey.currentState!.save();
      _formKey.currentState!.reset();
      setState(() {});
      Navigator.pushNamed(context, Routes.navigateTo.homeScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    StudentData sd = ModalRoute.of(context)!.settings.arguments as StudentData;
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.white,
        elevation: 2,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: primaryTextColor,
          ),
        ),
        leadingWidth: 28,
        title: Text(
          'Student Details',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: primaryTextColor,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      height: 250,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Center(
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 70,
                              // backgroundColor:
                              //     Colors.indigo.shade800.withOpacity(0.2),
                              foregroundImage: AssetImage(
                                sd.image!.path,
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
                                backgroundColor: Colors.indigo.shade200,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.edit_outlined,
                                    color: primaryTextColor,
                                  ),
                                  onPressed: () {
                                    onPressedd(sd.image!);
                                    setState(() {});
                                  },
                                ),
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
                    ElevatedButton(
                      onPressed: handleSubmit,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: primaryColor,
                        fixedSize: Size(MediaQuery.of(context).size.width, 48),
                        shadowColor: Colors.blue.shade50,
                        elevation: 6,
                      ),
                      child: Text(
                        'Submit',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 18,
                            color: primaryTextColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
