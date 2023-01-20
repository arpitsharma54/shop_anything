import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_everything/screens/home-view/home-view-model.dart';

class CustomGridTile extends StatefulWidget {
  final String? name;
  final String? image;
  final double? price;
  final bool isFav;
  final String productIndex;
  const CustomGridTile(
      {super.key,
      this.name,
      this.image,
      this.price,
      required this.isFav,
      required this.productIndex});

  @override
  State<CustomGridTile> createState() => _CustomGridTileState();
}

class _CustomGridTileState extends State<CustomGridTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            // onTap: () {
            //   print("Navigat to details screen");
            // },
            child: CachedNetworkImage(
              imageUrl: widget.image!,
              height: MediaQuery.of(context).size.height * 0.3,
              imageBuilder: (context, imageProvider) => Stack(
                alignment: Alignment.topRight,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image(
                      height: MediaQuery.of(context).size.height * 0.3,
                      image: imageProvider,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    right: 5,
                    top: 5,
                    child: Material(
                      borderRadius: BorderRadius.circular(50),
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      child: Consumer(
                        builder: (context, ref, child) => InkWell(
                          splashColor: const Color.fromARGB(255, 245, 188, 188),
                          borderRadius: BorderRadius.circular(50),
                          onTap: () {
                            ref.read(updateFavProductsProvider(
                                [!widget.isFav, widget.productIndex]));
                            print("Fav. Button Pressed");
                          },
                          child: CircleAvatar(
                            radius: 17,
                            backgroundColor: Colors.transparent,
                            child: widget.isFav
                                ? const Icon(
                                    Icons.favorite_rounded,
                                    size: 20,
                                    color: Color.fromRGBO(229, 91, 91, 1),
                                  )
                                : const Icon(
                                    Icons.favorite_border_rounded,
                                    size: 20,
                                    color: Color.fromRGBO(229, 91, 91, 1),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: Color.fromRGBO(233, 110, 110, 1),
              )),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.name!.length < 15
                ? widget.name!
                : "${widget.name!.substring(0, 15)}...",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: const Color.fromRGBO(68, 68, 68, 1),
            ),
          ),
          Text(
            "\$${widget.price}",
            style: GoogleFonts.poppins(
              color: const Color.fromRGBO(156, 156, 156, 1),
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
