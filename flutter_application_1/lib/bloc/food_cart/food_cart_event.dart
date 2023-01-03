part of 'food_cart_bloc.dart';

abstract class FoodCartEvent extends Equatable{
  const FoodCartEvent();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FoodCartLoaded extends FoodCartEvent{}
class AddFood extends FoodCartEvent{
  final Food food;
  const AddFood(this.food);

  @override
  // TODO: implement props
  List<Object> get props => [food];
}

class RemoveFood extends FoodCartEvent{
  final Food food;
  const RemoveFood(this.food);

  @override
  // TODO: implement props
  List<Object> get props => [food];
}

