import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_everything/screens/home-view/home-view-model.dart';

// class CustomTextButton extends StatefulWidget {
//   final String title;
//   final int currentbuttonIndex;
//   final int index;
//   final Function onTap;
//   const CustomTextButton(
//       {required this.title,
//       required this.currentbuttonIndex,
//       required this.index,
//       required this.onTap,
//       super.key});

//   @override
//   State<CustomTextButton> createState() => CustomTextButtonState();
// }

// class CustomTextButtonState extends State<CustomTextButton> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(right: 10),
//       child: Material(
//         color: widget.index == widget.currentbuttonIndex
//             ? const Color.fromRGBO(233, 110, 110, 1)
//             : const Color.fromRGBO(223, 220, 220, 1),
//         borderRadius: BorderRadius.circular(12),
//         child: InkWell(
//           borderRadius: BorderRadius.circular(12),
//           splashColor: const Color.fromARGB(255, 245, 188, 188),
//           onTap: () {
//             widget.onTap(widget.index);
//           },
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 17),
//             child: Text(
//               widget.title,
//               style: GoogleFonts.poppins(
//                 color: widget.index == widget.currentbuttonIndex
//                     ? Colors.white
//                     : const Color.fromRGBO(147, 143, 143, 1),
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class CustomTextButton extends ConsumerWidget {
  final int index;
  const CustomTextButton({required this.index, super.key});

//   @override
//   State<CustomTextButton> createState() => CustomTextButtonState();
// }

// class CustomTextButtonState extends State<CustomTextButton> {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: Material(
        color: index == ref.watch(filterbuttonIndexProvider)
            ? const Color.fromRGBO(233, 110, 110, 1)
            : const Color.fromRGBO(223, 220, 220, 1),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          splashColor: const Color.fromARGB(255, 245, 188, 188),
          onTap: () {
            ref.read(changeFilterButtonIndexProvider).call(newIndex: index);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 17),
            child: Text(
              ref.watch(filterButtonTextProvider)[index],
              style: GoogleFonts.poppins(
                color: index == ref.watch(filterbuttonIndexProvider)
                    ? Colors.white
                    : const Color.fromRGBO(147, 143, 143, 1),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
