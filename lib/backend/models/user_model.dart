class UserModel {
  final String name;
  final String email;

  UserModel(
    this.name,
    this.email,
  );

  Map<String, String> get() {
    return {
      "name" : name,
      "email" : email,
    };
  }
}