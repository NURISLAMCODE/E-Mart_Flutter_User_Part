import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/controllers/product_controller.dart';
import 'package:emart_app/views/category_screen/category_details.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: categories.text.fontFamily(bold).white.make(),
        ),
        body: Container(
            padding: const EdgeInsets.all(12),
            child: GridView.builder(
                shrinkWrap: true,
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    mainAxisExtent: 200),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Image.asset(
                        categoriesImage[index],
                        height: 100,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                      10.heightBox,
                      categoriesList[index]
                          .text
                          .align(TextAlign.center)
                          .color(darkFontGrey)
                          .make()
                    ],
                  )
                      .box
                      .white
                      .rounded
                      .clip(Clip.antiAlias)
                      .outerShadowSm
                      .make()
                      .onTap(() {
                    controller.getSubCategories(categoriesList[index]);
                    Get.to(() => CategoryDetails(title: categoriesList[index]));
                  });
                })),
      ),
    );
  }
}
