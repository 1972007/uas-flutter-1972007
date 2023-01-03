import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/bloc/bottom_nav_main/bottom_nav_main_bloc.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'theatre_chair_event.dart';
part 'theatre_chair_state.dart';

class TheatreChairBloc extends Bloc<TheatreChairEvent, TheatreChairState> {
  TheatreChairBloc() : super(ChairLoading()) {
    on<ChairLoaded>((event, emit) {
      emit(ChairLoading());
      // TODO: implement event handler
    });
    on<ChairTapped>((event, emit) {
      emit(ChairIdxChanged(idx: event.idx));
    },);
  }
}
