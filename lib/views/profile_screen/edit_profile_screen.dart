import 'dart:io';

import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/profile_controller.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:emart_app/widgets_common/custom_textfield.dart';
import 'package:emart_app/widgets_common/loading_indicator.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:get/get.dart';

class EditProfileScrren extends StatelessWidget {
  final dynamic data;
  const EditProfileScrren({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //if data image url and controller path is empty
              data['imageUrl'] == '' && controller.profileImgPath.isEmpty
                  ? Image.asset(
                      imgProfile,
                      width: 100,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make()

                  //if data is not empty but controller path is empty
                  : data['imageUrl'] != '' && controller.profileImgPath.isEmpty
                      ? Image.network(
                          data['imageUrl'],
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make()
                      //else if controoler path is not empty but data image url is
                      : Image.file(
                          File(controller.profileImgPath.value),
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),
              10.heightBox,
              ourButton(
                  color: redColor,
                  onPress: () {
                    controller.changeImage(context);
                  },
                  textColor: whiteColor,
                  title: "Change"),
              const Divider(),
              20.heightBox,
              customTextField(
                  controller: controller.nameController,
                  hint: nameHint,
                  title: name,
                  isPass: false),
              10.heightBox,
              customTextField(
                  controller: controller.oldpasswordController,
                  hint: passwordHint,
                  title: oldpass,
                  isPass: true),
              10.heightBox,
              customTextField(
                  controller: controller.newpasswordController,
                  hint: passwordHint,
                  title: newpass,
                  isPass: true),
              20.heightBox,
              controller.isLoding.value
                  ? loadingIndicator()
                  : SizedBox(
                      width: context.screenWidth - 60,
                      child: ourButton(
                          color: redColor,
                          onPress: () async {
                            controller.isLoding(true);

                            //if image is not selected
                            if (controller.profileImgPath.value.isNotEmpty) {
                              await controller.uploadProfileImage();
                            } else {
                              controller.profileImageLink = data['imageUrl'];
                            }

                            if (data['password'] ==
                                controller.oldpasswordController.text) {
                              await controller.changeAuthPassword(
                                email: data['email'],
                                password: controller.oldpasswordController.text,
                                newPassword:
                                    controller.newpasswordController.text,
                              );
                              await controller.updateProfile(
                                imgUrl: controller.profileImageLink,
                                name: controller.nameController.text,
                                password: controller.newpasswordController.text,
                              );
                              VxToast.show(context, msg: "Update");
                            } else {
                              VxToast.show(context, msg: "wrong old password");
                            }
                          },
                          textColor: whiteColor,
                          title: "Save"),
                    ),
            ],
          )
              .box
              .shadowSm
              .white
              .padding(const EdgeInsets.all(16))
              .margin(const EdgeInsets.only(top: 50, left: 20, right: 20))
              .rounded
              .make(),
        ),
      ),
    );
  }
}
