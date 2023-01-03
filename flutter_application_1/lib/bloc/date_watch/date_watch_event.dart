part of 'date_watch_bloc.dart';

abstract class DateWatchEvent extends Equatable{
  const DateWatchEvent();
  @override
  List<Object> get props => [];
}

class DateWatchLoaded extends DateWatchEvent{}
class DateWatchChose extends DateWatchEvent{
  final DateTime dateTime;
  const DateWatchChose(this.dateTime);

  @override
  // TODO: implement props
  List<Object> get props => [dateTime];
}