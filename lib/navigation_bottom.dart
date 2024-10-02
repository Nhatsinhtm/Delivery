
import 'package:delivery/model/Cart_Provider.dart';
import 'package:delivery/theme/Colors.dart';
import 'package:badges/badges.dart' as badges;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';



class NavBottom extends StatefulWidget {
   const NavBottom({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;
  @override
  State<NavBottom> createState() => _NavBottomState();
}

class _NavBottomState extends State<NavBottom> {
  int myCurrent=0;

  void _goToBrach(int index){
    widget.navigationShell.goBranch(
        initialLocation: index == widget.navigationShell.currentIndex,
        index
    );
  }
  @override
  Widget build(BuildContext context) {
final cart = Provider.of<CartProvider>(context);
Widget buildNavIcon(IconData iconData ){
  return Material(
    child: badges.Badge(
      position: badges.BadgePosition.custom(bottom: 8,start: 10),
      showBadge: true,
      badgeAnimation: const badges.BadgeAnimation.fade(),
      badgeContent: Text(cart.getCounter().toString()),
      badgeStyle: const badges.BadgeStyle(badgeColor: green),
      child:Icon(iconData),),
  );
}
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: bg,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedItemColor: textSecondary,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: selectViolet,
        currentIndex: myCurrent,
        onTap: (value) {
          setState(() {
            myCurrent=value;
          });
          _goToBrach(myCurrent);
        },
        items:   [
        const BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/Icons/home.png')),label: ''),
          BottomNavigationBarItem(icon:buildNavIcon(Icons.shopping_cart),label: ''),
        const BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/Icons/profile.png')),label: ''),

      ],
      ),
    );
  }

}

