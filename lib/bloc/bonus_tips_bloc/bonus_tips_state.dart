part of 'bonus_tips_bloc.dart';

abstract class BonusTipsState {}

class FetchBonusInitial extends BonusTipsState {}

class FetchBonusTipsLoading extends BonusTipsState {}

class FetchBonusTipsSuccess extends BonusTipsState {
  final BonusTipsModel tips;

  FetchBonusTipsSuccess({
    required this.tips,
  });
}

class FetchBonusTipsErrorState extends BonusTipsState {
  final String message;

  FetchBonusTipsErrorState(this.message);
}
