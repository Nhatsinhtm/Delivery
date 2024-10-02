import 'package:delivery/Controller/inputController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:camera/camera.dart';
import 'package:validators/validators.dart';
import 'package:go_router/go_router.dart';

import '../../theme/Colors.dart';
class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
late List<CameraDescription> cameras;
late CameraController cameraController;
  String numberCard='';
  @override
  void initState() {
    // TODO: implement initState
    // startCamera();

    super.initState();

  }
  Future<void> startCamera() async {
    cameras = await availableCameras();
    cameraController = CameraController(
      cameras[0],
    ResolutionPreset.high,
    enableAudio:false,
    );
    await cameraController.initialize().then((value) {
      if(!mounted){
        return ;
      }
      setState(() {

      });
    }).catchError((e){
      print(e);
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    // cameraController.dispose();
    super.dispose();
  }
  TextEditingController textEditingController = TextEditingController();
  bool isDateValidate = false;
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        backgroundColor: bg,
        appBar: AppBar(
          backgroundColor: bg,
          leading: IconButton(onPressed: () {
            Navigator.pop(context,numberCard);
          }, icon: const Icon(Icons.arrow_back_ios))
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               const Padding(
                padding:  EdgeInsets.only(left: 15, bottom: 15),
                child:  Text('Credit / Debit card', style: TextStyle(
                  color: textPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,

                ),),
              ),
              SizedBox(

                height: 300,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset('assets/Images/cart.png',fit: BoxFit.fill,)),
              Center(
                child: IconButton(onPressed: () {

                }, icon: const Icon(Icons.camera)),
              ),


              Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text('Name on Card',style: TextStyle(color: textSecondary, fontSize: 14),),
                  ),
                  _inputName(),
                ],
              ),
              const SizedBox(height: 15,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text('Card number',style: TextStyle(color: textSecondary, fontSize: 14),),
                  ),
                  _inputNumberCard(),
                ],
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width*0.5,
                      child: const Text('Expiry date',style: TextStyle(color: textSecondary, fontSize: 14),),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width*0.5-15,
                      child: const Text('CVC',style: TextStyle(color: textSecondary, fontSize: 14),),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(width: MediaQuery.of(context).size.width*0.5,child: _inputRowDate('Expiry date',textEditingController)),
                  Container(width: MediaQuery.of(context).size.width*0.5,child: _inputRowCVC(textEditingController))
                ],
              ),
              const SizedBox(height:  15,),
              Center(
                child: ElevatedButton(onPressed: () {
                  Navigator.pop(context,numberCard);
                },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 120),
                      backgroundColor:button,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
                      )
                    ),
                    child: const Text('USE THIS CART',style: TextStyle(color: white,fontWeight: FontWeight.bold,),)),
              )
            ],
          ),
        ),
      ),
    );
  }
  Container _inputName(){
return  Container(
    decoration: BoxDecoration(
      border: Border.all(color: textSecondary,),
      borderRadius: BorderRadius.circular(5),
    ),
    margin: const EdgeInsets.symmetric(horizontal: 15),
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: Padding(
      padding: const EdgeInsets.only(top: 8),
      child: TextFormField(
        inputFormatters: [
          LengthLimitingTextInputFormatter(80)],
        maxLengthEnforcement: MaxLengthEnforcement.none,

        style: const TextStyle(fontSize: 15,),
        decoration: const InputDecoration(border:  InputBorder.none,
         hintText: 'Name on card',
          hintStyle: TextStyle(color: textSecondary,fontWeight: FontWeight.w300 ),
         helperMaxLines: 4,
        ),
      ),
    ));
  }
  Container _inputNumberCard(){
    return  Container(
        decoration: BoxDecoration(
          border: Border.all(color: textSecondary,),
          borderRadius: BorderRadius.circular(5),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: TextFormField(
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(16),
              CreditCardInputFormat()
            ],
            onChanged: (value) {
              numberCard=value;
            },
            keyboardType: TextInputType.number,
            style: const TextStyle(fontSize: 15,),
            decoration: const InputDecoration(border:  InputBorder.none,
            hintText: "0000 0000 0000 0000",
            hintStyle: TextStyle(color: textSecondary,fontWeight: FontWeight.w300 ),
            suffixIcon: ImageIcon(AssetImage('assets/Icons/twocircle.png'),color: Colors.deepOrangeAccent,),
            ),
          ),
        ));
  }
  Widget _inputRowDate(String title, TextEditingController controller){
    return  Container(
      height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: isDateValidate? green : textSecondary)  ,
          borderRadius: BorderRadius.circular(5),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 15),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: TextFormField(
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(4),
            DateInputFormat()
          ],
          controller: controller,
          onChanged: (value) {
              if(value.isEmpty){
                setState(() {
                  isDateValidate=false;
                });
              }else{
                final isValid = validateDateTime(value);
                if(isValid){
                  setState(() {
                    isDateValidate = true;
                  });
                }
                else{
                  setState(() {
                    isDateValidate = false;
                  });
                }
              }
            },
          style: const TextStyle(fontSize: 15,),
          decoration:   const InputDecoration(
            hintText: "MM/YY",
              hintStyle: TextStyle(color: textSecondary,fontWeight: FontWeight.w300 ),

              border:  InputBorder.none),
        ));
  }
  Widget _inputRowCVC(TextEditingController controller){
    return  Container(
      height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: textSecondary,),
          borderRadius: BorderRadius.circular(5),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 15,),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: TextFormField(

            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(3)
            ],
            style: const TextStyle(fontSize: 15,),
            decoration: const InputDecoration(border:  InputBorder.none,
            hintText: "CVC",
              hintStyle: TextStyle(color: textSecondary,fontWeight: FontWeight.w300 ),
            suffixIcon: Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Icon(Icons.account_balance_wallet,),
            ),

            ),
          ),
        ));
  }

}
class CreditCardInputFormat extends TextInputFormatter{
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {

    if(newValue.selection.baseOffset == 0){
      return newValue;
    }


    String enteredData= newValue.text;
    StringBuffer buffer = StringBuffer();
    for(int i =0 ;i < enteredData.length; i++){
      buffer.write(enteredData[i]);
      int index =i+1;
      if(index % 4 == 0 && enteredData.length!= index ){
        buffer.write(" ");
      }
    }
    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.toString().length),
    );
  }

}
class DateInputFormat extends TextInputFormatter{
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {

    if(newValue.selection.baseOffset == 0){
      return newValue;
    }
    String enteredData= newValue.text;
    StringBuffer buffer = StringBuffer();
    for(int i =0 ;i < enteredData.length; i++){
      buffer.write(enteredData[i]);
      int index =i+1;
      if(index % 2 == 0 && enteredData.length!= index ){
        buffer.write("/");
      }
    }
    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.toString().length),
    );
  }

}

