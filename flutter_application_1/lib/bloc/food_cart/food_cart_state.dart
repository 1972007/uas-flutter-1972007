part of 'food_cart_bloc.dart';

abstract class FoodCartState extends Equatable{
  const FoodCartState();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class  FoodCartLoading extends FoodCartState{}
class FoodCartRunning extends FoodCartState{
  final FoodCart foodCart;
  const FoodCartRunning(this.foodCart);

  @override
  // TODO: implement props
  List<Object> get props => [foodCart];
}