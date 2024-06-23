part of 'free_tips_category_cubit.dart';

abstract class FreeTipsCategoryState extends Equatable {
  @override
  List<Object> get props => [];
}

class FreeTipsCategoryInitial extends FreeTipsCategoryState {}

class FreeTipsCategoryLoading extends FreeTipsCategoryState {}

class FreeTipsCategoryLoaded extends FreeTipsCategoryState {
  final CategoriesModel categories;

  final List<int> randomNumbers;
  FreeTipsCategoryLoaded(this.categories, this.randomNumbers);

  @override
  List<Object> get props => [categories];
}

class FreeTipsCategoryError extends FreeTipsCategoryState {
  final String message;

  FreeTipsCategoryError(this.message);

  @override
  List<Object> get props => [message];
}
