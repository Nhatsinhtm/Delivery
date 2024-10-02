import 'dart:ui';

import 'package:delivery/Pages/Home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {

  bool isVisible = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(

        children: [
          Container(
            decoration: const BoxDecoration(color:Color.fromARGB(255, 184, 162, 227)),
          ),
          Image.asset('assets/Logos/bg.png'),
          Positioned(
              height: 70,
              width: 70,
              top: 60,
              child: Image.asset('assets/Logos/logo.png')),
          Padding(
            padding: const EdgeInsets.only(top: 342),
            child: Visibility(

              visible: isVisible,
              child: Container(
                width: double.maxFinite,
                color: Colors.white,
                child: Column(
                    children: [
                      Image.asset('assets/Icons/box.png'),
                      const SizedBox(height: 20,),
                      const SizedBox(
                        width: 100,
                        child: Text('Non-Contact Deliveries',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight:FontWeight.bold,fontSize: 15 ),),
                      ),
                      const Text('When placing an order, '
                          'select the option “Contactless delivery” and '
                          'the courier will leave your order at the door',
                      textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: ElevatedButton(onPressed: () {
                          Navigator.push(context,   MaterialPageRoute(builder: (context) {
                            return const HomePage();
                          },));
                        },

                        style: ElevatedButton.styleFrom(

                          backgroundColor: Colors.lightGreen
                        ), child: const SizedBox(

                              width: double.maxFinite,
                              child: Text('order now',textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                              )),
                        ),
                      ),
                      ElevatedButton(onPressed: () {
                        setState(() {
                          isVisible=!isVisible;
                        });
                      }, child: const Text('dismiss')),

                                ],
                              ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

