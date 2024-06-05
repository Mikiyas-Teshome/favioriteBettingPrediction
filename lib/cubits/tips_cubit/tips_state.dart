part of 'tips_cubit.dart';

sealed class TipsState extends Equatable {
  const TipsState();
}

final class TipsInitial extends TipsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TipsLoading extends TipsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TipsLoaded extends TipsState {
  final FreeTipsModel tips;

  TipsLoaded(this.tips);

  @override
  List<Object> get props => [tips];
}

class TipsError extends TipsState {
  final String message;

  TipsError(this.message);

  @override
  List<Object> get props => [message];
}
