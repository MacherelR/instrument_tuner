import 'package:app_tuner/cubits/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Settings/SettingsPage.dart';
import 'StatsPage.dart';
import '../Tuner/TunerPage.dart';
import '../Tuner/TunerPage_2.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String route = "/home";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((HomeCubit cubit) => cubit.state.tab);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instrument tuner'),
      ),
      body: selectedTab == HomeTab.tuner
          ? const TunerScreen()
          : selectedTab == HomeTab.stats
              ? const StatsScreen()
              : const SettingsScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: HomeTab.values.indexOf(selectedTab),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.tune), label: 'Tuner'),
          BottomNavigationBarItem(
              icon: Icon(Icons.insert_chart), label: 'Stats'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
        onTap: (index) {
          context.read<HomeCubit>().setTab(HomeTab.values[index]);
        },
      ),
    );
  }
}
