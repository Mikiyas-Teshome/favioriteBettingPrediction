import 'dart:convert';

VipTipsCategoryModel vipTipsCategoryModelFromJson(String str) =>
    VipTipsCategoryModel.fromJson(json.decode(str));

String vipTipsCategoryModelToJson(VipTipsCategoryModel data) =>
    json.encode(data.toJson());

class VipTipsCategoryModel {
  int page;
  List<Data> data;
  int resultCount;
  int pageCount;

  VipTipsCategoryModel({
    required this.page,
    required this.data,
    required this.resultCount,
    required this.pageCount,
  });

  factory VipTipsCategoryModel.fromJson(Map<String, dynamic> json) =>
      VipTipsCategoryModel(
        page: json["page"],
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
        resultCount: json["resultCount"],
        pageCount: json["pageCount"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "resultCount": resultCount,
        "pageCount": pageCount,
      };
}

class Data {
  String id;
  int v;
  String application;
  String name;
  List<Subscription> subscriptions;
  String announcement;
  String image;

  Data({
    required this.id,
    required this.v,
    required this.application,
    required this.name,
    required this.subscriptions,
    required this.announcement,
    required this.image,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        v: json["__v"],
        application: json["application"],
        name: json["name"],
        subscriptions: List<Subscription>.from(
            json["subscriptions"].map((x) => Subscription.fromJson(x))),
        announcement: json["announcement"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "__v": v,
        "application": application,
        "name": name,
        "subscriptions":
            List<dynamic>.from(subscriptions.map((x) => x.toJson())),
        "announcement": announcement,
        "image": image,
      };
}

class Subscription {
  String id;
  int v;
  String application;
  bool bonus;
  String code;
  String description;
  String name;
  String? image;
  String ios;

  Subscription({
    required this.id,
    required this.v,
    required this.application,
    required this.bonus,
    required this.code,
    required this.description,
    required this.name,
    this.image,
    required this.ios,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        id: json["_id"],
        v: json["__v"],
        application: json["application"],
        bonus: json["bonus"] == "true",
        code: json["code"],
        description: json["description"],
        name: json["name"],
        image: json["image"],
        ios: json["ios"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "__v": v,
        "application": application,
        "bonus": bonus.toString(),
        "code": code,
        "description": description,
        "name": name,
        "image": image,
        "ios": ios,
      };
}
