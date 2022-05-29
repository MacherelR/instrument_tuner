import 'package:app_tuner/Tuner/tuner_bloc.dart';
import 'package:app_tuner/Tuner/tuner_event.dart';
import 'package:app_tuner/Tuner/tuner_state.dart';
import 'package:app_tuner/repository/tuner_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/tunerView.dart';

class TunerScreen extends StatelessWidget{
  const TunerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return BlocProvider(
        create: (context) => TunerBloc(
          tunerRepository: context.read<TunerRepository>(),
        )..add(const TunerSubscriptionRequested()),
        child: const TunerView(),
    );
  }
}

class TunerView extends StatelessWidget{
  const TunerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context){

    return BlocBuilder<TunerBloc, TunerState>(builder: (context,state){
      Size size = MediaQuery.of(context).size;
      return SizedBox(
        height: size.height,
        width: size.width,
        child: TunerViewWidget(),
      );
    });
  }


}
