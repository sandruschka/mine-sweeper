import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class Ticker {
  const Ticker();
  Stream<double> tick({required double ticks}) {
    return Stream.periodic(const Duration(milliseconds: 100), (x) {
      return ticks + x + 1;
    });
  }
}

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final Ticker _ticker = const Ticker();
  late StreamSubscription<double>? _tickerSubscription;

  TimerBloc() : super(const TimerInitial(0.0)) {
    on<TimerStarted>(_onStarted);
    on<TimerTicked>(_onTicked);
    on<TimerStop>(_onStop);
    on<TimerReset>(_onReset);
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _onStarted(TimerStarted event, Emitter<TimerState> emit) {
    emit(const TimerRunInProgress(0));

    _tickerSubscription = _ticker.tick(ticks: 0).listen(
          (duration) => add(TimerTicked(duration)),
        );
  }

  void _onTicked(TimerTicked event, Emitter<TimerState> emit) {
    emit(TimerRunInProgress(event.duration / 1000));
  }

  void _onStop(TimerStop event, Emitter<TimerState> emit) {
    _tickerSubscription?.cancel();
  }

  void _onReset(TimerReset event, Emitter<TimerState> emit) {
    emit(const TimerInitial(0.0));
  }
}
