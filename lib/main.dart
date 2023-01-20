import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_everything/screens/fav-view/fav-view.dart';
import 'package:shop_everything/screens/home-view/home-view.dart';
import 'package:shop_everything/widgets/bottom-navigation-bar.dart';

final pageControllerProvider = StateProvider((ref) {
  return PageController(initialPage: 0);
});

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color.fromARGB(255, 211, 186, 193),
  ));
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping App',
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          secondary: const Color.fromARGB(255, 247, 232, 236),
        ),
      ),
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
