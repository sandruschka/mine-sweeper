part of 'timer_bloc.dart';

@immutable
class TimerState extends Equatable {
  final double duration;

  const TimerState(this.duration);

  TimerState copyWith({
    double? duration,
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
  const TimerRunInProgress(double duration) : super(duration);
}
