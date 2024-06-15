import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:student_data_app/utils/global_data.dart';
import 'package:student_data_app/utils/routes.dart';
import 'package:student_data_app/utils/student_modal.dart';
import 'package:student_data_app/views/show_details_screen/widgets/build_form.dart';
import 'package:student_data_app/views/show_details_screen/widgets/generate_pdf.dart';

class ShowDetailsScreen extends StatefulWidget {
  const ShowDetailsScreen({super.key});

  @override
  State<ShowDetailsScreen> createState() => _ShowDetailsScreenState();
}

class _ShowDetailsScreenState extends State<ShowDetailsScreen> {
  File? imagee;

  Future<void> _pickImage(StudentData sd) async {
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
          sd.image = imagee!;
          setState(() {});
        }
      }
    }
  }

  void handleSubmit(
      {required StudentData sd,
      String snackBarText = "",
      bool canPop = false}) {
    bool validation = formKey.currentState!.validate();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          validation
              ? snackBarText
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

    if (validation) {
      formKey.currentState!.save();
      formKey.currentState!.reset();
      setState(() {});
      if (canPop) {
        Navigator.pushNamed(context, Routes.navigateTo.homeScreen);
      }
    }
  }

  Future<void> downloadPdf(StudentData sd) async {
    handleSubmit(sd: sd, snackBarText: 'Pdf Downloaded');
    final pdfData = await generatePdf(sd);

    final directory = await getExternalStorageDirectory();
    if (directory != null) {
      final file = File('${directory.path}/student_marksheet.pdf');
      await file.writeAsBytes(pdfData);
      log('File saved at ${file.path}');
    } else {
      log('Storage permission denied');
    }
  }

  Future<void> sharePdf(StudentData sd) async {
    handleSubmit(sd: sd);
    final pdfData = await generatePdf(sd);
    await Printing.sharePdf(bytes: pdfData, filename: 'student_marksheet.pdf');
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
              BuildMarksheetForm.marksheetForm(
                sd: sd,
                context: context,
                onPressed: () {
                  _pickImage(sd);
                  setState(() {});
                },
              ),
              buildElevatedButton(
                sd: sd,
                context: context,
                text: 'Submit',
                bg: primaryColor,
                onPressed: () => handleSubmit(
                  sd: sd,
                  snackBarText: 'Form saved',
                  canPop: true,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildElevatedButton(
                    size: MediaQuery.of(context).size.width / 2.2,
                    sd: sd,
                    context: context,
                    text: 'Download PDF',
                    bg: primaryColor,
                    onPressed: () => downloadPdf(sd),
                  ),
                  buildElevatedButton(
                    size: MediaQuery.of(context).size.width / 2.2,
                    sd: sd,
                    context: context,
                    text: 'Share',
                    bg: primaryColor,
                    onPressed: () => sharePdf(sd),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

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
}
