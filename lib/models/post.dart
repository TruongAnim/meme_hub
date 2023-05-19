import 'dart:convert';

class Post {
  String id;
  String userId;
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
      'id': id,
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
    return Post(
      id: map['id'] as String,
      userId: map['userId'] as String,
      comments: map['comments'] as List<String>,
      upVotes: List<String>.from(map['upVotes'] as List<String>),
      downVotes: List<String>.from(map['downVotes'] as List<String>),
      tags: List<String>.from(map['tags'] as List<String>),
      title: map['title'] as String,
      mediaLink: map['mediaLink'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) =>
      Post.fromMap(json.decode(source) as Map<String, dynamic>);
}
