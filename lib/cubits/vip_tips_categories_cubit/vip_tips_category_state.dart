part of 'vip_tips_category_cubit.dart';

abstract class VipTipsCategoryState extends Equatable {
  @override
  List<Object> get props => [];
}

class VipTipsCategoryInitial extends VipTipsCategoryState {}

class VipTipsCategoryLoading extends VipTipsCategoryState {}

class VipTipsCategoryLoaded extends VipTipsCategoryState {
  final VipTipsCategoryModel categories;

  VipTipsCategoryLoaded(
    this.categories,
  );

  @override
  List<Object> get props => [categories];
}

class VipTipsCategoryError extends VipTipsCategoryState {
  final String message;

  VipTipsCategoryError(this.message);

  @override
  List<Object> get props => [message];
}
