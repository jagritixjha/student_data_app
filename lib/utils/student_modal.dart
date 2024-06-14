import 'dart:io';

class StudentData {
  String name = '';
  String grid = '';
  String standard = '';
  File? image;
  double? englishMarks = 0,
      scienceMarks = 0,
      mathsMarks = 0,
      socialStudiesMarks = 0,
      computerMarks = 0;

  StudentData({
    required this.name,
    required this.grid,
    required this.standard,
    required this.image,
    this.englishMarks = 0,
    this.computerMarks = 0,
    this.mathsMarks = 0,
    this.scienceMarks = 0,
    this.socialStudiesMarks = 0,
  });

  // factory StudentData.fromMap(Map<String, dynamic> key) {
  //   return StudentData(
  //     name: key['name'],
  //     grid: key['grid'],
  //     standard: key['standard'],
  //     image: key['image'],
  //   );
  // }
  //
  // Map<String, dynamic> get toMap => {
  //       'name': name,
  //       'grid': grid,
  //       'standard': standard,
  //       'image': image,
  //     };
}
