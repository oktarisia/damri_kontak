class UserModel { 
  String token;

  UserModel({ 
    this.token,
  });

  
  UserModel.fromJson(Map<String, dynamic> json) { 
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    return { 
      'token': token,
    };
  }

}
