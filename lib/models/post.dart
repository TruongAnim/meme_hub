import 'dart:convert';

import 'package:meme_hub/models/user.dart';

class Post {
  String id;
  dynamic userId;
  List<String> comments;
  List<String> upVotes;
  List<String> downVotes;
  List<String> tags;
  String title;
  String mediaLink;
  DateTime createdAt;

  Post({
    required this.id,
    required this.userId,
    required this.comments,
    required this.upVotes,
    required this.downVotes,
    required this.tags,
    required this.title,
    required this.mediaLink,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'userId': userId,
      'comments': comments,
      'upVotes': upVotes,
      'downVotes': downVotes,
      'tags': tags,
      'title': title,
      'mediaLink': mediaLink,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    dynamic user = map['userId'];
    if (map['userId'] is Map) {
      user = User.fromMap(map['userId']);
    }
    return Post(
      id: map['_id'] as String,
      userId: user,
      comments:
          (map['comments'] as List<dynamic>).map((e) => e.toString()).toList(),
      upVotes:
          (map['upVotes'] as List<dynamic>).map((e) => e.toString()).toList(),
      downVotes:
          (map['downVotes'] as List<dynamic>).map((e) => e.toString()).toList(),
      tags: (map['tags'] as List<dynamic>).map((e) => e.toString()).toList(),
      title: map['title'] as String,
      mediaLink: map['mediaLink'] as String,
      createdAt: DateTime.parse(map['createdAt']).toLocal(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) =>
      Post.fromMap(json.decode(source) as Map<String, dynamic>);
}
