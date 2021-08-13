class AppUser {
  static const String keyTableName = "Users";
  static const String keyName = "Name";
  static const String keyImageUrl = "ImageUrl";
  static const String keyEmail = "Email";
  String? name;
  String? imageUrl;
  String? uId;
  String? email;
  AppUser(this.name, this.imageUrl, this.email);
  Map<String, dynamic> toMap() {
    return {keyName: name, keyImageUrl: imageUrl, keyEmail: email};
  }

  AppUser.fromJson(json, String id) {
    name = json[keyName];
    uId = id;
    imageUrl = json[keyImageUrl];
    email = json[keyEmail];
  }
}
