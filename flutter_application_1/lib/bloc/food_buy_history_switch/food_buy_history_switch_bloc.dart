import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart'; 

part 'food_buy_history_switch_event.dart';
part 'food_buy_history_switch_state.dart'; 
class FoodBuyHistorySwitchBloc extends Bloc<FoodBuyHistorySwitchEvent, FoodBuyHistorySwitchState> {
  FoodBuyHistorySwitchBloc() : super(FoodBuyStarted()) {
    on<FoodBuyLoaded>((event, emit)  {
      emit(FoodBuyStarted());
    });
    on<FoodBuySwitchTapped>((event, emit) {
      emit(CurrentValChanged(event.val));
    },);
  }
}
