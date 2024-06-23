import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:faviorite_app/models/categories_model.dart';
import 'package:faviorite_app/models/vip_tips_categories_model.dart';
import '../../repositories/category_repository.dart';

part 'vip_tips_category_state.dart';

class VipTipsCategoryCubit extends Cubit<VipTipsCategoryState> {
  final CategoryRepository categoryRepository;

  VipTipsCategoryCubit(this.categoryRepository)
      : super(VipTipsCategoryInitial());

  Future<void> fetchCategories() async {
    try {
      emit(VipTipsCategoryLoading());

      final categories = await categoryRepository.fetchVipCategories();
      emit(VipTipsCategoryLoaded(
        categories,
      ));
    } catch (e) {
      emit(VipTipsCategoryError('Failed to fetch categories'));
    }
  }
}
