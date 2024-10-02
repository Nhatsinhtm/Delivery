import 'package:delivery/Screen/Categoris_Detail.dart';
import 'package:delivery/model/Food.dart';
import 'package:delivery/theme/Colors.dart';

import 'package:flutter/material.dart';
class GridHome extends StatefulWidget {
   GridHome({super.key,required this.foods});
List<Foods> foods;
  @override
  State<GridHome> createState() => _GridHomeState();
}


class _GridHomeState extends State<GridHome> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: widget.foods.length,
        gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2 ,
            crossAxisSpacing: 25,
            mainAxisSpacing: 25,
            mainAxisExtent: 200
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index)
        => GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return CategoriesDetail(foods: widget.foods,);
            },));
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: border, width: 0.5),
                color: white
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    child: Image.network(widget.foods[index].avatar.toString(),
                      loadingBuilder: (context, child, loadingProgress) {
                       if(loadingProgress == null){
                         return child;
                       }
                       else{
                         return const Center(child:  CircularProgressIndicator());
                       }
                      },
                      height: 135,
                      width: double.maxFinite-1,
                      fit: BoxFit.cover,
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(widget.foods[index].name.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: textPrimary
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, bottom: 8),
                  child: Text('( ${widget.foods.length.toString()} )', style: const TextStyle(color: textSecondary,fontSize: 12),),
                )
              ],
            ),
          ),
        )

    );
  }
}




