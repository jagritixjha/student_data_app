import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:student_data_app/utils/student_modal.dart';

Future<Uint8List> generatePdf(StudentData studentData) async {
  final pdf = pw.Document();

  final tableHeaders = [
    'No.',
    'Subjects',
    'Marks Obtained',
    'Total Marks',
    'Grade'
  ];

  final subjects = [
    {'name': 'English', 'marks': studentData.englishMarks, 'total': 100},
    {'name': 'Science', 'marks': studentData.scienceMarks, 'total': 100},
    {'name': 'Mathematics', 'marks': studentData.mathsMarks, 'total': 100},
    {
      'name': 'Social Studies',
      'marks': studentData.socialStudiesMarks,
      'total': 100
    },
    {'name': 'Computer', 'marks': studentData.computerMarks, 'total': 100},
  ];

  final grades = subjects.map((subject) {
    final percentage =
        (subject['marks'] as double) / (subject['total'] as int) * 100;
    return percentage >= 90
        ? 'A'
        : percentage >= 80
            ? 'B'
            : percentage >= 70
                ? 'C'
                : 'D';
  }).toList();

  final totalMarksObtained =
      subjects.map((e) => e['marks'] as double).reduce((a, b) => a + b);
  final totalMarksPossible =
      subjects.map((e) => e['total'] as int).reduce((a, b) => a + b);
  final overallPercentage = (totalMarksObtained / totalMarksPossible) * 100;
  final overallGrade = overallPercentage >= 90
      ? 'A'
      : overallPercentage >= 80
          ? 'B'
          : overallPercentage >= 70
              ? 'C'
              : 'D';

  pdf.addPage(
    pw.Page(
      margin: pw.EdgeInsets.zero,
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Container(
              height: 100,
              alignment: pw.Alignment.center,
              width: double.infinity,
              color: PdfColors.indigo200,
              child: pw.Text(
                'Ryan International School',
                style:
                    pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
              ),
            ),
            pw.Padding(
              padding:
                  const pw.EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.SizedBox(height: 10),
                  pw.Text('School Marksheet',
                      style: pw.TextStyle(
                          fontSize: 20, fontWeight: pw.FontWeight.bold)),
                  pw.SizedBox(height: 20),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.RichText(
                        text: pw.TextSpan(
                          style: pw.TextStyle(
                            fontSize: 16,
                            fontWeight: pw.FontWeight.bold,
                          ),
                          children: [
                            const pw.TextSpan(text: 'Student Name:'),
                            pw.TextSpan(
                              text: ' ${studentData.name}',
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      pw.RichText(
                        text: pw.TextSpan(
                          style: pw.TextStyle(
                            fontSize: 16,
                            fontWeight: pw.FontWeight.bold,
                          ),
                          children: [
                            const pw.TextSpan(text: 'Standard:'),
                            pw.TextSpan(
                              text: ' ${studentData.standard}th',
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  pw.RichText(
                    text: pw.TextSpan(
                      style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                      ),
                      children: [
                        const pw.TextSpan(text: 'Dean:'),
                        pw.TextSpan(
                          text: ' Mr. Smith Disoza',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  pw.SizedBox(height: 20),
                  pw.TableHelper.fromTextArray(
                    headers: tableHeaders,
                    data: List<List<dynamic>>.generate(
                      subjects.length,
                      (index) => [
                        index + 1,
                        subjects[index]['name'],
                        subjects[index]['marks'],
                        subjects[index]['total'],
                        grades[index],
                      ],
                    ),
                  ),
                  pw.SizedBox(height: 40),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      children: [
                        pw.RichText(
                          text: pw.TextSpan(
                            style: pw.TextStyle(
                              fontSize: 16,
                              fontWeight: pw.FontWeight.bold,
                            ),
                            children: [
                              const pw.TextSpan(text: 'Percentage: '),
                              pw.TextSpan(
                                text:
                                    ' ${overallPercentage.toStringAsFixed(2)}%',
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        pw.SizedBox(width: 40),
                        pw.RichText(
                          text: pw.TextSpan(
                            style: pw.TextStyle(
                              fontSize: 16,
                              fontWeight: pw.FontWeight.bold,
                            ),
                            children: [
                              const pw.TextSpan(text: 'Grade: '),
                              pw.TextSpan(
                                text: ' $overallGrade',
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ])
                ],
              ),
            )
          ],
        );
      },
    ),
  );

  return pdf.save();
}
