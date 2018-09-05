class UserModel {
  final String id;
  final String username;
  final String email;
  final String imageUrl;

  UserModel({
    this.id,
    this.username,
    this.email,
    this.imageUrl,
  });

  UserModel.fromMap(Map map)
      : id = map['id'],
        username = map['username'],
        email = map['email'],
        imageUrl = map['imageUrl'];

  Map toJson() => {
        'id': id,
        'username': username,
        'email': email,
        'imageUrl': imageUrl,
      };
}
