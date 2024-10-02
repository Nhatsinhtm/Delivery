import 'dart:convert';
import 'package:delivery/model/Food.dart';
import 'package:delivery/request/postrepo.dart';
import 'package:http/http.dart' as http;
class postController{
String baseUrl = 'https://65f955dcdf15145246113ce8.mockapi.io/food';
  final postRepo = PostRepo();
  Future<List<Foods>> getData() async{
    final response = await postRepo.fetchPost();

    List<Foods> dataPost = [];
    final data = jsonDecode(response.body);

    for(dynamic data in data){
      dataPost.add(Foods.fromJson(data));
    }
    return dataPost;
  }
  Future<dynamic> upDateData(dynamic object) async{
    final  url= Uri.parse('https://65f955dcdf15145246113ce8.mockapi.io/food');
    var _payload = json.encode(object);
    final response = await http.post(url,body: _payload);
    if(response.statusCode == 201){
      return response.body;
    }
    else{

    }
  }
  Future<dynamic> putData(String id ,dynamic object) async{
    final  url= Uri.parse(baseUrl+id);
    var payLoad = json.encode(object);
    final response = await http.put(url,body: payLoad);
    if(response.statusCode == 200){
      return response.body;
    }
    else{

    }
  }
  Future<dynamic> deleteData(String id ) async{
    final  url= Uri.parse(baseUrl+id);
    final response = await http.put(url);
    if(response.statusCode == 200){
      return response.body;
    }
    else{

    }
  }

}