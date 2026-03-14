class MahasiswaModel {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  MahasiswaModel({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  factory MahasiswaModel.fromJson(Map<String, dynamic> json) {
    return MahasiswaModel(
      postId: json['postId'] is int
          ? json['postId'] as int
          : int.tryParse('${json['postId']}') ?? 0,
      id: json['id'] is int ? json['id'] as int : int.tryParse('${json['id']}') ?? 0,
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      body: json['body']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'id': id,
      'name': name,
      'email': email,
      'body': body,
    };
  }
}