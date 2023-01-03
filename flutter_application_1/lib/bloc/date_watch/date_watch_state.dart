part of 'date_watch_bloc.dart';

abstract class DateWatchState extends Equatable{
  const DateWatchState();

  @override
  List<Object?> get props => [];
}

class DateWatchLoading extends DateWatchState{}
class DateWatchChanged extends DateWatchState{
  final DateTime dateTime;
  const DateWatchChanged({required this.dateTime});
  @override
  // TODO: implement props
  List<Object?> get props => [dateTime];
}