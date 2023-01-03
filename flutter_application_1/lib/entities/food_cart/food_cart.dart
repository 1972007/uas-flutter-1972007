import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/entities/food/food.dart';

class FoodCart extends Equatable{
  final Map<Food,int> _foods;
  const FoodCart(this._foods);
  
  void addFood(Food food, {int jml=1}){
    if(_foods.containsKey(food)){
      _foods.update(food, (value) => value+jml);
    }
    else{
      _foods[food] = jml;
    }
  }

  void removeFood(Food food, {int jml=1}){
    if(_foods.containsKey(food)){
      _foods.update(food, (value) => value > 0 ?  value-jml : 0);
    } 
  }
  int totalPrice(){
    int total = 0;
    if (_foods.isNotEmpty) {
      for (var element in _foods.keys) {
        if(_foods[element]!=null && _foods[element]!>0){
          
          total += element.price * _foods[element]!;
        }
      }
    }
    return total;
  }

  int totalValue(){
    int total = 0;
    for (var element in _foods.values){
      total += element;
    }
    return total;
  }

  int getFoodBought(Food food){
    return _foods[food] ?? 0;
  }
  FoodCart clone() => FoodCart(foods);

  Map<Food,int> get foods => {..._foods};
  
  @override
  List<Object> get props => [foods]; 
  Map<String, dynamic> toJson(){
    Map<String, dynamic> map = {};
    for(var key in _foods.keys) {
      log("Json : $map");
      if(_foods[key]! > 0){
        var food = key.toJson()..addAll({"total": _foods[key]});
        log("Food : $food");
        (map).addAll({key.name : food});
      }
    }
    return {"order":map};
  }
}