import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sub_space/controller/blog_details_controller.dart';
import 'package:sub_space/repository/blog_fetch.dart';
import 'package:sub_space/views/selected_blog_details.dart';

BlocDetailsController blocDetailsController = Get.put(BlocDetailsController());
BlogFetch blogFetch = Get.put(BlogFetch());

const List<BottomNavigationBarItem> _bottomList = [
  BottomNavigationBarItem(
    icon: Icon(Icons.remove_red_eye),
    label: 'profile',
  ),
  BottomNavigationBarItem(
      icon: Icon(Icons.record_voice_over_sharp), label: 'Connections'),
  BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
  BottomNavigationBarItem(icon: Icon(Icons.contact_phone), label: 'Contacts'),
  BottomNavigationBarItem(
      icon: Icon(
        Icons.tag_rounded,
        size: 30.0,
      ),
      label: 'Groups'),
];
int bottomNavigationIndex = 0;

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  void _onBottomItemTapped(int index) {
    setState(() {
      bottomNavigationIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(blocDetailsController.blogList);
    return Scaffold(
      appBar: AppBar(
          leading: Icon(Icons.app_registration_rounded),
          backgroundColor: Color(0xff00557E),
          title: Text('BLog App')),
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
        showUnselectedLabels: true,
        enableFeedback: false,
        selectedItemColor: const Color(0xff19435F),
        unselectedItemColor: const Color(0xff667C88),
        currentIndex: bottomNavigationIndex,
        items: _bottomList,
        onTap: _onBottomItemTapped,
      ),
      backgroundColor: Colors.blueAccent,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GetBuilder<BlocDetailsController>(builder: (controller) {
                // controller.blogList;
                return controller.isLoading.value
                    ? const Center(child: CupertinoActivityIndicator())
                    : ListView.builder(
                        itemCount: controller.blogList.length,
                        itemBuilder: (context, index) {
                          var currItem = controller.blogList[index];
                          return GestureDetector(
                              onTap: () {
                                Get.to(SelectedBlogDetails(index: index));
                                print('the index is : $index');
                              },
                              onDoubleTap: () {
                                controller.blogList[index].isFavourite!
                                    .toggle();
                                controller.update();
                                print('the like button: ');
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Card(
                                  elevation: 5,
                                  child: SizedBox(
                                    height: 250.0,
                                    width: 100.0,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 160.0,
                                          width: 410.0,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10.0),
                                                topRight:
                                                    Radius.circular(10.0)),
                                            image: DecorationImage(
                                              image: NetworkImage(controller
                                                      .blogList[index]
                                                      .imageUrl ??
                                                  "null"),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            controller.blogList[index].title ??
                                                "null",
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
                                            controller
                                                .blogList[index].isFavourite!
                                                .toggle();
                                            controller.update();
                                            print(
                                                'bloc page fav on single tap');
                                          },
                                          icon: controller.blogList[index]
                                                  .isFavourite!.value
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
                                    ),
                                  ),
                                ),
                              ));
                        });
              }),
            ),
          ],
        ),
      ),
    );
  }
}
// Card(
// shape: RoundedRectangleBorder(
// side: BorderSide(
// color: Theme.of(context).primaryColor,
// width: 1,
// ),
// borderRadius: BorderRadius.circular(5),
// ),
// elevation: 5,
// child: Stack(
// children: [
// SizedBox(
// width: double.infinity,
// child: Image.network(
// controller.blogList[index].imageUrl ??
// "null"),
// ),
// Center(
// child: Text(
// controller.blogList[index].title ??
// "null",
// textAlign: TextAlign.center,
// ),
// ),
// IconButton(
// onPressed: () {
// controller.blogList[index].isFavourite!
//     .toggle();
// controller.update();
// print('bloc page fav on single tap');
// },
// icon: controller
//     .blogList[index].isFavourite!.value
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
// ),
// ),

// Container(
// child: Card(
// shape: RoundedRectangleBorder(
// side: BorderSide(
// color: Theme.of(context).primaryColor,
// width: 1,
// ),
// borderRadius: BorderRadius.circular(5),
// ),
// elevation: 5,
// child: Column(
// children: [
// SizedBox(
// height: 10.0,
// ),
// Container(
// height: 120.0,
// width: double.infinity,
// child: Image.network(
// currItem.imageUrl ?? "null"),
// ),
// Text(currItem.id ?? "Null"),
// ],
// ),
// ),
// );

// print(blogFetch.fail);
// if (blogFetch.fail ?? false) {
// print("fail");
// //Get.snackbar('Error Found', blogFetch.message.toString());
// return AlertDialog(
// title: Text("ERROR"),
// content: SingleChildScrollView(
// child: ListBody(
// children: [Text(blogFetch.errorMessage.toString())],
// ),
// ),
// actions: [
// TextButton(
// onPressed: () {
// blocDetailsController.getDataToList();
// },
// child: Text('ok'))
// ],
// );
// }
