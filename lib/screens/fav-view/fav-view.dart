import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import './fav-view-model.dart';
import '../../widgets/search-text-feild.dart';

class FavView extends ConsumerStatefulWidget {
  const FavView({super.key});

  @override
  ConsumerState<FavView> createState() => _FavViewState();
}

class _FavViewState extends ConsumerState<FavView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;
  @override
  void dispose() {
    ref.invalidate(favSearchTextProvider);
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 247, 232, 236),
            Color.fromRGBO(255, 251, 252, 1),
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Material(
                      shape: const CircleBorder(),
                      child: IconButton(
                          splashColor: const Color.fromARGB(255, 245, 188, 188),
                          onPressed: () {},
                          icon: const Image(
                              height: 22,
                              image:
                                  AssetImage("assets/images/menu-icon.png"))),
                    ),
                  ),
                  const CircleAvatar(
                    foregroundImage: AssetImage("assets/images/profile.png"),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Your Favorites",
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
                onChangedProvider: favSearchTextProvider,
                searchFeildFocusNode: ref.watch(favSearchFeildFocusProvider),
              ),
              const SizedBox(
                height: 10,
              ),
              // ref.watch(favProductsListProvider).when(
              //     loading: () => const Expanded(
              //           child: Center(
              //             child: CircularProgressIndicator(
              //               strokeWidth: 2,
              //             ),
              //           ),
              //         ),
              //     error: (error, stackTrace) => Center(
              //           child: Text(
              //             error.toString(),
              //             style: GoogleFonts.poppins(
              //               color: Colors.red,
              //               fontSize: 16,
              //               fontWeight: FontWeight.w500,
              //             ),
              //           ),
              //         ),
              //     data: (data) {
              //       List<ProductModel> filteredList = data;

              //       filteredList = filteredList
              //           .where((element) => element.name!
              //               .toLowerCase()
              //               .contains(ref.watch(favSearchTextProvider)))
              //           .toList();
              //       return filteredList.isEmpty
              //           ? Expanded(
              //               child: Center(
              //               child: Text(
              //                 "No Products Found",
              //                 style: GoogleFonts.poppins(
              //                   color: Colors.black,
              //                   fontSize: 16,
              //                   fontWeight: FontWeight.w500,
              //                 ),
              //               ),
              //             ))
              //           : Expanded(
              //               flex: 11,
              //               child: GridView.builder(
              //                 physics: const BouncingScrollPhysics(),
              //                 itemCount: filteredList.length,
              //                 gridDelegate:
              //                     const SliverGridDelegateWithFixedCrossAxisCount(
              //                   crossAxisSpacing: 20,
              //                   mainAxisSpacing: 4,
              //                   crossAxisCount: 2,
              //                   childAspectRatio: 0.44,
              //                 ),
              //                 itemBuilder: (context, index) {
              //                   return CustomGridTile(
              //                     name: filteredList[index].name,
              //                     isFav: filteredList[index].isFav!,
              //                     image: filteredList[index].image,
              //                     price: filteredList[index].price,
              //                     productIndex:
              //                         filteredList[index].productIndex!,
              //                   );
              //                 },
              //               ),
              //             );
              //     }),
              !isLoading
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: OutlinedButton(
                        onPressed: () async {
                          await phoneSignIn(phoneNumber: "+917898580811");
                        },
                        child: Text("Log In"),
                        style: ButtonStyle(
                            side: MaterialStateProperty.all<BorderSide>(
                                BorderSide.none)),
                      ),
                    )
                  : CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> phoneSignIn({required String phoneNumber}) async {
    setState(() {
      isLoading = false;
    });

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: _onVerificationCompleted,
      verificationFailed: _onVerificationFailed,
      codeSent: _onCodeSent,
      codeAutoRetrievalTimeout: _onCodeTimeout,
    );
  }

  _onVerificationCompleted(PhoneAuthCredential authCredential) async {
    print("verification completed ${authCredential.smsCode}");
    User? user = FirebaseAuth.instance.currentUser;

    if (authCredential.smsCode != null) {
      try {
        UserCredential credential =
            await user!.linkWithCredential(authCredential);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'provider-already-linked') {
          await _auth.signInWithCredential(authCredential);
        }
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  _onVerificationFailed(FirebaseAuthException exception) {
    if (exception.code == 'invalid-phone-number') {
      showMessage("The phone number entered is invalid!");
    }
  }

  _onCodeSent(String verificationId, int? forceResendingToken) {
    print(forceResendingToken);
    print("code sent");
  }

  _onCodeTimeout(String timeout) {
    return null;
  }

  void showMessage(String errorMessage) {
    showDialog(
        context: context,
        builder: (BuildContext builderContext) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(errorMessage),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () async {
                  Navigator.of(builderContext).pop();
                },
              )
            ],
          );
        }).then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }
}
