class UserModel {
  final String name;
  final String email;
  final String pending;

  UserModel(
    this.name,
    this.email,
    this.pending,
  );

  Map<String, dynamic> get() {
    return {
      "name" : name,
      "email" : email,
      "pending" : pending,
    };
  }
}