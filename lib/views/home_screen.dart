import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_data_app/utils/global_data.dart';
import 'package:student_data_app/utils/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.white,
        elevation: 2,
        title: Text(
          'Student Portal',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: studentObj.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 200,
                    child: Image.asset('assets/emptyScreen.png'),
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
                      backgroundColor: Colors.indigo.shade100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: const Size(100, 44),
                    ),
                    icon: Icon(
                      Icons.add,
                      size: 20,
                      color: Colors.indigo.shade900,
                    ),
                    label: Text(
                      'Add Student',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.indigo.shade900,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        minVerticalPadding: 12,
                        horizontalTitleGap: -4,
                        splashColor: Colors.indigo.shade50,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        isThreeLine: true,
                        visualDensity: VisualDensity.compact,
                        leading: CircleAvatar(
                          radius: 44,
                          backgroundImage:
                              AssetImage(studentObj[index].image!.path),
                        ),
                        title: Text(
                          studentObj[index].name,
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        subtitle: Text(
                          'Standard: ${studentObj[index].standard}',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        trailing: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.navigateTo.showDetailsScreen,
                                  arguments: studentObj[index],
                                );
                              },
                              icon: const Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () {
                                studentObj.removeAt(index);
                                log('${studentObj.isEmpty}');
                                setState(() {});
                              },
                              icon: const Icon(Icons.delete_outline_outlined),
                            ),
                          ],
                        ),
                        onTap: () {},
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 6),
                    itemCount: studentObj.length,
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
                      backgroundColor: Colors.indigo.shade100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: const Size(100, 44),
                    ),
                    icon: Icon(
                      Icons.add,
                      size: 20,
                      color: Colors.indigo.shade900,
                    ),
                    label: Text(
                      'Add Student',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.indigo.shade900,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
