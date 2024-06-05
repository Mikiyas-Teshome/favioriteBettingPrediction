import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/free_tips_model.dart';
import '../../services/tips_service.dart';

part 'tips_event.dart';
part 'tips_state.dart';

class TipsBloc extends Bloc<TipsEvent, TipsState> {
  final TipsService _tipsService;

  TipsBloc(this._tipsService) : super(TipsInitial()) {
    on<TipsEvent>((event, emit) {
      // TODO: implement event handler
      on<FetchTipsList>(_onFetchTipsList);
    });
  }
  Future<void> _onFetchTipsList(
      FetchTipsList event, Emitter<TipsState> emit) async {
    print('Fetching subcategories for category ID: ${event.categoryId}');
    emit(FetchTipsLoading());
    try {
      final tips = await _tipsService.fetchTips(categoryId: event.categoryId);
      emit(FetchTipsSuccess(
        tips: tips,
      ));
    } catch (e) {
      emit(FetchTipsErrorState('Failed to fetch Tips'));
    }
  }
}
