import 'package:flutter/material.dart';

class Address extends StatefulWidget {
  const Address({super.key});

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Column(
        children: [
          Container(
              height: 30,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black54,),
                borderRadius: BorderRadius.circular(5),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.only(left: 15 , bottom: 15),
              child: TextFormField(
                style: const TextStyle(fontSize: 12,),
                decoration: const InputDecoration(border:  InputBorder.none),
              ))

        ],
      ),
    ));
  }
  Container _inputName(){
    return  Container(
        height: 30,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black54,),
          borderRadius: BorderRadius.circular(5),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 15),
        padding: const EdgeInsets.all(15),
        child: TextFormField(
          style: const TextStyle(fontSize: 12,),
          decoration: const InputDecoration(border:  InputBorder.none),
        ));
  }
}
