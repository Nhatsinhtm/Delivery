
import 'package:delivery/Screen/ChecOut_item_screen/CheckOutMain.dart';
import 'package:delivery/model/DB_helper.dart';

import 'package:delivery/theme/Colors.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//
import '../Common/ListView_Cart.dart';
import '../model/Cart_Provider.dart';
import '../model/Food.dart';


class Cart extends StatefulWidget {
   const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  DBHelper dbHelper = DBHelper();
  List<Foods> foods=[];
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return SafeArea(child: Scaffold(
      backgroundColor: bg,
      appBar:PreferredSize(preferredSize: Size.fromHeight(double.maxFinite), child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('số hàng đã thêm vào giỏ hàng'),
          Text(cart.getCounter().toString()),
          ElevatedButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
             return const CheckOut();
            },));
          }, child: const Text('đặt hàng'))
        ],
      )),
      body: FutureBuilder(
        future:dbHelper.getFoodsList(),
        builder: (context, AsyncSnapshot<List<Foods>>snapshot) {
                   if(snapshot.hasData){

       foods=snapshot.data!;
var sadnashdjas;
       return ListViewCart(foods: foods);
                   } else{
       return  const Center(
           child: CircularProgressIndicator());
                   }
                  },),

    ));
  }
}
