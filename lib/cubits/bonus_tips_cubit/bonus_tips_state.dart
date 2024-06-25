part of 'bonus_tips_cubit.dart';

@immutable
sealed class BonusTipsState {}

final class BonusTipsInitial extends BonusTipsState {}

class BonusTipsLoading extends BonusTipsState {}

class BonusTipsSuccess extends BonusTipsState {
  final BonusTipsModel tips;

  BonusTipsSuccess({
    required this.tips,
  });
}

class BonusTipsErrorState extends BonusTipsState {
  final String message;

  BonusTipsErrorState(this.message);
}
