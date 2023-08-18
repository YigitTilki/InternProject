class UserModelS {
  final String? id;
  final String fullName;
  final String sicil;

  UserModelS({this.id, required this.fullName, required this.sicil});

  toJson() {
    return {"FullName": fullName, "Sicil": sicil};
  }
}
