import 'package:banktime/model/breed.dart';
import 'package:banktime/model/gender.dart';

class Dog {
  int? id;
  String name;
  String birthDate;
  int? userId;
  Gender? gender;
  Breed? breed;
  ImageDog? image;

  Dog(
      {this.id,
      required this.name,
      required this.birthDate,
      this.userId,
      required this.breed,
      required this.gender,
      this.image});

  factory Dog.fromJson(Map<String, dynamic> json) => Dog(
      id: json['id'],
      name: json['name'],
      birthDate: json['date_of_birth'],
      userId: json['user_id'],
      breed: json['breed'] == null ? null : Breed.fromJson(json['breed']),
      gender: json['gender'] == null ? null : Gender.fromJson(json['gender']),
      image: json["image"] != null ? ImageDog.fromJson(json["image"]) : null);

  Map toJson() => {
        'id': id,
        'name': name,
        'date_of_birth': birthDate,
        'user_id': userId,
        'gender': gender!.toJson(),
        'breed': breed!.toJson(),
        "image": image?.toJson(),
      };

  @override
  bool operator ==(o) => o is Dog && id == o.id;

  @override
  int get hashCode => super.hashCode;

  @override
  String toString() => "name: $name -- id: $id";
}

class ImageDog {
  String originalUrl;

  ImageDog({
    required this.originalUrl,
  });

  factory ImageDog.fromJson(Map<String, dynamic> json) => ImageDog(
        originalUrl: json["original_url"],
      );

  Map<String, dynamic> toJson() => {
        "original_url": originalUrl,
      };
}
