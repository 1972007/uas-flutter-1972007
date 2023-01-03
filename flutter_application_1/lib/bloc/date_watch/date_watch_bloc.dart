import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'date_watch_event.dart';
part 'date_watch_state.dart';

class DateWatchBloc extends Bloc<DateWatchEvent, DateWatchState> {
  DateWatchBloc() : super(DateWatchLoading()) {
    on<DateWatchLoaded>((event, emit) {
      emit(DateWatchChanged(dateTime: DateTime.now()));
    });
    on<DateWatchChose>((event, emit) {
      emit(DateWatchChanged(dateTime: event.dateTime));
    });
  }
}
