part of 'theatre_chair_bloc.dart';

abstract class TheatreChairState extends Equatable{
  const TheatreChairState();
  @override
  List<Object> get props => [];
}

class ChairLoading extends TheatreChairState{}
class ChairIdxChanged extends TheatreChairState{
  final int idx;
  const ChairIdxChanged({required this.idx});

  @override
  List<Object> get props => [idx];
}