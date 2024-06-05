part of 'categories_bloc.dart';

abstract class CategoriesState {}

class FetchCategoriesInitial extends CategoriesState {}

class FetchCategoriesLoading extends CategoriesState {}

class FetchCategoriesSuccess extends CategoriesState {
  final CategoriesModel items;
  final List<int> randomNumbers;

  FetchCategoriesSuccess(
    this.items,
    this.randomNumbers,
  );
}

class FetchCategoriesErrorState extends CategoriesState {
  final String message;

  FetchCategoriesErrorState(this.message);
}

abstract class HomeTipsState {}

final class TipsInitial extends HomeTipsState {}

class FetchHomeTipsInitial extends HomeTipsState {}

class FetchHomeTipsLoading extends HomeTipsState {}

class FetchHomeTipsSuccess extends HomeTipsState {
  final FreeTipsModel tips;

  FetchHomeTipsSuccess({
    required this.tips,
  });
}

class FetchHomeTipsErrorState extends HomeTipsState {
  final String message;

  FetchHomeTipsErrorState(this.message);
}
