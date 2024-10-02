
import 'package:delivery/Common/Slide.dart';
import 'package:delivery/Pages/Cart.dart';
import 'package:delivery/model/Cart_Provider.dart';
import 'package:delivery/model/DB_helper.dart';
import 'package:delivery/theme/Colors.dart';


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;



import '../Common/ListView_Categories.dart';
import '../model/Food.dart';

class DetailItems extends StatefulWidget {
   DetailItems({super.key,required this.foods});
Foods foods;
  @override
  State<DetailItems> createState() => _DetailItemsState();
}
DBHelper? dbHelper = DBHelper();
GlobalKey<ListCategoriesState> globalKey = GlobalKey();
class _DetailItemsState extends State<DetailItems> {
  late Foods food;
@override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  int counter =0;
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return SafeArea(
        child: Scaffold(
          backgroundColor: bg,
            body:Stack(
              fit: StackFit.loose,
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: [
                 SlideImage(),
                
                Padding(
                  padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.25),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
                    child: Container(
                      width: double.maxFinite,
                      color: bg,
                      child:  Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20,bottom: 20),
                              child: Text(widget.foods.name.toString(), style:const TextStyle(
                                fontWeight:  FontWeight.bold,
                                fontSize: 20,
                                color: textPrimary,
                              ),),
                            ),
                            const Row(
                              children: [
                                Text('1.10',style: TextStyle(color: textPrimary,fontSize: 16,fontWeight: FontWeight.bold),),
                                Icon(Icons.money_off_sharp,color: textSecondary,),
                                Text('/',style: TextStyle(color: textSecondary),),
                                Text('piece', style: TextStyle(color: textSecondary),)
                              ],
                            ),
                            const Text('~ 150gr/piece',style: TextStyle(color: primaryButton)),
                            const Padding(
                              padding: EdgeInsets.only(top: 20, bottom: 15),
                              child:  Text('Spain',style: TextStyle(color: textPrimary,fontWeight: FontWeight.bold,fontSize: 14) ),
                            ),
                            Text(widget.foods.detail.toString(),style: const TextStyle(color: textSecondary),),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 40,
                                    child: ElevatedButton(onPressed: () {
                                      switch(widget.foods.like){
                                        case 1 : widget.foods.like = 0;
                                        case 0 : widget.foods.like = 1;
                                      }
                                    },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: white,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
                                              side: const BorderSide(
                                                color: border,
                                              )
                                          )
                                      ), child: Image.asset('assets/Icons/heart.png',color: widget.foods.like == 1 ? Colors.red: textPrimary,cacheWidth: 20,),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                    child: ElevatedButton(
                                      onPressed: () {

                                      setState(() {
                                        counter++;
                                      });
                                      dbHelper!.insert(
                                        Foods(avatar: widget.foods.avatar,
                                          detail:  widget.foods.detail,
                                          id:  widget.foods.id,
                                          like: widget.foods.like,
                                          name:  widget.foods.name,
                                          price:  widget.foods.price,
                                        )
                                      ).then((value){

                                        cart.addCounter();
                                        showDialog(context: context, builder: (context) {
                                          return const AlertDialog(
                                            title: Text('đã thêm sản phẩm vào giỏ hàng'),
                                          );
                                        },);
                                      }
                                      ).onError((error,stackTrace)
                                      {
                                        showDialog(context: context, builder: (context) {
                                          return const AlertDialog(
                                            title: Text('sản phẩm đã có trong giỏ hàng'),
                                          );
                                        },);
                                      }
                                      );
                                    },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:primaryButton,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
                                          )

                                      ), child:const Row(

                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(Icons.add_shopping_cart,color: white,size: 20,),
                                          ),
                                          Text('ADD TO CART ', style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: white
                                          ),)
                                        ],
                                      ),),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed: () {

                      Navigator.pop(context,widget.foods.like);
                    }, icon: const Icon(Icons.arrow_back_ios)),
                  ],
                )
              ],
            )
        ));
  }
}


  