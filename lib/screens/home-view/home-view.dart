import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_everything/main_common.dart';
import 'package:shop_everything/model/flvaor_config.model.dart';
import 'package:shop_everything/model/product.model.dart';
import 'package:shop_everything/repository/repository.dart';
import 'package:shop_everything/screens/home-view/home-view-model.dart';
import 'package:shop_everything/widgets/bottom-navigation-bar.dart';
import 'package:shop_everything/widgets/custom-text-button.dart';
import 'package:shop_everything/widgets/search-text-feild.dart';
import 'package:http/http.dart' as http;

import '../../widgets/custom-grid-tile.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        // ref.read(homeViewModelProvider).removeSearchFeildFocus();
        ref
            .read(unfocusFeildsProvider)
            .call(focusNode: ref.read(serachFeildFocusProvider));
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: ref.watch(flavorConfigProvider).appTitle == "Trendy"
                ? [
                    const Color.fromARGB(255, 248, 224, 224),
                    const Color.fromARGB(255, 255, 236, 236),
                  ]
                : [
                    const Color.fromARGB(255, 247, 232, 236),
                    const Color.fromRGBO(255, 251, 252, 1),
                  ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Material(
                            shape: const CircleBorder(),
                            child: IconButton(
                              splashColor:
                                  const Color.fromARGB(255, 245, 188, 188),
                              onPressed: () {},
                              icon: const Image(
                                height: 22,
                                image:
                                    AssetImage("assets/images/menu-icon.png"),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  insetPadding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  contentPadding: EdgeInsets.zero,
                                  content: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: const LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Color.fromARGB(255, 247, 232, 236),
                                          Color.fromRGBO(255, 251, 252, 1),
                                        ],
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ref.watch(imageProvider) != null
                                            ? SizedBox(
                                                height: 150,
                                                width: 150,
                                                child: ClipRRect(
                                                  clipBehavior: Clip.hardEdge,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  child: Image(
                                                    fit: BoxFit.fill,
                                                    image: FileImage(File(ref
                                                        .watch(imageProvider)!
                                                        .path)),
                                                  ),
                                                ),
                                              )
                                            : const SizedBox(
                                                height: 150,
                                                width: 150,
                                                child: Image(
                                                  image: AssetImage(
                                                      "assets/images/profile.png"),
                                                ),
                                              ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            final ImagePicker _picker =
                                                ImagePicker();
                                            final image =
                                                await _picker.pickImage(
                                                    source:
                                                        ImageSource.gallery);
                                            if (image != null) {
                                              if (image.path.endsWith("png") ||
                                                  image.path.endsWith("jpg") ||
                                                  image.path.endsWith("jpeg")) {
                                                ref
                                                    .read(
                                                        imageProvider.notifier)
                                                    .state = image;

                                                Navigator.pop(context);
                                              } else {
                                                print("Denied");
                                              }
                                            }
                                          },
                                          child: Text(
                                            "Sophia Tween",
                                            style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: const CircleAvatar(
                            foregroundImage:
                                AssetImage("assets/images/profile.png"),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      ref.watch(flavorConfigProvider).appTitle == "Trendy"
                          ? "All trendy brands at one place"
                          : "All type of yum food for foodie's.",
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SearchTextFeild(
                      onChangedProvider: searchText,
                      searchFeildFocusNode:
                          // ref.watch(homeViewModelProvider).serchFeildFocus
                          ref.watch(serachFeildFocusProvider),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(left: 25),
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      // ref
                      //     .watch(homeViewModelProvider)
                      //     .filterButtonText
                      //     .length
                      ref.watch(filterButtonTextProvider).length,
                  itemBuilder: (context, index) {
                    return CustomTextButton(
                      index: index,
                      // title: ref
                      //     .watch(homeViewModelProvider)
                      //     .filterButtonText[index],
                      // currentbuttonIndex:
                      //     ref.watch(homeViewModelProvider).filterbuttonIndex,
                      // index: index,
                      // onTap: ref
                      //     .read(homeViewModelProvider)
                      //     .changeFilterButtonIndex,
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ref.watch(fetchProductsProvider).when(
                  loading: () => const Expanded(
                        flex: 7,
                        child: Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        ),
                      ),
                  error: (error, stackTrace) => Expanded(
                        flex: 7,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                error.toString(),
                                style: GoogleFonts.poppins(
                                  color: Colors.red,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  ref.watch(apiFunctionsProvider).fetchProducts(
                                      ref
                                          .watch(flavorConfigProvider)
                                          .apiEndPoint[Endpoint.item]);
                                },
                                child: const Text("Reload"),
                              ),
                            ],
                          ),
                        ),
                      ),
                  data: (data) {
                    List<ProductModel> filteredList = [];
                    final filterNameIndex =
                        ref.watch(filterbuttonIndexProvider);
                    final filterNameList = ref.watch(filterButtonTextProvider);
                    if (filterNameList[filterNameIndex] != "All") {
                      data.forEach((element) {
                        if (element.filter ==
                            filterNameList[filterNameIndex].toLowerCase()) {
                          filteredList.add(element);
                        }
                      });
                    } else {
                      filteredList = data;
                    }
                    filteredList = filteredList
                        .where((element) => element.name!
                            .toLowerCase()
                            .contains(ref.watch(searchText)))
                        .toList();
                    return filteredList.isEmpty
                        ? Expanded(
                            flex: 7,
                            child: Center(
                              child: Text(
                                "No Products Found",
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ))
                        : Expanded(
                            flex: 7,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: GridView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: filteredList.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 4,
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.5,
                                ),
                                itemBuilder: (context, index) {
                                  return CustomGridTile(
                                    name: filteredList[index].name,
                                    isFav: filteredList[index].isFav!,
                                    image: filteredList[index].image,
                                    price: filteredList[index].price,
                                    productIndex:
                                        filteredList[index].productIndex!,
                                  );
                                },
                              ),
                            ),
                          );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
