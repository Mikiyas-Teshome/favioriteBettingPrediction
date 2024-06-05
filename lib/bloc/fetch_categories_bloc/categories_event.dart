part of 'categories_bloc.dart';

abstract class CategoriesEvent {}

class FetchCategoriesList extends CategoriesEvent {}

class FetchHomeTipsList extends CategoriesEvent {
  final String categoryId;
  FetchHomeTipsList({
    required this.categoryId,
  });
}
