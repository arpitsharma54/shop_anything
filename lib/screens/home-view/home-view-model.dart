import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_everything/main_common.dart';
import 'package:shop_everything/model/flvaor_config.model.dart';
import 'package:shop_everything/repository/repository.dart';

import '../../model/product.model.dart';

// final homeViewModelProvider = ChangeNotifierProvider<HomeViewModel>((ref) {
//   return HomeViewModel();
// });

// class HomeViewModel extends ChangeNotifier {
//   int bottomNavIndex = 0;

//   int filterbuttonIndex = 0;

//   List<String> filterButtonText = ["All", "New", "Trending Now"];

//   void changeBottomNavIndex(int newIndex) {
//     bottomNavIndex = newIndex;
//     notifyListeners();
//   }

//   void changeFilterButtonIndex(int newIndex) {
//     filterbuttonIndex = newIndex;
//     notifyListeners();
//   }

//   final FocusNode serchFeildFocus = FocusNode();

//   void removeSearchFeildFocus() {
//     serchFeildFocus.unfocus();
//     notifyListeners();
//   }
// }

final bottomNavIndexProvider = StateProvider<int>((ref) {
  return 0;
});

final filterbuttonIndexProvider = StateProvider<int>((ref) {
  return 0;
});

final filterButtonTextProvider = StateProvider<List<String>>((ref) {
  return ["All", "New", "Trending Now"];
});

final serachFeildFocusProvider = StateProvider<FocusNode>((ref) {
  return FocusNode();
});

final unfocusFeildsProvider = StateProvider((ref) {
  return ({required FocusNode focusNode}) {
    focusNode.unfocus();
  };
});

final changeBottomNavIndexProvider = StateProvider((ref) {
  return ({required int newIndex}) {
    ref.read(bottomNavIndexProvider.notifier).state = newIndex;
  };
});

final changeFilterButtonIndexProvider = StateProvider((ref) {
  return ({required int newIndex}) {
    ref.read(filterbuttonIndexProvider.notifier).state = newIndex;
  };
});

final fetchProductsProvider =
    FutureProvider.autoDispose<List<ProductModel>>((ref) {
  return ref.watch(apiFunctionsProvider).fetchProducts(
      ref.watch(flavorConfigProvider).apiEndPoint[Endpoint.item]);
});

final updateFavProductsProvider =
    FutureProvider.family.autoDispose((ref, List value) {
  return ref.watch(apiFunctionsProvider).updateFavProduct(
      value: value[0],
      productIndex: value[1],
      folderName: ref.watch(flavorConfigProvider).apiEndPoint[Endpoint.item]);
});

final searchText = StateProvider.autoDispose<String>((ref) {
  return "";
});

final imageProvider = StateProvider<XFile?>((ref) {
  XFile? image;
  return image;
});
