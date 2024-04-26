import 'dart:io';

class StudentData {
  final String name;
  final int grid;
  final String standard;
  final File image;

  StudentData({
    required this.name,
    required this.grid,
    required this.standard,
    required this.image,
  });

  factory StudentData.fromMap(Map<String, dynamic> key) {
    return StudentData(
      name: key['name'],
      grid: key['grid'],
      standard: key['standard'],
      image: key['image'],
    );
  }

  Map<String, dynamic> get toMap => {
        'name': name,
        'grid': grid,
        'standard': standard,
        'image': image,
      };
}
