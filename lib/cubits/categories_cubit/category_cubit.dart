import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:faviorite_app/models/categories_model.dart';
import '../../repositories/category_repository.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepository categoryRepository;

  CategoryCubit(this.categoryRepository) : super(CategoryInitial());

  Future<void> fetchCategories() async {
    try {
      emit(CategoryLoading());

      final List<int> randomNumbers = generateRandomNumbers();
      final categories = await categoryRepository.fetchCategories();
      emit(CategoryLoaded(categories, randomNumbers));
    } catch (e) {
      emit(CategoryError('Failed to fetch categories'));
    }
  }

  List<int> generateRandomNumbers() {
    final random = Random();
    final List<int> numbers = List.generate(10, (index) => index);
    numbers.shuffle(random);
    return numbers.take(6).toList();
  }
}
