
import 'package:delivery/model/DB_helper.dart';
import 'package:delivery/model/Food.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier{

  DBHelper dbHelper = DBHelper();
  int _counter = 0;
  int  get counter => _counter;

  double _totalPrice = 0;
  double get totalPrice => _totalPrice;

  late Future<List<Foods>> _food;
  Future<List<Foods>> get food => _food;
  Future<List<Foods>> getData() async{
    _food=dbHelper.getFoodsList();
    return _food;
  }

  Future<void> _setPrefItem () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('cart_item', _counter);
    prefs.setDouble('total_price', _totalPrice);
    notifyListeners();
  }
  Future<void> _getPrefItem () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
   _counter = prefs.getInt('cart_item')??0;
   _totalPrice = prefs.getDouble('total_price')??0.0;
    notifyListeners();
  }

  // ------------------------------ counter
  void addCounter(){
    _counter++;
    _setPrefItem();
    notifyListeners();

  }
  void removeCounter(){
    _counter--;
    _setPrefItem();
    notifyListeners();
  }
  int getCounter(){
    _getPrefItem();
    return _counter;
  }
  //------------------------------------total price

  void addTotalPrice(double price){
    _totalPrice = _totalPrice+ price;
    _setPrefItem();
    notifyListeners();
  }
  void removeTotalPrice(double price){
    _totalPrice = _totalPrice - price;
    notifyListeners();
  }
  double getTotalPrice(){
    _getPrefItem();
    return _totalPrice;
  }
}