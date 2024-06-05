import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:faviorite_app/models/free_tips_model.dart';

import '../../repositories/category_repository.dart';
part 'tips_state.dart';

class TipsCubit extends Cubit<TipsState> {
  final CategoryRepository categoryRepository;
  TipsCubit(this.categoryRepository) : super(TipsInitial());

  Future<void> fetchTips(String categoryId) async {
    try {
      emit(TipsLoading());
      final subcategories =
          await categoryRepository.fetchSubcategories(categoryId);
      emit(TipsLoaded(subcategories));
    } catch (e) {
      emit(TipsError(e.toString()));
    }
  }
}
