import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/bonus_tips_model.dart';
import '../../services/bonus_tips_service.dart';

part 'bonus_tips_state.dart';

class BonusTipsCubit extends Cubit<BonusTipsState> {
  final BonusTipsService tipsService;
  BonusTipsCubit(this.tipsService) : super(BonusTipsInitial());

  Future<void> fetchBonusTipsList(String categoryName) async {
    // print('ing subcategories for category ID: ${event.categoryName}');

    try {
      emit(BonusTipsLoading());
      final tips = await tipsService.fetchTips(categoryName: categoryName);
      emit(BonusTipsSuccess(
        tips: tips,
      ));
    } catch (e) {
      emit(BonusTipsErrorState('Failed to fetch Tips'));
    }
  }
}

// final CategoryRepository categoryRepository;
// TipsCubit(this.categoryRepository) : super(TipsInitial());
//
// Future<void> fetchTips(String categoryId) async {
// try {
// emit(TipsLoading());
// final subcategories =
// await categoryRepository.fetchSubcategories(categoryId);
// emit(TipsLoaded(subcategories));
// } catch (e) {
// emit(TipsError(e.toString()));
// }
// }
