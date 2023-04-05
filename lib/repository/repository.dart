import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_everything/model/product.model.dart';
import 'package:http/http.dart' as http;

final apiFunctionsProvider = ChangeNotifierProvider<ApiFunctions>((ref) {
  return ApiFunctions();
});

class ApiFunctions with ChangeNotifier {
  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 3),
      receiveTimeout: const Duration(seconds: 3),
    ),
  );

  ApiFunctions() {
    _dio.options.baseUrl =
        "https://shop-everything-6ede4-default-rtdb.asia-southeast1.firebasedatabase.app/";
  }

  Future<List<ProductModel>> fetchProducts(String folderName) async {
    print(folderName);
    try {
      final Response response = await _dio.get("$folderName.json");

      print("<======== ${response.data} =======>");
      final data = Map<String, dynamic>.from(response.data ?? {});
      List<ProductModel> products = [];
      List<String> keysList = data.keys.toList();
      for (var i = 0; i < data.length; i++) {
        products.add(ProductModel.fromJson(data[keysList[i]], keysList[i]));
      }

      return products;
    } catch (error) {
      print(error.toString());
      return [];
    }
  }

  Future<void> updateFavProduct(
      {required bool value,
      required String productIndex,
      required String folderName}) async {
    final response = await _dio.patch("$folderName/$productIndex.json",
        data: jsonEncode({'isFav': value}));
    print(response.data);
    await fetchProducts(folderName);
    notifyListeners();
  }
}
