import 'package:delivery/model/Cart_Provider.dart';
import 'package:delivery/model/DB_helper.dart';
import 'package:delivery/model/FoodsPost.dart';
import 'package:delivery/request/fetch_controller.dart';
import 'package:delivery/theme/Colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../model/Food.dart';

class ListCategories extends StatefulWidget {
  ListCategories({super.key, required this.foods});

   List<Foods> foods;

  @override
  State<ListCategories> createState() => ListCategoriesState();
}

class ListCategoriesState extends State<ListCategories> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  DBHelper dbHelper = DBHelper();
  late Foods reFood;
  late Object reId;
  @override
  Widget build(BuildContext context) {

    final cart = Provider.of<CartProvider>(context);
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.foods.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () async {

          reId = (await  context.push(context.namedLocation('DetailScreen'),
                extra: Foods(
                    name: widget.foods[index].name,
                    price: widget.foods[index].price,
                    id: widget.foods[index].id,
                    like: widget.foods[index].like,
                    detail: widget.foods[index].detail,
                    avatar: widget.foods[index].avatar)))!;
          if(reId.toString().isNotEmpty){
            int currentIndex = index;
            int Idresponse = reId as int;
            switch(Idresponse){
              case 1 : widget.foods[currentIndex].like = 1;
              case 0 : widget.foods[currentIndex].like = 0;
            }
          }

          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: SizedBox(
              height: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                    child: Image.network(
                      widget.foods[index].avatar.toString(),
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width * 0.45,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.foods[index].name.toString(),
                          style: const TextStyle(
                              color: textPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        Row(
                          children: [
                            Text(
                                '${widget.foods[index].price.toString().substring(0, 6)} : ',
                                style: const TextStyle(
                                    color: textPrimary, fontSize: 16)),
                            Text(
                                widget.foods[index].price
                                    .toString()
                                    .substring(6),
                                style: const TextStyle(
                                    color: textPrimary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16)),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 40,
                              width: 80,
                              child: ElevatedButton(
                                onPressed: () async {
                                  switch (widget.foods[index].like) {
                                    case 1:
                                      widget.foods[index].like = 0;
                                    case 0:
                                      widget.foods[index].like = 1;
                                  }

                                  // var newFood = FoodsNew(
                                  //     name: widget.foods[index].name,
                                  //     avatar: widget.foods[index].avatar,
                                  //     detail: widget.foods[index].detail,
                                  //     price: widget.foods[index].price,
                                  //     like: false,
                                  //     id: widget.foods[index].id );
                                  // String id= widget.foods[index].id.toString();
                                  // var response =  await postController().upDateData(newFood);
                                  // var response = await postController().putData('/$id', newFood);
                                //   var response = await postController().deleteData('/$id');
                                //   if(response == null){
                                //     return;
                                //   }
                                //   else{
                                //     debugPrint('succesful ');
                                //   }
                               },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                child: ImageIcon(
                                  const AssetImage('assets/Icons/heart.png'),
                                  color: widget.foods[index].like == 0
                                      ? textSecondary
                                      : Colors.red,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                              width: 80,
                              child: ElevatedButton(
                                  onPressed: () {
                                    dbHelper
                                        .insert(Foods(
                                      avatar: widget.foods[index].avatar,
                                      detail: widget.foods[index].detail,
                                      id: widget.foods[index].id,
                                      like: widget.foods[index].like,
                                      price: widget.foods[index].price,
                                      name: widget.foods[index].name,
                                    ))
                                        .then((value) {
                                      cart.addCounter();
                                      showDialog(context: context, builder: (context) {
                                        return const AlertDialog(
                                          title: Text('đã thêm sản phẩm vào giỏ hàng'),
                                        );
                                      },);
                                    }).onError((error, stackTrace) {
                                      showDialog(context: context, builder: (context) {
                                        return const AlertDialog(
                                          title: Text('sản phẩm đã có trong giỏ hàng'),
                                        );
                                      },);
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: primaryButton,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  child: const ImageIcon(
                                    AssetImage('assets/Icons/cart.png'),
                                    color: white,
                                  )),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
