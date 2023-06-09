import 'dart:convert';

class Tag {
  String id;
  String name;
  String icon;
  List<String> posts;
  Tag({
    required this.id,
    required this.name,
    required this.icon,
    required this.posts,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'name': name,
      'icon': icon,
      'posts': posts,
    };
  }

  factory Tag.fromMap(Map<String, dynamic> map) {
    return Tag(
      id: map['_id'] as String,
      name: map['name'] as String,
      icon: map['icon'] as String,
      posts: (map['posts'] as List<dynamic>).map((e) => e.toString()).toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Tag.fromJson(String source) =>
      Tag.fromMap(json.decode(source) as Map<String, dynamic>);
}
