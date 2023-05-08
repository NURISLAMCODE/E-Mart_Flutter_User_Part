import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/widgets_common/loading_indicator.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title:
            "My Wishlists".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getWishlists(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return loadingIndicator();
          } else if (snapshot.data!.docs.isEmpty) {
            return "No orders Yet!".text.make();
          } else {
            var data = snapshot.data!.docs;
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Image.network(
                      "${data[index]['p_imgs'][0]}",
                      width: 90,
                      fit: BoxFit.cover,
                    ),
                    title: "${data[index]['p_name']})"
                        .text
                        .fontFamily(semibold)
                        .size(16)
                        .make(),
                    subtitle: "${data[index]['p_price']}"
                        .numCurrency
                        .text
                        .color(redColor)
                        .fontFamily(semibold)
                        .make(),
                    trailing: const Icon(
                      Icons.favorite,
                      color: redColor,
                    ).onTap(() {
                      firestore
                          .collection(poroductCollection)
                          .doc(data[index].id)
                          .set({
                        'p_wishlist': FieldValue.arrayRemove([currentUser!.uid])
                      }, SetOptions(merge: true));
                    }),
                  );
                });
          }
        },
      ),
    );
  }
}
