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