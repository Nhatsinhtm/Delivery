import 'package:delivery/Common/ListView_Categories.dart';
import 'package:delivery/theme/Colors.dart';
import 'package:flutter/material.dart';


import '../model/Food.dart';


class CategoriesDetail extends StatefulWidget {
  CategoriesDetail({super.key, required this.foods});

  List<Foods> foods;

  @override
  State<CategoriesDetail> createState() => _CategoriesDetailState();
}

class _CategoriesDetailState extends State<CategoriesDetail> {
  int myCurrent = 0;
  List<Foods> foodUpdate = [];

  @override
  void initState() {
    // TODO: implement initState

    widget.foods.sort(
      (a, b) => a.name!.compareTo(b.name.toString()),
    );
    foodUpdate = widget.foods;

    super.initState();
  }

  void searchFoods(String value) {
    List<Foods> result = [];
    if (value.isEmpty) {
      result = widget.foods;
    } else {
      result = widget.foods
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
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            toolbarHeight: 70,
            leading: IconButton(onPressed: () {
              Navigator.pop(context);
            }, icon: const Icon(Icons.arrow_back_ios)),
            backgroundColor: const Color.fromARGB(0, 0, 0, 0),
            shadowColor: const Color.fromARGB(0, 000, 0, 0),
            surfaceTintColor: const Color.fromARGB(0, 0, 0, 0),
          ),
          body:  Stack(children: [
            Positioned(
              top: MediaQuery.of(context).size.height * -0.2,
              left: MediaQuery.of(context).size.width * 0.2,
              child: Image.asset('assets/Icons/vegetables.png'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 70),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding:  const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.foods[1].name.toString(),
                        style: const TextStyle(
                            color: textPrimary,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        onChanged: (value) {
                          searchFoods(value);
                        },
                        decoration: InputDecoration(
                            filled: true,
                            prefixIcon: const Icon(Icons.search),
                            hintText: 'search',
                            fillColor: white,
                            hintStyle:
                            const TextStyle(fontSize: 14, color: textSecondary),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: border, width: 2),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide:
                                const BorderSide(color: selectBgViolet, width: 2))),
                      ),
                      ListCategories(foods: foodUpdate),
                      // ListCategories(foods:foodUpdate,)
                    ],
                  ),
                ),
              ),
            ),
      
          ]),
      ),
    );
  }

}

