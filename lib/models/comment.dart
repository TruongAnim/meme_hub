import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Comment {
  String id;
  String userId;
  List<String> upVotes;
  List<String> downVotes;
  String content;
  String mediaLink;
  DateTime createdAt;
  Comment({
    required this.id,
    required this.userId,
    required this.upVotes,
    required this.downVotes,
    required this.content,
    required this.mediaLink,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'upVotes': upVotes,
      'downVotes': downVotes,
      'content': content,
      'mediaLink': mediaLink,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['id'] as String,
      userId: map['userId'] as String,
      upVotes: List<String>.from(map['upVotes'] as List<String>),
      downVotes: List<String>.from(map['downVotes'] as List<String>),
      content: map['content'] as String,
      mediaLink: map['mediaLink'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Comment.fromJson(String source) =>
      Comment.fromMap(json.decode(source) as Map<String, dynamic>);
}
