import 'package:whiskers/model/course.dart';

class CoursesCategory {
  int id;
  String name;
  String description;
  String imageFullPath;
  List<Course>? courses;
  int? newCategory;

  CoursesCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.imageFullPath,
    this.courses,
    this.newCategory
  });

  factory CoursesCategory.fromJson(Map<String, dynamic> json) =>
      CoursesCategory(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        imageFullPath: json['image_full_path'],
        newCategory: json['new'],

        courses: json['courses']==null ? [] : (json['courses'] as List).map((course) => Course.fromJson(course)).toList(),
      );

  Map toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'image_full_path': imageFullPath,
        'new': newCategory,
        'courses' : courses!.map((e) => e.toJson()).toList()
      };
}
