import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_everything/main_common.dart';
import 'package:shop_everything/screens/fav-view/fav-view-model.dart';
import 'package:shop_everything/screens/fav-view/fav-view.dart';
import 'package:shop_everything/screens/home-view/home-view-model.dart';
import 'package:shop_everything/screens/home-view/home-view.dart';

// class CustomBottomNavigationBar extends StatefulWidget {
//   final int index;
//   final Function onTap;
//   const CustomBottomNavigationBar(
//       {required this.index, required this.onTap, super.key});

//   @override
//   State<CustomBottomNavigationBar> createState() =>
//       Custom_BottomNavigationBarState();
// }

// class Custom_BottomNavigationBarState extends State<CustomBottomNavigationBar> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 25),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           IconButton(
//             splashRadius: 23,
//             onPressed: widget.index == 0
//                 ? () {}
//                 : () {
//                     setState(() {
//                       widget.onTap(0);
//                     });
//                   },
//             iconSize: 30,
//             color: widget.index == 0
//                 ? const Color.fromRGBO(233, 110, 110, 1)
//                 : const Color.fromRGBO(192, 192, 192, 1),
//             icon: const Icon(Icons.home),
//           ),
//           IconButton(
//             splashRadius: 23,
//             onPressed: widget.index == 1
//                 ? () {}
//                 : () {
//                     setState(() {
//                       widget.onTap(1);
//                     });
//                   },
//             iconSize: 30,
//             color: widget.index == 1
//                 ? const Color.fromRGBO(233, 110, 110, 1)
//                 : const Color.fromRGBO(192, 192, 192, 1),
//             icon: const Icon(Icons.menu_rounded),
//           ),
//           IconButton(
//             splashRadius: 23,
//             onPressed: widget.index == 2
//                 ? () {}
//                 : () {
//                     setState(() {
//                       widget.onTap(2);
//                     });
//                   },
//             iconSize: 30,
//             color: widget.index == 2
//                 ? const Color.fromRGBO(233, 110, 110, 1)
//                 : const Color.fromRGBO(192, 192, 192, 1),
//             icon: const Icon(Icons.shopping_cart_rounded),
//           ),
//           IconButton(
//             splashRadius: 23,
//             onPressed: widget.index == 3
//                 ? () {}
//                 : () {
//                     setState(() {
//                       widget.onTap(3);
//                     });
//                   },
//             iconSize: 30,
//             color: widget.index == 3
//                 ? const Color.fromRGBO(233, 110, 110, 1)
//                 : const Color.fromRGBO(192, 192, 192, 1),
//             icon: const Icon(Icons.person_rounded),
//           ),
//         ],
//       ),
//     );
//   }
// }

class CustomBottomNavigationBar extends ConsumerWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 253, 248, 250),
            Color.fromRGBO(255, 251, 252, 1),
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            splashRadius: 23,
            onPressed: ref.watch(bottomNavIndexProvider) == 0
                ? () {}
                : () {
                    ref.read(changeBottomNavIndexProvider).call(newIndex: 0);
                    ref.watch(pageControllerProvider).animateToPage(0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut);
                  },
            iconSize: 30,
            color: ref.watch(bottomNavIndexProvider) == 0
                ? const Color.fromRGBO(233, 110, 110, 1)
                : const Color.fromRGBO(192, 192, 192, 1),
            icon: const Icon(Icons.home),
          ),
          IconButton(
            splashRadius: 23,
            onPressed: ref.watch(bottomNavIndexProvider) == 1
                ? () {}
                : () {
                    ref.read(changeBottomNavIndexProvider).call(newIndex: 1);
                    ref.watch(pageControllerProvider).animateToPage(1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut);
                  },
            iconSize: 30,
            color: ref.watch(bottomNavIndexProvider) == 1
                ? const Color.fromRGBO(233, 110, 110, 1)
                : const Color.fromRGBO(192, 192, 192, 1),
            icon: const Icon(Icons.favorite),
          ),
          IconButton(
            splashRadius: 23,
            onPressed: ref.watch(bottomNavIndexProvider) == 2
                ? () {}
                : () {
                    ref.read(changeBottomNavIndexProvider).call(newIndex: 2);
                  },
            iconSize: 30,
            color: ref.watch(bottomNavIndexProvider) == 2
                ? const Color.fromRGBO(233, 110, 110, 1)
                : const Color.fromRGBO(192, 192, 192, 1),
            icon: const Icon(Icons.shopping_cart_rounded),
          ),
          IconButton(
            splashRadius: 23,
            onPressed: ref.watch(bottomNavIndexProvider) == 3
                ? () {}
                : () {
                    ref.read(changeBottomNavIndexProvider).call(newIndex: 3);
                  },
            iconSize: 30,
            color: ref.watch(bottomNavIndexProvider) == 3
                ? const Color.fromRGBO(233, 110, 110, 1)
                : const Color.fromRGBO(192, 192, 192, 1),
            icon: const Icon(Icons.person_rounded),
          ),
        ],
      ),
    );
  }
}
