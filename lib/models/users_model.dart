class UsersModel {
  static const String collectionName = 'users';
  String id;
  String name;
  String email;

  UsersModel({required this.id, required this.name, required this.email});

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }

  UsersModel.fromFireStore(Map<String, dynamic>? data)
      : this(
            id: data!['id'] as String,
            name: data['name'] as String,
            email: data['email'] as String);
}
