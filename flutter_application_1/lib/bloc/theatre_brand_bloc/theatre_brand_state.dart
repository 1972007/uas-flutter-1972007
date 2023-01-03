part of 'theatre_brand_bloc.dart';

abstract class TheatreBrandState extends Equatable{
  const TheatreBrandState();
  @override
  List<Object> get props => [];
}

class TheatreLoading extends TheatreBrandState{}
class TheatreChanged extends TheatreBrandState{
  final String theatre;
  const TheatreChanged({required this.theatre});

  @override
  // TODO: implement props
  List<Object> get props => [theatre];
}