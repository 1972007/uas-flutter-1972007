import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/entities/food/food.dart';
import 'package:flutter_application_1/entities/food_cart/food_cart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'food_cart_event.dart';
part 'food_cart_state.dart';

class FoodCartBloc extends Bloc<FoodCartEvent, FoodCartState>{
  FoodCartBloc() : super(FoodCartLoading()){
    on<FoodCartLoaded>((event, emit) {
      emit(const FoodCartRunning(FoodCart({})));
    },);
    on<AddFood>((event, emit) {
      FoodCart foodCart = (state as FoodCartRunning).foodCart.clone();
      foodCart.addFood(event.food);
      emit(FoodCartRunning(foodCart));
    },);
    on<RemoveFood>((event, emit) {
      FoodCart foodCart = (state as FoodCartRunning).foodCart.clone();
      foodCart.removeFood(event.food);
      emit(FoodCartRunning(foodCart));
    },);
  }
}