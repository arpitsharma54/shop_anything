import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_everything/model/flvaor_config.model.dart';
import 'package:shop_everything/screens/fav-view/fav-view.dart';
import 'package:shop_everything/screens/home-view/home-view.dart';
import 'package:shop_everything/widgets/bottom-navigation-bar.dart';

final pageControllerProvider = StateProvider<PageController>((ref) {
  return PageController(initialPage: 0);
});

var flavorConfigProvider;

void mainCommon(FlavorConfig flavorConfig) {
  flavorConfigProvider = StateProvider<FlavorConfig>((ref) => flavorConfig);
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color.fromARGB(255, 211, 186, 193),
  ));
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: ref.watch(flavorConfigProvider).appTitle,
      theme: ref.read(flavorConfigProvider).theme,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        bottomNavigationBar: const CustomBottomNavigationBar(
            // index: ref.watch(homeViewModelProvider).bottomNavIndex,
            // onTap: ref.read(homeViewModelProvider).changeBottomNavIndex,
            ),
        body: Consumer(
          builder: (context, ref, child) => PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: ref.watch(pageControllerProvider),
            children: const [
              HomeView(),
              FavView(),
            ],
          ),
        ),
      ),
    );
  }
}
