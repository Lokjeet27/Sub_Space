import 'package:get/get.dart';
import 'package:sub_space/model/blog_data.dart';
import 'package:sub_space/repository/blog_fetch.dart';

class BlocDetailsController extends GetxController {
  var blogList = <Blogs>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    getDataToList();
  }

  Future<void> getDataToList() async {
    try {
      isLoading.value = true;
      var data = await BlogFetch().fetchBlogs();
      blogList.value = data;
      update();
    } finally {
      isLoading.value = false;
      print(blogList);
    }
  }
}
