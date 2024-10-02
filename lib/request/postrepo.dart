
import 'package:http/http.dart' as http;

class PostRepo{
  Future<http.Response> fetchPost() async{
    final  url= Uri.parse('https://65f955dcdf15145246113ce8.mockapi.io/food');
    final response = await http.get(url);
    return response;

  }
}