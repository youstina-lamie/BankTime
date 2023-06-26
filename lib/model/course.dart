class Course {
  int? id;
  String? title;
  String? shortDescription;
  int? diffeculty;
  Status? status;
  List<String>? tips;
  List<Steps>? steps;
  int? mainFileType;
  String? thumbanilFullPath;
  String? mainFile;
  int? categoryId;
  int? freePremium;

  Course({
    this.id,
    this.title,
    this.shortDescription,
    this.diffeculty,
    this.status,
    this.tips,
    this.steps,
    this.thumbanilFullPath,
    this.mainFileType,
    this.mainFile,
    this.categoryId,
    this.freePremium
  });

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    shortDescription = json['short_description'];
    diffeculty = json['diffeculty'];
    freePremium = json['free_premium'];

    if (json['status'] != null) status = Status.fromJson(json['status']);

    tips = json['tips'] == null ? [] : (json['tips'] as List).cast<String>();

    if (json['steps'] != null) {
      steps = <Steps>[];
      json['steps'].forEach((v) {
        steps!.add(Steps.fromJson(v));
      });
    }
    thumbanilFullPath = json['thumbanil_full_path'];
    mainFile = json['main_file'];
    mainFileType = json['main_file_type'];
    categoryId = json['category_id'];
  }

  Map toJson() => {
        'id': id,
        'title': title,
        'short_description': shortDescription,
        'diffeculty': diffeculty,
        'status': status,
        'tips': tips,
        'steps': steps,
        'free_premium':freePremium ,
        'thumbanil_full_path': thumbanilFullPath,
        'main_file_type': mainFileType,
        'category_id': categoryId,
        'main_file': mainFile
      };
}

class Steps {
  String title;
  int? fileType;
  String? file;

  Steps({required this.title, this.fileType, this.file});

  factory Steps.fromJson(Map<String, dynamic> json) => Steps(
        title: json['title'],
        fileType: json['file_type'],
        file: json['file'],
      );

  Map toJson() => {
        'title': title,
        'file_type': fileType,
        'file': file,
      };
}

class Status {
  int id;
  String name;

  Status({required this.name, required this.id});

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        id: json['id'],
        name: json['name'],
      );

  Map toJson() => {
        'id': id,
        'name': name,
      };

  @override
  bool operator ==(o) => o is Status && name == o.name && id == o.id;

  @override
  int get hashCode => super.hashCode;
}
