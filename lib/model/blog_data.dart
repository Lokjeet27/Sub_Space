import 'package:get/get.dart';

class BlogData extends GetxController {
  // var bloglist2 = <Blogs>[].obs;
  List<Blogs>? blogs;

  BlogData({this.blogs});

  BlogData.fromJson(Map<String, dynamic> json) {
    if (json['blogs'] != null) {
      blogs = <Blogs>[];
      json['blogs'].forEach((v) {
        blogs!.add(new Blogs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.blogs != null) {
      data['blogs'] = this.blogs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Blogs {
  String? id;
  String? imageUrl;
  String? title;
  RxBool? isFavourite;

  Blogs({this.id, this.imageUrl, this.title, this.isFavourite});

  Blogs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['image_url'];
    title = json['title'];
    isFavourite = false.obs;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image_url'] = this.imageUrl;
    data['title'] = this.title;
    return data;
  }
}
