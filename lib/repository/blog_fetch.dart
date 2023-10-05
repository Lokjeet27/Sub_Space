import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sub_space/model/blog_data.dart';

class BlogFetch extends GetxController {
  List<dynamic>? datalist;
  Future fetchBlogs() async {
    const String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
    const String adminSecret =
        '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'x-hasura-admin-secret': adminSecret,
      });

      if (response.statusCode == 200) {
        // Request successful, handle the response data here
        print('Response data: ${response.body}');
        var jsonRespone = jsonDecode(response.body);
        datalist = jsonRespone!["blogs"];
        return datalist?.map((e) => Blogs.fromJson(e)).toList();
      } else {
        // Request failed
        print('Request failed with status code: ${response.statusCode}');
        print('Response data: ${response.body}');
        throw Exception("Unexpected error occurred");
      }
    } catch (e) {
      // Handle any errors that occurred during the request
      print('Error: $e');

      throw e;
    }
  }
}

// class Failure {
//   final String message;
//   Failure({required this.message});
//   String toString() => message;
// }
