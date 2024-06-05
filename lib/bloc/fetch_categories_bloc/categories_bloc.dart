import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:faviorite_app/models/categories_model.dart';
import 'package:faviorite_app/models/free_tips_model.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';

import '../../services/tips_service.dart';
import '../tips_bloc/tips_bloc.dart';
part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final TipsService tipsService;
  // final TipsBloc tipsBloc;

  CategoriesBloc({
    required this.tipsService,
  }) : super(FetchCategoriesInitial()) {
    on<FetchCategoriesList>(_onFetchCategoriesList);
  }

  Future<void> _onFetchCategoriesList(
      FetchCategoriesList event, Emitter<CategoriesState> emit) async {
    emit(FetchCategoriesLoading());
    try {
      final List<int> randomNumbers = generateRandomNumbers();
      final categories = await tipsService.fetchCategories();
      emit(FetchCategoriesSuccess(categories, randomNumbers));
      if (categories.data.isNotEmpty) {
        // FetchTipsList(
        //   categoryId: categories.data[randomNumbers[0]].id,
        // );
        // tipsBloc.add(FetchTipsList(
        //   categoryId: categories.data[randomNumbers[0]].id,
        // ));
      }
    } catch (e) {
      emit(FetchCategoriesErrorState('Failed to fetch categories'));
    }
  }

  List<int> generateRandomNumbers() {
    final random = Random();
    final List<int> numbers = List.generate(10, (index) => index);
    numbers.shuffle(random);
    return numbers.take(6).toList();
  }
}

class HomeTipsBloc extends Bloc<CategoriesEvent, HomeTipsState> {
  final TipsService _tipsService;

  HomeTipsBloc(this._tipsService) : super(TipsInitial()) {
    on<CategoriesEvent>((event, emit) {
      // TODO: implement event handler
      on<FetchHomeTipsList>(_onFetchHomeTipsList);
    });
  }
  Future<void> _onFetchHomeTipsList(
      FetchHomeTipsList event, Emitter<HomeTipsState> emit) async {
    emit(FetchHomeTipsLoading());
    try {
      final tips = await _tipsService.fetchTips(categoryId: event.categoryId);
      emit(FetchHomeTipsSuccess(
        tips: tips,
      ));
    } catch (e) {
      emit(FetchHomeTipsErrorState('Failed to fetch Tips'));
    }
  }
}
