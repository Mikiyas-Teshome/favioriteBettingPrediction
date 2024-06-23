import 'package:dio/dio.dart';
import 'package:faviorite_app/models/categories_model.dart';
import 'package:faviorite_app/models/free_tips_model.dart';

import '../constants/url_constants.dart';
import '../models/vip_tips_categories_model.dart';

class CategoryRepository {
  final Dio _dio = Dio();

  Future<CategoriesModel> fetchCategories() async {
    final response = await _dio.get(fetchFreeCategoriesUrl,
        options: Options(headers: {
          "application": "63762d7ba4b7b40ec4f71fe1",
        }));
    if (response.statusCode == 200) {
      final jsonData = response.data as Map<String, dynamic>;
      return CategoriesModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<VipTipsCategoryModel> fetchVipCategories() async {
    final response = await _dio.get(fetchVipCategoriesUrl,
        options: Options(headers: {
          "application": "63762d7ba4b7b40ec4f71fe1",
        }));
    if (response.statusCode == 200) {
      final jsonData = response.data as Map<String, dynamic>;
      return VipTipsCategoryModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<FreeTipsModel> fetchSubcategories(String categoryId) async {
    try {
      final response = await _dio.get(fetchFreeTipsUrl + categoryId,
          options: Options(headers: {
            "application": "63762d7ba4b7b40ec4f71fe1",
          }));
      // print("Res data: ${response.data}");

      if (response.statusCode == 200) {
        final jsonData = response.data;
        return FreeTipsModel.fromJson(jsonData);
      } else {
        // print("Error fetching data: ${response.statusCode}");
        throw Exception("Error fetching data: ${response.statusCode}");
      }
    } on DioException catch (error) {
      // print("Error: ${error.message}");
      throw Exception("Error: ${error.message}");
    }
  }
}
