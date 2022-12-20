part of 'bottom_nav_main_bloc.dart';

abstract class BottomNavMainState extends Equatable{
  const BottomNavMainState();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CurrentIdxChanged extends BottomNavMainState{
  final int currentIdx;
  CurrentIdxChanged({required this.currentIdx});

  @override
  String toString()  => "CurrentIndexChanged to $currentIdx";
  @override
  // TODO: implement props
  List<Object> get props => [currentIdx];

}

class PageLoading extends BottomNavMainState{
  @override
  String toString() => "PageLoading";
}

class FirstPageLoaded extends BottomNavMainState{}
class SecondPageLoaded extends BottomNavMainState{}
class ThirdPageLoaded extends BottomNavMainState{ }