import 'dart:convert';

/// token : "1|Co8tC7VVfLmAoPKgeiUTpweDtXTBdnA6RYaYNzwT276044c5"
/// user : {"id":2,"name":"Mikiyas Teshome","email":"ewenetmikiyas@gmail.com","subscription":null}

LocalLoginAuthModel localLoginAuthModelFromJson(String str) =>
    LocalLoginAuthModel.fromJson(json.decode(str));
String localLoginAuthModelToJson(LocalLoginAuthModel data) =>
    json.encode(data.toJson());

class LocalLoginAuthModel {
  LocalLoginAuthModel({
    String? token,
    User? user,
  }) {
    _token = token;
    _user = user;
  }

  LocalLoginAuthModel.fromJson(dynamic json) {
    _token = json['token'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  String? _token;
  User? _user;
  LocalLoginAuthModel copyWith({
    String? token,
    User? user,
  }) =>
      LocalLoginAuthModel(
        token: token ?? _token,
        user: user ?? _user,
      );
  String? get token => _token;
  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = _token;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }
}

/// id : 2
/// name : "Mikiyas Teshome"
/// email : "ewenetmikiyas@gmail.com"
/// subscription : null

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    num? id,
    String? name,
    String? email,
    dynamic subscription,
  }) {
    _id = id;
    _name = name;
    _email = email;
    _subscription = subscription;
  }

  User.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
    _subscription = json['subscription'];
  }
  num? _id;
  String? _name;
  String? _email;
  dynamic _subscription;
  User copyWith({
    num? id,
    String? name,
    String? email,
    dynamic subscription,
  }) =>
      User(
        id: id ?? _id,
        name: name ?? _name,
        email: email ?? _email,
        subscription: subscription ?? _subscription,
      );
  num? get id => _id;
  String? get name => _name;
  String? get email => _email;
  dynamic get subscription => _subscription;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['email'] = _email;
    map['subscription'] = _subscription;
    return map;
  }
}
