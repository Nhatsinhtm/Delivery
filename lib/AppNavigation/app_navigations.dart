import 'package:delivery/Common/GridView_Home.dart';
import 'package:delivery/Pages/Cart.dart';
import 'package:delivery/Screen/Categoris_Detail.dart';

import 'package:delivery/Screen/Detail_Screen.dart';
import 'package:delivery/Pages/Home.dart';
import 'package:delivery/Pages/Profile.dart';
import 'package:delivery/navigation_bottom.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../Common/ListView_Categories.dart';
import '../Screen/ChecOut_item_screen/Payment_method.dart';
import '../model/Food.dart';

class AppNavigation{
   AppNavigation._();
   static String initR = '/Home';


//    Private navigator key
  static final _foodskey = GlobalKey<ListCategoriesState>();
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _rootNavigatorHome = GlobalKey<NavigatorState>(debugLabel: 'shell Home');
  static final _rootNavigatorCart = GlobalKey<NavigatorState>(debugLabel: 'shell Cart');
  static final _rootNavigatorProfile = GlobalKey<NavigatorState>(debugLabel: 'shell Profile');
//    cấu hình router
static final GoRouter router = GoRouter(
  initialLocation: initR,
  navigatorKey: _rootNavigatorKey,
  routes: <RouteBase>[
  //   NavBottom Route
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return NavBottom(navigationShell: navigationShell);
      },
      branches: <StatefulShellBranch>[
        // Branch Home
        StatefulShellBranch(
            navigatorKey: _rootNavigatorHome,
            routes: [
              GoRoute(path: '/Home',
              name: 'Home',
                builder: (context, state) {
                  return HomePage(key: state.pageKey,);
                },
                routes: [
                  GoRoute(path: 'Categories',
                  name: 'Catagories',
                    builder: (context, state) {
                      return CategoriesDetail(key: state.pageKey,foods:[] ,);
                    },
                  )
                ]
              )
            ]),
        // Branch Cart
        StatefulShellBranch(
            navigatorKey: _rootNavigatorCart,
            routes: [
              GoRoute(path: '/Cart',
              name: 'Cart',
                builder: (context, state) {
                  return Cart(key: state.pageKey,);
                },
              )
            ]),
        // Branch Profile
        StatefulShellBranch(
            navigatorKey: _rootNavigatorProfile,
            routes: [
              GoRoute(path: '/Profile',
              name: 'Profile',
                builder: (context, state) {
                  return  Profile(key: state.pageKey,);
                },
              )
            ]),
      ],),
   GoRoute(path: '/DetailScreen',
   parentNavigatorKey: _rootNavigatorKey,
   name: 'DetailScreen',
     builder: (context, state) {
     final Foods food = state.extra as Foods;
       return DetailItems(foods: food,);
     },
   ),
   GoRoute(path: '/PaymentMethod',
   parentNavigatorKey: _rootNavigatorKey,
   name: 'PaymentMethod',
     builder: (context, state) {
       return Payment(key: state.pageKey,);
     },
   ),

  ],);
}