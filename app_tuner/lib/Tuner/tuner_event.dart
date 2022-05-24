import 'package:equatable/equatable.dart';

abstract class TunerEvent extends Equatable{
  const TunerEvent();
  @override
  List<Object> get props => [];
}

// TODO : Add potential events
class TunerSubscriptionRequested extends TunerEvent{
  const TunerSubscriptionRequested();
}

class TunerPermissionRequested extends TunerEvent{
  const TunerPermissionRequested();
}

class TunerStarted extends TunerEvent{
  const TunerStarted();
}

class TunerStopped extends TunerEvent{
  const TunerStopped();
}

class TunerRefresh extends TunerEvent{
  const TunerRefresh();
}

