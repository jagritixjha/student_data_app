import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_data_app/utils/global_data.dart';
import 'package:student_data_app/views/home_screen/widgets/add_student_button.dart';
import 'package:student_data_app/views/home_screen/widgets/build_gridview.dart';
import 'package:student_data_app/views/home_screen/widgets/build_listview.dart';

import 'widgets/build_empty_screen.dart';

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
            ? buildEmptyScreen(context)
            : Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  children: [
                    isList
                        ? buildListView(setState: (fn) => setState(fn))
                        : buildGridView(setState: (fn) => setState(fn)),
                    buildAddStudentButton(context),
                  ],
                ),
              ),
      ),
    );
  }
}
