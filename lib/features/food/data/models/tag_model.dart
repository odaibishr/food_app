import 'package:carea_app/features/food/domain/entities/tag.dart';

class TagModel extends Tag {
  TagModel({
    required super.id,
    required super.name,
  });

  factory TagModel.fromJson(Map<String, dynamic> json) => TagModel(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };

  TagModel copyWith({
    int? id,
    String? name,
  }) => TagModel(
    id: id ?? this.id,
    name: name ?? this.name,
  );
}