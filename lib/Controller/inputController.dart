import 'package:flutter/material.dart';

bool validateDateTime(String input){
  // const dateRegex = "^([0-2][0-9]|(3)[0-1])(\/)(((0)[0-9])|((1)[0-2]))(\/)\d{4}$";
  if(RegExp(r"^(((0)[1-9])|((1)[0-2]))(\/)\d{2}$").hasMatch(input)){
    return true;
  }
  else{
    return false;
  }
}