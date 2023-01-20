import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_everything/model/product.model.dart';
import 'package:http/http.dart' as http;

final apiFunctionsProvider = ChangeNotifierProvider<ApiFunctions>((ref) {
  return ApiFunctions();
});

class ApiFunctions with ChangeNotifier {
  Future<List<ProductModel>> fetchProducts() async {
    try {
      final url = Uri.parse(
          "https://shop-everything-6ede4-default-rtdb.asia-southeast1.firebasedatabase.app/products.json");
      final response = await http.get(url);
      print("<======== ${jsonDecode(response.body)} =======>");
      final data = Map<String, dynamic>.from(jsonDecode(response.body) ?? {});
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
      {required bool value, required String productIndex}) async {
    final url = Uri.parse(
        "https://shop-everything-6ede4-default-rtdb.asia-southeast1.firebasedatabase.app/products/$productIndex.json");
    final response = await http.patch(url, body: jsonEncode({'isFav': value}));
    print(jsonDecode(response.body));
    await fetchProducts();
    notifyListeners();
  }
}
