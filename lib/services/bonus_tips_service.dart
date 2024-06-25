import 'package:dio/dio.dart';
import 'package:faviorite_app/models/bonus_tips_model.dart';
import 'package:faviorite_app/models/free_tips_model.dart';

import '../constants/url_constants.dart';
import '../models/categories_model.dart';

class BonusTipsService {
  final Dio _dio = Dio();

  Future<BonusTipsModel> fetchTips({required String categoryName}) async {
    try {
      final response = await _dio.get(
        fetchBonusTipsUrl,
        data: {"cat": categoryName},
      );
      print("status: ${response.statusCode} \n categoryName: $categoryName");

      if (response.statusCode == 200 && !response.data['HasError']) {
        final jsonData = response.data as Map<String, dynamic>;
        return BonusTipsModel.fromJson(jsonData);
      } else {
        print(
            "Res data: ${response.data} Error fetching data: ${response.statusCode}");
        throw Exception("Error fetching data: ${response.statusCode}");
      }
    } on DioException catch (error) {
      print("Error: ${error.message}");
      throw Exception("Error: ${error.message}");
    }
  }
}
