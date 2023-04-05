import 'package:flutter/material.dart';

enum Endpoint { item }

class FlavorConfig {
  String? appTitle;
  Map<Endpoint, dynamic>? apiEndPoint;
  String? imageLocation;
  ThemeData? theme;

  FlavorConfig({
    this.appTitle = "Flavor Example",
    this.imageLocation = "assets/flavor_image/3616049.png",
    this.apiEndPoint,
    this.theme,
  });
}
