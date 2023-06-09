import 'dart:convert';
import 'dart:ffi';

import 'package:meme_hub/models/user.dart';

class Post {
  String id;
  dynamic userId;
  List<String> comments;
  List<String> upVotes;
  List<String> favourites;
  List<String> tags;
  String title;
  String type;
  String mediaLink;
  DateTime createdAt;
  double mediaAspectRatio;

  Post({
    required this.id,
    required this.userId,
    required this.comments,
    required this.upVotes,
    required this.favourites,
    required this.tags,
    required this.title,
    required this.type,
    required this.mediaLink,
    required this.createdAt,
    required this.mediaAspectRatio,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'userId': userId,
      'comments': comments,
      'upVotes': upVotes,
      'favourites': favourites,
      'tags': tags,
      'title': title,
      'type': type,
      'mediaLink': mediaLink,
      'mediaAspectRatio': mediaAspectRatio,
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
      favourites: (map['favourites'] as List<dynamic>)
          .map((e) => e.toString())
          .toList(),
      tags: (map['tags'] as List<dynamic>).map((e) => e.toString()).toList(),
      title: map['title'] as String,
      type: map['type'] as String,
      mediaLink: map['mediaLink'] as String,
      mediaAspectRatio: map['mediaAspectRatio'] * 1.0,
      createdAt: DateTime.parse(map['createdAt']).toLocal(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) =>
      Post.fromMap(json.decode(source) as Map<String, dynamic>);
}
