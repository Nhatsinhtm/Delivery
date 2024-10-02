import 'dart:convert';

import 'package:delivery/Common/GridView_Home.dart';

import 'package:delivery/theme/Colors.dart';
import 'package:flutter/material.dart';

import '../model/Food.dart';
import '../request/postrepo.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  var _data;

  @override
  void initState() {
    // TODO: implement initState
   _data = getData();
    foodUpdate=foods;
    super.initState();

  }

List<Foods> foods = [];

List<Foods> foodUpdate = [];

  final postRepo = PostRepo();
  Future<List<Foods>> getData() async{
    final response = await postRepo.fetchPost();
    final data = jsonDecode(response.body);
    for(dynamic data in data){
      foods.add(Foods.fromJson(data));
    }
    return foods;
  }

  void searchFoods(String value) {
    List<Foods> result = [];
    if (value.isEmpty) {
      result = foods;
    } else {
      result = foods
          .where((element) =>
          element.name!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    }
    setState(() {
      foodUpdate = result;
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: bg,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          color: bg,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const Text('Categories',style: TextStyle(color: textPrimary,
                fontSize: 34
                ),),
                const SizedBox(height: 40,),
                SizedBox(
                  height: 50,
                  child: TextField(
                    onChanged: (value) {
                      searchFoods(value);
                    },
                    decoration: InputDecoration(
                        filled: true,
                        prefixIcon: const Icon(Icons.search),
                        hintText: 'search',
                        fillColor: white,
                        hintStyle:  const TextStyle(fontSize: 14,color: textSecondary),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color:border, width: 2),
                          borderRadius: BorderRadius.circular(50),
                        ),
                       focusedBorder: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(50),
                         borderSide: const BorderSide(color: selectBgViolet,width: 2)
                       )
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                 

                 FutureBuilder(
                   future:_data,
                   builder: (context, snapshot) {
                    if (snapshot.hasData){
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: GridHome(foods: foodUpdate),
                      );
                    }
                    else {
                      return  const Center(
                          child: CircularProgressIndicator());
                    }
                   },
                 ),
              ],
            ),
          ),
        ),
      ),
    ));

  }
}
