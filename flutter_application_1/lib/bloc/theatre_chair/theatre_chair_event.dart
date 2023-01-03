part of 'theatre_chair_bloc.dart';

abstract class TheatreChairEvent extends Equatable{
  const TheatreChairEvent();

  @override
  List<Object> get props => [];
}
class ChairLoaded extends TheatreChairEvent{
  @override
  List<Object> get props => [];
}
class ChairTapped extends TheatreChairEvent{
  final int idx;
  const ChairTapped({this.idx=0});

  @override
  List<Object> get props => [idx];
}