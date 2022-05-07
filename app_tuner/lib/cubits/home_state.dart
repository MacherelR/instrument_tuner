part of 'home_cubit.dart';

enum HomeTab { tuner, stats, settings }

class HomeState {
  const HomeState({this.tab = HomeTab.tuner});
  final HomeTab tab;

  @override
  List<Object> get props => [tab];
}
