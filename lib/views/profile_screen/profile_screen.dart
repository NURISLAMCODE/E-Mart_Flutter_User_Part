import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/controllers/profile_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/auth_screen/login_screen.dart';
import 'package:emart_app/views/chat_screen/messaging_screen.dart';
import 'package:emart_app/views/order_screen/orders_screen.dart';
import 'package:emart_app/views/profile_screen/components/details_card.dart';
import 'package:emart_app/views/profile_screen/edit_profile_screen.dart';
import 'package:emart_app/views/wishlist_screen/wishlist_screen.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:emart_app/widgets_common/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    // FirestoreServices.getCounts();
    return bgWidget(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirestoreServices.getUser(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loadingIndicator();
            } else {
              var data = snapshot.data!.docs[0];

              return SafeArea(
                //padding: const EdgeInsets.all(8),
                child: Column(children: [
                  //edit profile button

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Align(
                        alignment: Alignment.topRight,
                        child: Icon(
                          Icons.edit,
                          color: whiteColor,
                        )).onTap(() {
                      controller.nameController.text = data['name'];

                      Get.to(() => EditProfileScrren(
                            data: data,
                          ));
                    }),
                  ),
                  //user details section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        data['imageUrl'] == ''
                            ? Image.asset(
                                imgProfile,
                                width: 100,
                                fit: BoxFit.cover,
                              ).box.roundedFull.clip(Clip.antiAlias).make()
                            : Image.network(
                                data['imageUrl'],
                                width: 100,
                                fit: BoxFit.cover,
                              ).box.roundedFull.clip(Clip.antiAlias).make(),
                        10.widthBox,
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "${data['name']}"
                                .text
                                .fontFamily(semibold)
                                .white
                                .make(),
                            "${data['email']}"
                                .text
                                .fontFamily(semibold)
                                .white
                                .make()
                          ],
                        )),
                        OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                              color: whiteColor,
                            )),
                            onPressed: () {
                              Get.to(() => const LoginScreen());
                            },
                            child: "Log out"
                                .text
                                .fontFamily(semibold)
                                .white
                                .make())
                      ],
                    ),
                  ),
                  FutureBuilder(
                    future: FirestoreServices.getCounts(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: loadingIndicator(),
                        );
                      } else {
                        //print(snapshot.data);
                        var countData = snapshot.data;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            detailsCard(
                                count: countData[0].toString(),
                                title: "in Your card",
                                width: context.screenWidth / 3.4),
                            detailsCard(
                                count: countData[1].toString(),
                                title: "in Your wishList",
                                width: context.screenWidth / 3.4),
                            detailsCard(
                                count: countData[2].toString(),
                                title: " Your orders",
                                width: context.screenWidth / 3.4),
                          ],
                        );
                      }
                    },
                  ),
                  10.heightBox,
                  // FutureBuilder(
                  //   future: FirestoreServices.getCounts(),
                  //   builder: (BuildContext context, AsyncSnapshot snapshot) {
                  //     if (!snapshot.data) {
                  //       return Center(
                  //         child: loadingIndicator(),
                  //       );
                  //     } else {
                  // var countData = snapshot.data;
                  // return Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     detailsCard(
                  //         count: countData[0].toString(),
                  //         title: "in Your card",
                  //         width: context.screenWidth / 3.4),
                  //     detailsCard(
                  //         count: countData[1].toString(),
                  //         title: "in Your wishList",
                  //         width: context.screenWidth / 3.4),
                  //     detailsCard(
                  //         count: countData[2].toString(),
                  //         title: " Your orders",
                  //         width: context.screenWidth / 3.4),
                  //   ],
                  // );
                  //     }
                  //   },
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     detailsCard(
                  //         count: "${data['cart_count']}",
                  //         title: "in Your card",
                  //         width: context.screenWidth / 3.4),
                  //     detailsCard(
                  //         count: "${data['wishlist_count']}",
                  //         title: "in Your wishList",
                  //         width: context.screenWidth / 3.4),
                  //     detailsCard(
                  //         count: "${data['order_count']}",
                  //         title: " Your orders",
                  //         width: context.screenWidth / 3.4),
                  //   ],
                  // ),
                  00.heightBox,

                  //buttons section

                  ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: ((context, index) {
                      return const Divider(
                        color: lightGrey,
                      );
                    }),
                    itemCount: profileButtonsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        onTap: () {
                          switch (index) {
                            case 0:
                              Get.to(() => const OrdersScreen());
                              break;
                            case 1:
                              Get.to(() => const WishlistScreen());
                              break;
                            case 2:
                              Get.to(() => const MessagesScreeen());
                              break;
                          }
                        },
                        leading: Image.asset(
                          profileButtonsIcon[index],
                          width: 22,
                        ),
                        title: profileButtonsList[index]
                            .text
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .make(),
                      );
                    },
                  )
                      .box
                      .white
                      .rounded
                      .shadowSm
                      .margin(const EdgeInsets.all(12))
                      .padding(const EdgeInsets.symmetric(horizontal: 16))
                      .make()
                      .box
                      .color(redColor)
                      .make(),
                ]),
              );
            }
          },
        ),
      ),
    );
  }
}
