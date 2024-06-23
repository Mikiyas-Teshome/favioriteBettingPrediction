import 'dart:convert';

class BonusTipsModel {
  final bool hasError;
  final String? errorMessage;
  final List<Category> categoryList;

  BonusTipsModel({
    required this.hasError,
    this.errorMessage,
    required this.categoryList,
  });

  factory BonusTipsModel.fromJson(Map<String, dynamic> json) {
    return BonusTipsModel(
      hasError: json['HasError'],
      errorMessage: json['ErrorMessage'],
      categoryList: List<Category>.from(
        json['CategoryList'].map((category) => Category.fromJson(category)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'HasError': hasError,
      'ErrorMessage': errorMessage,
      'CategoryList':
          categoryList.map((category) => category.toJson()).toList(),
    };
  }
}

class Category {
  final String id;
  final String name;
  final String icon;
  final String information;
  final String headerIsVisible;
  final String headerText;
  final String headerUrl;
  final String footerIsVisible;
  final String footerText;
  final String footerUrl;
  final List<Coupon> couponList;
  final int nextPage;
  final int totalPage;
  final bool hasNextPage;

  Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.information,
    required this.headerIsVisible,
    required this.headerText,
    required this.headerUrl,
    required this.footerIsVisible,
    required this.footerText,
    required this.footerUrl,
    required this.couponList,
    required this.nextPage,
    required this.totalPage,
    required this.hasNextPage,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['Id'],
      name: json['Name'],
      icon: json['Icon'],
      information: json['Information'],
      headerIsVisible: json['HeaderIsVisible'],
      headerText: json['HeaderText'],
      headerUrl: json['HeaderUrl'],
      footerIsVisible: json['FooterIsVisible'],
      footerText: json['FooterText'],
      footerUrl: json['FooterUrl'],
      couponList: List<Coupon>.from(
        json['CouponList'].map((coupon) => Coupon.fromJson(coupon)),
      ),
      nextPage: json['NextPage'],
      totalPage: json['TotalPage'],
      hasNextPage: json['HasNextPage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'Icon': icon,
      'Information': information,
      'HeaderIsVisible': headerIsVisible,
      'HeaderText': headerText,
      'HeaderUrl': headerUrl,
      'FooterIsVisible': footerIsVisible,
      'FooterText': footerText,
      'FooterUrl': footerUrl,
      'CouponList': couponList.map((coupon) => coupon.toJson()).toList(),
      'NextPage': nextPage,
      'TotalPage': totalPage,
      'HasNextPage': hasNextPage,
    };
  }
}

class Coupon {
  final int id;
  final String name;
  final String information;
  final String date;
  final List<Match> matchList;

  Coupon({
    required this.id,
    required this.name,
    required this.information,
    required this.date,
    required this.matchList,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      id: json['Id'],
      name: json['Name'],
      information: json['Information'],
      date: json['Date'],
      matchList: List<Match>.from(
        json['MatchList'].map((match) => Match.fromJson(match)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'Information': information,
      'Date': date,
      'MatchList': matchList.map((match) => match.toJson()).toList(),
    };
  }
}

class Match {
  final String home;
  final String homeScore;
  final String visitor;
  final String visitorScore;
  final String bet;
  final String rate;
  final String status;
  final String date;
  final String time;
  final String league;
  final String flag;
  final int like;
  final int dislike;
  final bool isLiked;
  final bool isDisliked;
  final int publicRow;

  Match({
    required this.home,
    required this.homeScore,
    required this.visitor,
    required this.visitorScore,
    required this.bet,
    required this.rate,
    required this.status,
    required this.date,
    required this.time,
    required this.league,
    required this.flag,
    required this.like,
    required this.dislike,
    required this.isLiked,
    required this.isDisliked,
    required this.publicRow,
  });

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      home: json['Home'],
      homeScore: json['HomeScore'],
      visitor: json['Visitor'],
      visitorScore: json['VisitorScore'],
      bet: json['Bet'],
      rate: json['Rate'],
      status: json['Status'],
      date: json['Date'],
      time: json['Time'],
      league: json['League'],
      flag: json['Flag'],
      like: json['Like'],
      dislike: json['DisLike'],
      isLiked: json['IsLiked'],
      isDisliked: json['IsDisliked'],
      publicRow: json['PublicRow'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Home': home,
      'HomeScore': homeScore,
      'Visitor': visitor,
      'VisitorScore': visitorScore,
      'Bet': bet,
      'Rate': rate,
      'Status': status,
      'Date': date,
      'Time': time,
      'League': league,
      'Flag': flag,
      'Like': like,
      'DisLike': dislike,
      'IsLiked': isLiked,
      'IsDisliked': isDisliked,
      'PublicRow': publicRow,
    };
  }
}
