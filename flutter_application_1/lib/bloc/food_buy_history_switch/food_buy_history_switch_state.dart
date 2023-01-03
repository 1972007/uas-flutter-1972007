part of 'food_buy_history_switch_bloc.dart';
 
class FoodBuyHistorySwitchState extends Equatable { 
  const FoodBuyHistorySwitchState();
  @override
  List<Object?> get props => [];
}
class FoodBuyStarted extends FoodBuyHistorySwitchState{}
class CurrentValChanged extends FoodBuyHistorySwitchState{
  
  final String val;
  const CurrentValChanged(this.val);
  @override
  List<Object> get props => [val];
}