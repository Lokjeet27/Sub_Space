import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sub_space/controller/blog_details_controller.dart';
import 'package:sub_space/views/bloc_page.dart';

BlocDetailsController blocDetailsController = Get.put(BlocDetailsController());

class SelectedBlogDetails extends StatelessWidget {
  final int index;
  const SelectedBlogDetails({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CircleAvatar(
          child: Icon(Icons.person),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(const BlogPage());
            },
            icon: const Icon(Icons.close),
          ),
        ],
        title: const Text('Blog Details'),
      ),
      body: GetBuilder<BlocDetailsController>(builder: (controller) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                'id: ${controller.blogList[index].id ?? "null"}',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15.0,
                ),
              ),
            ),
            Container(
              height: 200.0,
              width: 410.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0)),
                image: DecorationImage(
                  image: NetworkImage(
                      controller.blogList[index].imageUrl ?? "null"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                controller.blogList[index].title ?? "null",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15.0,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                controller.blogList[index].isFavourite!.toggle();
                controller.update();
                print('bloc page fav on single tap');
              },
              icon: controller.blogList[index].isFavourite!.value
                  ? const Icon(
                      Icons.favorite,
                      color: Colors.pink,
                    )
                  : const Icon(
                      Icons.favorite_border_rounded,
                      color: Colors.grey,
                    ),
            ),
          ],
        );
      }),
    );
  }
}

// Stack(
// children: [
// Image.network(controller.blogList[index].imageUrl ?? "null"),
// Text(controller.blogList[index].title ?? "null"),
// IconButton(
// onPressed: () {
// controller.blogList[index].isFavourite!.toggle();
// print('change color of fav');
// controller.update();
// },
// icon: controller.blogList[index].isFavourite!.value
// ? const Icon(
// Icons.favorite,
// color: Colors.pink,
// )
//     : const Icon(
// Icons.favorite_border_rounded,
// color: Colors.grey,
// ),
// ),
// ],
// );
