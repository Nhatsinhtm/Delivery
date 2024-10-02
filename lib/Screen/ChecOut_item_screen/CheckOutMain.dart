

import 'package:delivery/Screen/ChecOut_item_screen/Address.dart';
import 'package:delivery/model/SelectList.dart';
import 'package:delivery/theme/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:go_router/go_router.dart';


class CheckOut extends StatefulWidget {
 const CheckOut({super.key });



  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {


bool value =true;
late Object numberCard;

@override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
   List<ItemSelect> itemList = ItemSelect.itemSelect;

String txt = '0123456789876543210';
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        shadowColor: bg,
        title: const Text('Checkout', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
        backgroundColor: bg,
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: SafeArea(
          child: Padding(
            padding:  EdgeInsets.fromLTRB(15, 0, 15, MediaQuery.of(context).size.height*0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //----------------------------------------------------------------PAYMENT METHOD
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Payment method',
                        style: TextStyle(color: textPrimary,
                            fontWeight: FontWeight.bold, fontSize: 22
                        )
                    ),
                    TextButton(onPressed: ()  async {
                      numberCard = (await context.push(context.namedLocation('PaymentMethod')))!;
                      if (numberCard.toString().isNotEmpty){
                       String reNumberCard = numberCard.toString().replaceAll(' ', '');
                        setState(() {
                          txt=reNumberCard;
                        });
                      }
                      else{

                      }
                    }, child: const Text('CHANGE',
                        style: TextStyle(color: selectViolet,
                            fontWeight: FontWeight.bold, fontSize: 15
                        )
                    )
                    )
                  ],
                ),
                Row(
                  children: [
                  const Icon(Icons.payment),
                  const SizedBox(width: 20,),
                  Text('**** **** **** ${txt.substring(12,16)}', style: const TextStyle(color: textSecondary,fontSize: 17),),
                  // Text(txt.substring(9, 13),
                  //   style: TextStyle(color: Colors.grey),
                  // )
                ],),
                //----------------------------------------------------------------- ADDRESS
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Delivery address',
                            style: TextStyle(color: textPrimary,
                                fontWeight: FontWeight.bold, fontSize: 22
                            )
                        ),
                        TextButton(onPressed: ()  {
                         Navigator.push(context,
                             MaterialPageRoute(builder: (context) {
                           return const Address();
                         },));

                        }, child: const Text('CHANGE',
                            style: TextStyle(color: selectViolet,
                                fontWeight: FontWeight.bold,fontSize: 15
                            )
                        )
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          const ImageIcon(AssetImage('assets/Icons/address.png')),
                          const SizedBox(width: 10,),
                          Text(txt, style: const TextStyle(color: textSecondary,fontSize: 17),),

                        ],),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 35),
                      child: Column(
                        children: [
                          Text(txt, style: const TextStyle(color: textSecondary,fontSize: 17),),
                          Text(txt, style: const TextStyle(color: textSecondary,fontSize: 17),),
                          Text(txt, style: const TextStyle(color: textSecondary,fontSize: 17),),
                          Text(txt, style: const TextStyle(color: textSecondary,fontSize: 17),),
                          Text(txt, style: const TextStyle(color: textSecondary,fontSize: 17),),
                        ],
                      ),
                    )
                  ],
                ),
                //---------------------------------------------- --------------------OPTIONS
                Column(

                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Delivery options',
                            style: TextStyle(color: textPrimary,
                                fontWeight: FontWeight.bold, fontSize: 22
                            )
                        ),
                        TextButton(
                            onPressed: () {},
                            child: const Text('CHANGE',
                              style: TextStyle(color: selectViolet,
                                  fontWeight: FontWeight.bold,fontSize: 15
                              ),
                            )
                        )
                      ],
                    ),
                    Column(
                      children: [
                        ItemList(itemSelect: itemList[0], removeAllSelect: () {
                          setRemoveAllSelection(itemList[0]);

                        },),
                        ItemList(itemSelect: itemList[1], removeAllSelect: () {
                          setRemoveAllSelection(itemList[1]);

                        },),
                        ItemList(itemSelect: itemList[2], removeAllSelect: () {
                            setRemoveAllSelection(itemList[2]);
                        },),

                      ],
                    )
                  ],
                ),
                // --------------------------------------------------------------NON-CONTACT-DELIVERY
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Non-contact-delivery',
                            style: TextStyle(color: textPrimary,
                            fontWeight: FontWeight.bold, fontSize: 22
                            )
                        ),
                     AdvancedSwitch(
                       initialValue: value,
                       onChanged: (onchanged) {
                         value=onchanged;
                       },
                       height: 30,
                       width: 75,
                       activeColor: selectBgViolet,
                       inactiveChild: const Text('No'),
                       activeChild:  Padding(
                         padding:  EdgeInsets.only(left:  MediaQuery.of(context).size.width*0.03),
                         child: const Text('Yes',
                           style: TextStyle(
                             color: selectViolet,
                           fontSize: 14,
                           ),),
                       ),
                     )
                      ],
                    )
                  ],
                ),

              ],
            ),
          )
      ),
    );
  }
  void setRemoveAllSelection(ItemSelect? itemData) {
    if (!mounted) return;
    setState(() {
      for (var tab in itemList) {
        tab.isSelected = false;
        if (itemData!.index == tab.index) {
          tab.isSelected = true;
        }
      }
    });
  }
}



class ItemList extends StatefulWidget {
  const ItemList({super.key, required this.itemSelect, required this.removeAllSelect});
final  ItemSelect itemSelect;
final Function()? removeAllSelect;
  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.05,
      child: InkWell(
        onTap:
          widget.removeAllSelect
        ,
        child: Center(
          child: Row(
          mainAxisAlignment:  MainAxisAlignment.spaceBetween,
             crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageIcon(AssetImage(widget.itemSelect.txticon ,
                ),color:widget.itemSelect.isSelected? selectViolet:Colors.black,),
              // Icon(widget.itemSelect.icon,
              //   color:widget.itemSelect.isSelected? selectViolet:Colors.black,),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.6,
                child: Text(widget.itemSelect.txt, style: TextStyle(
                    color: widget.itemSelect.isSelected?selectViolet:textSecondary, fontSize: 17,fontWeight: widget.itemSelect.isSelected?FontWeight.bold:null ),),
              ),
              Icon(widget.itemSelect.isSelected
              ? widget.itemSelect.selectedIcon:null, color:selectViolet,size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
