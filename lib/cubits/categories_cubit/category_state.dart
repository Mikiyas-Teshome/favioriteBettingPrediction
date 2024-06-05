part of 'category_cubit.dart';

abstract class CategoryState extends Equatable {
  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final CategoriesModel categories;

  final List<int> randomNumbers;
  CategoryLoaded(this.categories, this.randomNumbers);

  @override
  List<Object> get props => [categories];
}

class CategoryError extends CategoryState {
  final String message;

  CategoryError(this.message);

  @override
  List<Object> get props => [message];
}
