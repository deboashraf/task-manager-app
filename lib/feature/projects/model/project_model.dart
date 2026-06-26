class ProjectModel {
  final int id;
  final String title;
  final String disc;
  final int stock;

  ProjectModel({
    required this.id,
    required this.title,
    required this.disc,
    required this.stock,
  });
  factory ProjectModel.fromjson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id']??0,
      title: json['title']??'',
      disc: json['description']??'',
      stock: json['stock']??0,
    );
  }
}
