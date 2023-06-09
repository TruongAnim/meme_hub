import 'dart:convert';

import 'package:meme_hub/models/user.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Comment {
  String id;
  dynamic userId;
  List<String> upVotes;
  List<String> favourites;
  List<String> comments;
  String content;
  String mediaLink;
  double mediaAspectRatio;
  String type;
  DateTime createdAt;
  Comment({
    required this.id,
    required this.userId,
    required this.upVotes,
    required this.favourites,
    required this.comments,
    required this.content,
    required this.mediaLink,
    required this.type,
    required this.mediaAspectRatio,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'userId': userId,
      'upVotes': upVotes,
      'favourites': favourites,
      'comments': comments,
      'content': content,
      'mediaLink': mediaLink,
      'type': type,
      'mediaAspectRatio': mediaAspectRatio,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    dynamic user = map['userId'];
    if (map['userId'] is Map) {
      user = User.fromMap(map['userId']);
    }
    return Comment(
      id: map['_id'] as String,
      userId: user,
      upVotes:
          (map['upVotes'] as List<dynamic>).map((e) => e.toString()).toList(),
      favourites: (map['favourites'] as List<dynamic>)
          .map((e) => e.toString())
          .toList(),
      comments:
          (map['comments'] as List<dynamic>).map((e) => e.toString()).toList(),
      content: map['content'] as String,
      mediaLink: map['mediaLink'] as String,
      type: map['type'] as String,
      mediaAspectRatio: map['mediaAspectRatio'] * 1.0,
      createdAt: DateTime.parse(map['createdAt']).toLocal(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Comment.fromJson(String source) =>
      Comment.fromMap(json.decode(source) as Map<String, dynamic>);
}
