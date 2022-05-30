import 'package:app_tuner/Tuner/tuner_display.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

abstract class TunerEvent extends Equatable {
  const TunerEvent();
  @override
  List<Object> get props => [];
}

class TunerSubscriptionRequested extends TunerEvent {
  const TunerSubscriptionRequested();
}

class TunerPermissionRequested extends TunerEvent {
  const TunerPermissionRequested();
}

class TunerStarted extends TunerEvent {
  late BuildContext context;
  TunerStarted(BuildContext context) {
    this.context = context;
  }
}

class TunerStopped extends TunerEvent {
  TunerStopped();
}

class TunerPitchRefreshed extends TunerEvent {
  const TunerPitchRefreshed(this.tracePitch);
  final List<double> tracePitch;
}

class TunerDisplayRefreshed extends TunerEvent{
  const TunerDisplayRefreshed(this.tunerDisplay);
  final TunerDisplay tunerDisplay;
}
