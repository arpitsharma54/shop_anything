import 'package:flutter/material.dart';
import 'package:shop_everything/main_common.dart';
import 'package:shop_everything/model/flvaor_config.model.dart';

void main() {
  final foodyConfig = FlavorConfig()
    ..appTitle = "Foody"
    ..apiEndPoint = {
      Endpoint.item: "food",
    }
    ..imageLocation = "assets/flavor_image/food_icon.png.png"
    ..theme = ThemeData.light().copyWith(
      primaryColor: const Color(0xFF123456),
      appBarTheme: ThemeData.light().appBarTheme.copyWith(
            backgroundColor: const Color(0xFF654321),
          ),
    );

  mainCommon(foodyConfig);
}
