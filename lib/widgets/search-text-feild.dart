import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_everything/screens/home-view/home-view-model.dart';

class SearchTextFeild extends StatefulWidget {
  final FocusNode searchFeildFocusNode;
  AutoDisposeStateProvider onChangedProvider;
  SearchTextFeild({
    required this.searchFeildFocusNode,
    super.key,
    required this.onChangedProvider,
  });

  @override
  State<SearchTextFeild> createState() => _SearchTextFeildState();
}

class _SearchTextFeildState extends State<SearchTextFeild> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Consumer(
        builder: (context, ref, child) => TextField(
          textAlignVertical: TextAlignVertical.bottom,
          focusNode: widget.searchFeildFocusNode,
          cursorColor: const Color.fromARGB(255, 255, 169, 169),
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            filled: true,
            fillColor: Colors.white,
            prefixIcon: const Icon(
              Icons.search,
              color: Color.fromRGBO(182, 182, 182, 1),
            ),
            hintText: "Search by name",
            hintStyle: GoogleFonts.poppins(
              color: const Color.fromRGBO(182, 182, 182, 1),
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          onChanged: (value) {
            ref.watch(widget.onChangedProvider.notifier).state = value;
          },
        ),
      ),
    );
  }
}
