import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_everything/model/product.model.dart';
import 'package:shop_everything/repository/repository.dart';
import 'package:shop_everything/screens/home-view/home-view-model.dart';

import '../../main_common.dart';

final favSearchFeildFocusProvider = StateProvider<FocusNode>((ref) {
  return FocusNode();
});

final favSearchTextProvider = StateProvider.autoDispose((ref) {
  return "";
});

final favProductsListProvider =
    FutureProvider.autoDispose<List<ProductModel>>((ref) async {
  final data = await ref.watch(apiFunctionsProvider).fetchProducts(
      ref.watch(flavorConfigProvider).appTitle == "Trendy"
          ? "products"
          : "food");
  List<ProductModel> favList =
      data.where((element) => element.isFav == true).toList();
  return favList;
});
