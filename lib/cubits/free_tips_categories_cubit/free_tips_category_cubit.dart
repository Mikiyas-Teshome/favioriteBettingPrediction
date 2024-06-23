import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:faviorite_app/models/categories_model.dart';
import '../../repositories/category_repository.dart';

part 'free_tips_category_state.dart';

class FreeTipsCategoryCubit extends Cubit<FreeTipsCategoryState> {
  final CategoryRepository categoryRepository;

  FreeTipsCategoryCubit(this.categoryRepository)
      : super(FreeTipsCategoryInitial());

  Future<void> fetchCategories() async {
    try {
      emit(FreeTipsCategoryLoading());

      final List<int> randomNumbers = generateRandomNumbers();
      final categories = await categoryRepository.fetchCategories();
      emit(FreeTipsCategoryLoaded(categories, randomNumbers));
    } catch (e) {
      emit(FreeTipsCategoryError('Failed to fetch categories'));
    }
  }

  List<int> generateRandomNumbers() {
    final random = Random();
    final List<int> numbers = List.generate(10, (index) => index);
    numbers.shuffle(random);
    return numbers.take(6).toList();
  }
}
