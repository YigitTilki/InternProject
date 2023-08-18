class UserModelT {
  final String? id;
  final String fullName;
  final String password;
  final String sicil;

  UserModelT(
      {this.id,
      required this.fullName,
      required this.password,
      required this.sicil});

  toJson() {
    return {"FullName": fullName, "Password": password, "Sicil": sicil};
  }
}
