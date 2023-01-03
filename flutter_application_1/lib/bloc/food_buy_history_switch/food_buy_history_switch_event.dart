part of 'food_buy_history_switch_bloc.dart';

class FoodBuyHistorySwitchEvent extends Equatable { 
  const FoodBuyHistorySwitchEvent();
  @override 
  List<Object> get props => [];
}

class FoodBuyLoaded extends FoodBuyHistorySwitchEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FoodBuySwitchTapped extends FoodBuyHistorySwitchEvent{
  final String val;
  const FoodBuySwitchTapped(this.val);
  @override
  List<Object> get props => [val];
}