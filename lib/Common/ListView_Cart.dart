import 'package:delivery/model/Cart_Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/DB_helper.dart';
import '../model/Food.dart';

class ListViewCart extends StatefulWidget {
  ListViewCart({super.key, required this.foods});
   List<Foods> foods;
  @override
  State<ListViewCart> createState() => _ListViewCartState();
}

class _ListViewCartState extends State<ListViewCart> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  DBHelper dbHelper = DBHelper();
  @override
  Widget build(BuildContext context) {
    final cart= Provider.of<CartProvider>(context);
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount:widget.foods.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 160,
                  child: Image.network(widget.foods[index].avatar.toString(),
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.foods[index].name.toString()),
                    Text(widget.foods[index].price.toString()),
                    Row(
                      children: [
                        SizedBox(
                          height: 30,
                          child: ElevatedButton(onPressed: () {

                            dbHelper.deleteFoodsList(widget.foods[index].id.toString());
                            cart.removeCounter();
                          },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                            ), child: const Icon(Icons.delete),
                          ),

                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },);;
  }
}
