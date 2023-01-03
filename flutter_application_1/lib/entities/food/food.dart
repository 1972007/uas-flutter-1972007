import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'food.g.dart';

@JsonSerializable()
class Food extends Equatable{
  final String name;
  final int id;
  final int price;
  final String desc;
  final String linkImg;
  const Food({required this.id, required this.name, required this.price, required this.linkImg, this.desc = "Lorem ipsum dolor sit amet"});

  factory Food.fromJson(Map<String, dynamic> json) => _$FoodFromJson(json);
  Map<String, dynamic> toJson() =>_$FoodToJson(this);
  @override
  String toString() {
    return "Food(name:$name; id:$id; price:$price; desc:$desc; linkImg:$linkImg)";
  }
  
  @override
  List<Object> get props => [name, id, price, desc, linkImg];
  
  
}