import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

abstract class TunerEvent extends Equatable {
  const TunerEvent();
  @override
  List<Object> get props => [];
}

// TODO : Add potential events
class TunerSubscriptionRequested extends TunerEvent {
  const TunerSubscriptionRequested();
}

class TunerPermissionRequested extends TunerEvent {
  late BuildContext context;
  TunerPermissionRequested(BuildContext context) : this.context = context;
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

class TunerRefresh extends TunerEvent {
  const TunerRefresh();
}
