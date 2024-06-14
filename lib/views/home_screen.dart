import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_data_app/utils/global_data.dart';
import 'package:student_data_app/utils/routes.dart';
import 'package:student_data_app/utils/student_modal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isList = false;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        SystemNavigator.pop();
        return;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          shadowColor: Colors.white,
          elevation: 2,
          title: Text(
            'Student Portal',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: primaryTextColor,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                isList = !isList;
                log(isList.toString());
                setState(() {});
              },
              icon: isList
                  ? const Icon(Icons.menu)
                  : const Icon(Icons.grid_view_outlined),
            ),
          ],
        ),
        body: studentObj.isEmpty
            ? Center(
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
                    TextButton.icon(
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
                    ),
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  children: [
                    isList
                        ? Expanded(
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 6),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.blueGrey.shade100
                                          .withOpacity(0.4),
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
                                                text:
                                                    '\nStandard: ${student.standard}',
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
                                            studentObj.removeAt(index);
                                            log('${studentObj.isEmpty}');
                                            setState(() {});
                                          },
                                          icon: const Icon(
                                              Icons.delete_outline_outlined),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 8),
                            ),
                          )
                        : Expanded(
                            child: GridView.builder(
                              itemCount: studentObj.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
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
                                      color: Colors.blueGrey.shade100
                                          .withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                          child: IconButton(
                                            onPressed: () {
                                              studentObj.removeAt(index);
                                              log('${studentObj.isEmpty}');
                                              setState(() {});
                                            },
                                            icon: const Icon(
                                                Icons.delete_outline_outlined),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: TextButton.icon(
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
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
