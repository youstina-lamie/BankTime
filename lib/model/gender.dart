class Gender {
  int id;
  String gender;
  

  Gender(
    {
      required this.id,
      required this.gender,
     
    }
  );

  factory Gender.fromJson(Map<String, dynamic> json) => Gender(
    id: json['id'],
    gender: json['gender'],
  );

  Map toJson() => {
    'id': id,
    'gender': gender,
       
  };
}
