import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/auth_controller.dart';
import 'package:emart_app/views/auth_screen/login_screen.dart';

import 'package:emart_app/widgets_common/applogo_widget.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:emart_app/widgets_common/custom_textfield.dart';
import 'package:emart_app/widgets_common/our_button.dart';

import 'package:get/get.dart';

class SingupScreen extends StatefulWidget {
  const SingupScreen({super.key});

  @override
  State<SingupScreen> createState() => _SingupScreenState();
}

class _SingupScreenState extends State<SingupScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());

  //text controller
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(children: [
          (context.screenHeight * 0.1).heightBox,
          applogoWidget(),
          10.heightBox,
          "Join the $appname".text.fontFamily(bold).white.size(18).make(),
          15.heightBox,
          Obx(
            () => controller.isloding.value
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  )
                : Column(
                    children: [
                      customTextField(
                          title: name,
                          hint: nameHint,
                          controller: nameController,
                          isPass: false),
                      customTextField(
                          title: email,
                          hint: emailHint,
                          controller: emailController,
                          isPass: false),
                      customTextField(
                          title: password,
                          hint: passwordHint,
                          controller: passwordController,
                          isPass: true),
                      customTextField(
                          title: retypePassword,
                          hint: passwordHint,
                          controller: passwordRetypeController,
                          isPass: true),
                      Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {}, child: forgetPass.text.make())),
                      Row(
                        children: [
                          Checkbox(
                            checkColor: redColor,
                            value: isCheck,
                            onChanged: (newValue) {
                              setState(() {
                                isCheck = newValue;
                              });
                            },
                          ),
                          10.heightBox,
                          Expanded(
                            child: RichText(
                                text: const TextSpan(children: [
                              TextSpan(
                                  text: "I agree to the ",
                                  style: TextStyle(
                                    fontFamily: regular,
                                    color: fontGrey,
                                  )),
                              TextSpan(
                                  text: termAndCond,
                                  style: TextStyle(
                                    fontFamily: regular,
                                    color: redColor,
                                  )),
                              TextSpan(
                                  text: " & ",
                                  style: TextStyle(
                                    fontFamily: regular,
                                    color: fontGrey,
                                  )),
                              TextSpan(
                                  text: privacyPolicy,
                                  style: TextStyle(
                                    fontFamily: regular,
                                    color: redColor,
                                  )),
                            ])),
                          )
                        ],
                      ),
                      5.heightBox,
                      ourButton(
                          color: isCheck == true ? redColor : lightGrey,
                          title: singup,
                          textColor: whiteColor,
                          onPress: () async {
                            if (isCheck != false) {
                              try {
                                controller.isloding(true);
                                await controller
                                    .signupMethod(
                                        context: context,
                                        email: emailController.text,
                                        password: passwordController.text)
                                    .then((value) {
                                  controller.storeUserData(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    name: nameController.text,
                                  );
                                }).then((value) {
                                  VxToast.show(context, msg: loggedin);
                                  Get.offAll(() => const LoginScreen());
                                });
                              } catch (e) {
                                auth.signOut();
                                VxToast.show(context, msg: e.toString());
                                controller.isloding(false);
                              }
                            }
                          }).box.rounded.width(context.screenWidth - 50).make(),
                      10.heightBox,
                      //wrapping into gesture of velocity X
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          alreadyHaveAcount.text.color(fontGrey).make(),
                          login.text.color(redColor).make().onTap(() {
                            Get.back();
                          })
                        ],
                      ),
                      5.heightBox,
                    ],
                  )
                    .box
                    .white
                    .rounded
                    .padding(const EdgeInsets.all(16))
                    .width(context.screenWidth - 70)
                    .shadowSm
                    .make(),
          )
        ]),
      ),
    ));
  }
}
