import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part "bottom_nav_main_event.dart";
part 'bottom_nav_main_state.dart';

class BottomNavMainBloc extends Bloc<BottomNavMainEvent,BottomNavMainState>{
  int currentIdx = 0;
  BottomNavMainBloc() : super(PageLoading()){
    on<AppStarted>((event, emit) async {
      emit(FirstPageLoaded());
    });
    on<PageTapped>((event, emit) {
      currentIdx = event.idx;
      emit(CurrentIdxChanged(currentIdx: event.idx));
    });
  }
}