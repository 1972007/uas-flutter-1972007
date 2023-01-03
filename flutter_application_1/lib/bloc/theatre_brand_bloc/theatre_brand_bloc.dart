import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'theatre_brand_event.dart';
part 'theatre_brand_state.dart';

//List<String> theatres = ["XXI", "CGV", "Cinepolis", "Movimax", "Indiskop"];
  
class TheatreBrandBloc extends Bloc<TheatreBrandEvent, TheatreBrandState> {
  TheatreBrandBloc() : super(TheatreLoading()) {
    on<TheatreLoaded>((event, emit) {
      emit(const TheatreChanged(theatre: "Select"));
    });
    on<TheatreChose>((event, emit) {
      emit(TheatreChanged(theatre: event.theatre));
    });
  }
}
