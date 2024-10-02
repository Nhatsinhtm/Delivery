import 'package:delivery/AppNavigation/app_navigations.dart';

import 'package:delivery/model/Cart_Provider.dart';



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


Future<void> main() async {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => CartProvider(),
        child: Builder(builder: (context) {
          return MaterialApp.router(
            theme: ThemeData(
            ),
            debugShowCheckedModeBanner: false,
           routerConfig: AppNavigation.router,

          );
        }
        )
    );
  }

}
