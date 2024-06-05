part of 'tips_bloc.dart';

abstract class TipsEvent {}

class FetchTipsList extends TipsEvent {
  final String categoryId;
  FetchTipsList({
    required this.categoryId,
  });
}
