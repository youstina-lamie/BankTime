class Breed {
  int id;
  String breed;
  

  Breed(
    {
      required this.id,
      required this.breed,
     
    }
  );

  factory Breed.fromJson(Map<String, dynamic> json) => Breed(
    id: json['id'],
    breed: json['breed'],
  );

  Map toJson() => {
    'id': id,
    'breed': breed,
       
  };
}
