import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/chat_screen/chat_screen.dart';
import 'package:emart_app/widgets_common/loading_indicator.dart';
import 'package:get/get.dart';

class MessagesScreeen extends StatelessWidget {
  const MessagesScreeen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title:
            "My Messgaes".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getAllMessages(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return loadingIndicator();
          } else if (snapshot.data!.docs.isEmpty) {
            return "No orders Yet!".text.make();
          } else {
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: ListTile(
                            onTap: () {
                              Get.to(
                                () => const ChatScreen(),
                                arguments: [
                                  data[index]['friend_name'],
                                  data[index]['told'],
                                ],
                              );
                            },
                            leading: const CircleAvatar(
                              backgroundColor: redColor,
                              child: Icon(
                                Icons.person,
                                color: whiteColor,
                              ),
                            ),
                            title: "${data[index]['friend_name']}"
                                .text
                                .color(darkFontGrey)
                                .fontFamily(semibold)
                                .make(),
                            subtitle: "${data[index]['last_msg']}".text.make(),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
