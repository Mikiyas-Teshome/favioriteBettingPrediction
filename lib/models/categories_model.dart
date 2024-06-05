// models/categories_model.dart

class CategoriesModel {
  final int page;
  final List<Category> data;
  final int resultCount;
  final int pageCount;

  CategoriesModel({
    required this.page,
    required this.data,
    required this.resultCount,
    required this.pageCount,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(
        page: json['page'] as int,
        data: List<Category>.from(
          json['data'].map((x) => Category.fromJson(x)),
        ),
        resultCount: json['resultCount'] as int,
        pageCount: json['pageCount'] as int,
      );
}

class Category {
  final String id;
  final int v;
  final String announcement;
  final String application;
  final String name;
  final List<dynamic> subscriptions;
  final String image;

  Category({
    required this.id,
    required this.v,
    required this.announcement,
    required this.application,
    required this.name,
    required this.subscriptions,
    required this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json['_id'] as String,
        v: json['__v'] as int,
        announcement: json['announcement'] as String,
        application: json['application'] as String,
        name: json['name'] as String,
        subscriptions: List<dynamic>.from(json['subscriptions']),
        image: json['image'] as String,
      );
}
