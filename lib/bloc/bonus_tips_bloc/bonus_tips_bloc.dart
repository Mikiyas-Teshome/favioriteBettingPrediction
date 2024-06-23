import 'package:bloc/bloc.dart';
import 'package:faviorite_app/models/bonus_tips_model.dart';
import 'package:faviorite_app/services/bonus_tips_service.dart';
import 'package:meta/meta.dart';

import '../../models/free_tips_model.dart';
import '../../services/tips_service.dart';

part 'bonus_tips_event.dart';
part 'bonus_tips_state.dart';

class BonusTipsBloc extends Bloc<BonusTipsEvent, BonusTipsState> {
  final BonusTipsService _tipsService;

  BonusTipsBloc(this._tipsService) : super(FetchBonusInitial()) {
    on<BonusTipsEvent>((event, emit) {
      // TODO: implement event handler
      on<FetchBonusTipsList>(_onFetchBonusTipsList);
    });
  }
  Future<void> _onFetchBonusTipsList(
      FetchBonusTipsList event, Emitter<BonusTipsState> emit) async {
    // print('Fetching subcategories for category ID: ${event.categoryName}');
    emit(FetchBonusTipsLoading());
    try {
      final tips =
          await _tipsService.fetchTips(categoryName: event.categoryName);
      emit(FetchBonusTipsSuccess(
        tips: tips,
      ));
    } catch (e) {
      emit(FetchBonusTipsErrorState('Failed to fetch Tips'));
    }
  }
}
