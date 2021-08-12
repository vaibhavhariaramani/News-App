class RegisterResponseModel {
  final String token;
  final String error;

  RegisterResponseModel({required this.token, required this.error});

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
        token: json["token"] != null ? json["token"] : "",
        error: json["error"] != null ? json["error"] : "");
  }
}

class RegisterRequestModel {
  String email;
  String username;
  String password;
  String passwordConf;

  RegisterRequestModel({
    required this.email,
    required this.username,
    required this.password,
    required this.passwordConf,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email': email.trim(),
      'username': username.trim(),
      'password': password.trim(),
      'passwordConf': passwordConf.trim(),
    };

    return map;
  }
}
