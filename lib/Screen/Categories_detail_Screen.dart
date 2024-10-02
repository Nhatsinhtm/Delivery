import 'package:flutter/material.dart';

import '../Common/ListView_Categories.dart';
import '../model/Food.dart';
import '../theme/Colors.dart';

class CategoriesDetail extends StatefulWidget {
   CategoriesDetail({super.key, required this.foods});
List<Foods> foods;
  @override
  State<CategoriesDetail> createState() => _CategoriesDetailState();
}

class _CategoriesDetailState extends State<CategoriesDetail> {
  List<Foods> foodUpdate =[];
  void searchFoods (String value){
    List <Foods>result = [];
    if(value.isEmpty){
      result = widget.foods;
    }else{
      result=widget.foods.where((element) => element.name!.toLowerCase().contains(value.toLowerCase())).toList();
    }
    setState(() {
      foodUpdate=result;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: bg,
      child: Stack(
          children: [
            Positioned(child: Image.asset('assets/Icons/vegetables.png'),
              top: MediaQuery.of(context).size.height*-0.2,
              left: MediaQuery.of(context).size.width*0.2,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10,),
                    Text(widget.foods[1].name.toString(),style: const TextStyle(color: textPrimary,fontSize: 30,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 20,),
                    SizedBox(
                      height: 38,
                      width: MediaQuery.of(context).size.width*0.9,
                      child: TextField(
                        onChanged: (value)=> searchFoods(value),
                        decoration: InputDecoration(
                          filled: true,
                          prefixIcon: const Icon(Icons.search),
                          hintText: 'search',
                          fillColor: white,

                          hintStyle: const TextStyle(fontSize: 14),
                          border:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide:  const BorderSide(color: Colors.blueAccent),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListCategories(foods: foodUpdate)
                    // ListCategories(foods:foodUpdate,)
                  ],
                ),
              ),
            ),

          ]
      ),
    );
  }
}
