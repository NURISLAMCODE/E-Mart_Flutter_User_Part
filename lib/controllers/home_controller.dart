import 'package:emart_app/consts/consts.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    getUserName();
    super.onInit();
  }

  var currntNavIndex = 0.obs;

  var currentNavIndex = 0.obs;
  var username = '';
  var featuredList = [];
  var searchController = TextEditingController();
  getUserName() async {
    var n = await firestore
        .collection(ussersCollections)
        //.where('id', isEqualTo: currentUser!.uid)
        .where('id')
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['name'];
      }
    });
    username = n;
  }
}
