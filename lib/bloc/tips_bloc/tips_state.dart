part of 'tips_bloc.dart';

abstract class TipsState {}

final class TipsInitial extends TipsState {}

class FetchTipsLoading extends TipsState {}

class FetchTipsSuccess extends TipsState {
  final FreeTipsModel tips;

  FetchTipsSuccess({
    required this.tips,
  });
}

class FetchTipsErrorState extends TipsState {
  final String message;

  FetchTipsErrorState(this.message);
}
