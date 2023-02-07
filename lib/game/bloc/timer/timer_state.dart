part of 'timer_bloc.dart';

@immutable
class TimerState extends Equatable {
  final int duration;

  const TimerState(this.duration);

  TimerState copyWith({
    int? duration,
  }) {
    return TimerState(duration ?? this.duration);
  }

  @override
  List<Object?> get props => [duration];
}

class TimerInitial extends TimerState {
  const TimerInitial(duration) : super(duration);
}

class TimerRunInProgress extends TimerState {
  const TimerRunInProgress(int duration) : super(duration);
}
