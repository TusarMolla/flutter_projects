class UserInfo {
  String name;
  String email;
  String phone;
  var balance;
  String avatar;

  UserInfo({
    required this.name,
    required this.email,
    required this.phone,
    required this.balance,
    required this.avatar,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    balance: json["balance"],
    avatar: json["avatar"],
  );
  factory UserInfo.init() => UserInfo(
    name: '',
    email: '',
    phone: '',
    balance:'',
    avatar: ''
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "phone": phone,
    "balance": balance,
    "avatar": avatar,
  };
}