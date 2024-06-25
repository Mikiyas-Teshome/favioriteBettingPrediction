class PreviousTipsModel {
  PreviousTipsModel({
    required this.page,
    required this.data,
    required this.resultCount,
    required this.pageCount,
  });

  final int? page;
  final List<Datum> data;
  final int? resultCount;
  final int? pageCount;

  factory PreviousTipsModel.fromJson(Map<String, dynamic> json) {
    return PreviousTipsModel(
      page: json["page"],
      data: json["data"] == null
          ? []
          : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      resultCount: json["resultCount"],
      pageCount: json["pageCount"],
    );
  }

  Map<String, dynamic> toJson() => {
        "page": page,
        "data": data.map((x) => x?.toJson()).toList(),
        "resultCount": resultCount,
        "pageCount": pageCount,
      };
}

class Datum {
  Datum({
    required this.type,
    required this.title,
    required this.date,
    required this.index,
    required this.time,
    required this.league,
    required this.teamHome,
    required this.teamAway,
    required this.forecast,
    required this.odds,
    required this.status,
    required this.homeScore,
    required this.awayScore,
    required this.id,
    required this.coupon,
  });

  final String? type;
  final String? title;
  final String? date;
  final int? index;
  final String? time;
  final League? league;
  final League? teamHome;
  final League? teamAway;
  final String? forecast;
  final String? odds;
  final String? status;
  final String? homeScore;
  final String? awayScore;
  final String? id;
  final Coupon? coupon;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      type: json["type"],
      title: json["title"],
      date: json["date"],
      index: json["index"],
      time: json["time"],
      league: json["league"] == null ? null : League.fromJson(json["league"]),
      teamHome:
          json["teamHome"] == null ? null : League.fromJson(json["teamHome"]),
      teamAway:
          json["teamAway"] == null ? null : League.fromJson(json["teamAway"]),
      forecast: json["forecast"],
      odds: json["odds"],
      status: json["status"],
      homeScore: json["homeScore"],
      awayScore: json["awayScore"],
      id: json["_id"],
      coupon: json["coupon"] == null ? null : Coupon.fromJson(json["coupon"]),
    );
  }

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

class Coupon {
  Coupon({
    required this.type,
    required this.title,
    required this.date,
  });

  final String? type;
  final String? title;
  final String? date;

  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      type: json["type"],
      title: json["title"],
      date: json["date"],
    );
  }

  Map<String, dynamic> toJson() => {
        "type": type,
        "title": title,
        "date": date,
      };
}

class League {
  League({
    required this.id,
    required this.name,
    required this.v,
    required this.countryCode,
    required this.image,
    required this.icon,
  });

  final String? id;
  final String? name;
  final int? v;
  final String? countryCode;
  final String? image;
  final String? icon;

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      id: json["_id"],
      name: json["name"],
      v: json["__v"],
      countryCode: json["countryCode"],
      image: json["image"],
      icon: json["icon"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "__v": v,
        "countryCode": countryCode,
        "image": image,
        "icon": icon,
      };
}
