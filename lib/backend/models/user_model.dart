class UserModel {
  final String name;
  final String email;
  final String status;

  UserModel(
    this.name,
    this.email,
    this.status,
  );

  Map<String, dynamic> get() {
    return {
      "name" : name,
      "email" : email,
      "status" : status,
    };
  }
}