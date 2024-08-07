
class UserData {
  String? name;
  String? username;
  String? email;
  var userType;
  var isAdmin;
  var approved;
  DateTime? updatedAt;
  DateTime? createdAt;
  var id;
  String? token;

  UserData({
    this.name,
    this.username,
    this.email,
    this.userType,
    this.isAdmin,
    this.approved,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.token,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    name: json["name"],
    username: json["username"],
    email: json["email"],
    userType: json["user_type"],
    isAdmin: json["is_admin"],
    approved: json["approved"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "username": username,
    "email": email,
    "user_type": userType,
    "is_admin": isAdmin,
    "approved": approved,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
    "token": token,
  };
}
