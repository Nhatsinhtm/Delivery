import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class ItemSelect {
  ItemSelect({

    this.index = 0,
    required this.selectedIcon,
    this.isSelected = false,
     required this.txt,
    required this.txticon,

  });
String txt ,txticon;
  bool isSelected;
  int index;
  IconData selectedIcon;


  static List<ItemSelect> itemSelect = <ItemSelect>[
    ItemSelect(
      selectedIcon: Icons.check,
      txticon:'assets/Icons/walking.png',
      index: 0,
      isSelected: true,
      txt: "I’ll pick it up myself"

    ),
    ItemSelect(
      txticon: 'assets/Icons/bicycle.png',
      selectedIcon: Icons.check,
      index: 1,
      isSelected: false,
      txt: 'By courier'
    ),
    ItemSelect(
      txticon:'assets/Icons/drone.png' ,
      selectedIcon: Icons.check,
      index: 2,
      isSelected: false,
      txt: 'By Drone'
    ),


  ];
}
