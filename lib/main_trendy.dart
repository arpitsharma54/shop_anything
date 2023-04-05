import 'package:flutter/material.dart';
import 'package:shop_everything/main_common.dart';
import 'package:shop_everything/model/flvaor_config.model.dart';

void main() {
  final trendyConfig = FlavorConfig()
    ..appTitle = "Trendy"
    ..apiEndPoint = {
      Endpoint.item: "products",
    }
    ..imageLocation = "assets/flavor_image/fashion_icon.png"
    ..theme = ThemeData.light().copyWith(
      primaryColor: const Color(0xFF123456),
      appBarTheme: ThemeData.light().appBarTheme.copyWith(
            backgroundColor: const Color(0xFF654321),
          ),
    );

  mainCommon(trendyConfig);
}
