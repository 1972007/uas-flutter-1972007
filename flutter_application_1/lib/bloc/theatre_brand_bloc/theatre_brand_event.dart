part of 'theatre_brand_bloc.dart';

abstract class TheatreBrandEvent extends Equatable{
  const TheatreBrandEvent();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class TheatreLoaded extends TheatreBrandEvent{
  @override
  List<Object> get props => [];
}

class TheatreChose extends TheatreBrandEvent{
  final String theatre;
  const TheatreChose({required this.theatre});
  @override
  // TODO: implement props
  List<Object> get props => [theatre];
}