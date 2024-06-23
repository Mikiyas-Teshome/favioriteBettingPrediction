part of 'bonus_tips_bloc.dart';

abstract class BonusTipsEvent {}

class FetchBonusTipsList extends BonusTipsEvent {
  final String categoryName;
  FetchBonusTipsList({
    required this.categoryName,
  });
}
