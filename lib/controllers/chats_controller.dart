import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/home_controller.dart';
import 'package:get/get.dart';

class ChatsColntroller extends GetxController {
  @override
  void onInit() {
    getChatId();
    super.onInit();
  }

  var chats = firestore.collection(chatsCollection);

  var friendName = Get.arguments[0];
  var friendId = Get.arguments[1];

  var msgController = TextEditingController();

  var senderName = Get.find<HomeController>().username;
  var currentId = currentUser!.uid;

  dynamic chatDocId;

  var isLoding = false.obs;
  getChatId() async {
    isLoding(true);
    await chats
        .where('users', isEqualTo: {friendId: null, currentId: null})
        .limit(1)
        .get()
        .then((QuerySnapshot snapshot) {
          if (snapshot.docs.isNotEmpty) {
            chatDocId = snapshot.docs.single.id;
          } else {
            chats.add({
              'created_on': null,
              'last_msg': '',
              'users': {friendId: null, currentId: null},
              'told': '',
              'fromId': '',
              'friend_name': friendName,
              'sender_name': senderName
            }).then((value) {
              chatDocId = value.id;
            });
          }
        });
    isLoding(false);
  }

  sendMsg(String msg) {
    if (msg.trim().isNotEmpty) {
      chats.doc(chatDocId).update({
        'created_on': FieldValue.serverTimestamp(),
        'last_msg': msg,
        'told': friendId,
        'fromId': currentId,
      });

      chats.doc(chatDocId).collection(messageCollextion).doc().set({
        'created_on': FieldValue.serverTimestamp(),
        'msg': msg,
        'uid': currentId,
      });
    }
  }
}
