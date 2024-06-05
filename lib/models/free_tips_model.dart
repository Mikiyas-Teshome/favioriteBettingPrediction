import 'dart:convert';

class FreeTipsModel {
  int page;
  List<Datum> data;
  int resultCount;
  int pageCount;

  FreeTipsModel({
    required this.page,
    required this.data,
    required this.resultCount,
    required this.pageCount,
  });

  factory FreeTipsModel.fromJson(Map<String, dynamic> json) => FreeTipsModel(
        page: json["page"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
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

class Datum {
  String? type;
  String? title;
  String? date;
  int? index;
  String? time;
  League? league;
  Team? teamHome;
  Team? teamAway;
  String? forecast;
  String? odds;
  String? status;
  String? homeScore;
  String? awayScore;
  String? id;
  Coupon? coupon;

  Datum({
    this.type,
    this.title,
    this.date,
    this.index,
    this.time,
    this.league,
    this.teamHome,
    this.teamAway,
    this.forecast,
    this.odds,
    this.status,
    this.homeScore,
    this.awayScore,
    this.id,
    this.coupon,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        type: json["type"],
        title: json["title"],
        date: json["date"],
        index: json["index"],
        time: json["time"],
        league: json["league"] == null ? null : League.fromJson(json["league"]),
        teamHome:
            json["teamHome"] == null ? null : Team.fromJson(json["teamHome"]),
        teamAway:
            json["teamAway"] == null ? null : Team.fromJson(json["teamAway"]),
        forecast: json["forecast"],
        odds: json["odds"],
        status: json["status"],
        homeScore: json["homeScore"],
        awayScore: json["awayScore"],
        id: json["_id"],
        coupon: json["coupon"] == null ? null : Coupon.fromJson(json["coupon"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "title": title,
        "date": date,
        "index": index,
        "time": time,
        "league": league?.toJson(),
        "teamHome": teamHome?.toJson(),
        "teamAway": teamAway?.toJson(),
        "forecast": forecast,
        "odds": odds,
        "status": status,
        "homeScore": homeScore,
        "awayScore": awayScore,
        "_id": id,
        "coupon": coupon?.toJson(),
      };
}

class League {
  String id;
  String name;
  int v;
  String? countryCode;
  String? image;
  String? icon;

  League({
    required this.id,
    required this.name,
    required this.v,
    this.countryCode,
    this.image,
    this.icon,
  });

  factory League.fromJson(Map<String, dynamic> json) => League(
        id: json["_id"],
        name: json["name"],
        v: json["__v"],
        countryCode: json["countryCode"],
        image: json["image"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "__v": v,
        "countryCode": countryCode,
        "image": image,
        "icon": icon,
      };
}

class Team {
  String id;
  String name;
  int v;
  String? image;
  String? icon;

  Team({
    required this.id,
    required this.name,
    required this.v,
    this.image,
    this.icon,
  });

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        id: json["_id"],
        name: json["name"],
        v: json["__v"],
        image: json["image"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "__v": v,
        "image": image,
        "icon": icon,
      };
}

class Coupon {
  String type;
  String title;
  String date;

  Coupon({
    required this.type,
    required this.title,
    required this.date,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
        type: json["type"],
        title: json["title"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "title": title,
        "date": date,
      };
}
