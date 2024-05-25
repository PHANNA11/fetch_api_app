import 'package:fetch_api_app/model/posts_model.dart';
import 'package:http/http.dart' as http;

class PostsController {
  Future<List<PostsModel>> getAllPosts() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.org/posts'));
    if (response.statusCode == 200) {
      return postsModelFromJson(response.body);
    }
    return [];
  }
}
