part of 'bottom_nav_main_bloc.dart';

abstract class BottomNavMainEvent extends Equatable{
  const BottomNavMainEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends BottomNavMainEvent{
  @override
  String toString() {
    return "AppStarted";
  }

  @override
  List<Object> get props => [];
}

class PageTapped extends BottomNavMainEvent{
  final int idx;
  const PageTapped({this.idx = 0});

  @override
  String toString() {
    return "PageTapped: $idx";
  }

  @override
  List<Object> get props => [idx];
}