import 'package:app_tuner/Settings/settings_state.dart';
import 'package:app_tuner/models/Settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Settings/settings_bloc.dart';
import '../Settings/settings_event.dart';
import '../pitchDetector_lib/pitchup_dart/lib/instrument_type.dart';

class FrequencyForm extends StatefulWidget {
  const FrequencyForm({Key? key}) : super(key: key);
  final defaultFreq = 440.0;
  @override
  State<FrequencyForm> createState() => _FrequencyFormState();
}

class _FrequencyFormState extends State<FrequencyForm> {
  final _formKey = GlobalKey<FormState>();
  final frequencyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
      TunerSettings settings = state.settings;
      InstrumentType instrument = settings.instrumentType;
      double setFrequency = settings.baseFrequency;
      String text = settings.baseFrequency.toString();
      frequencyController.value = frequencyController.value.copyWith(text: text);
      if (state.status == SettingsStatus.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
              child: Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Center(
                    child: Text('Instrument Type'),
                  ),
                  Center(
                     child: DropdownButton<InstrumentType>(
                      value: settings.instrumentType,
                      icon: const Icon(Icons.arrow_downward),
                      items: InstrumentType.values
                          .map((InstrumentType classType) {
                        return DropdownMenuItem<InstrumentType>(
                            value: classType, child: Text(classType.name));
                      }).toList(),
                      onChanged: (value) {
                        // print("onChanged, value = " + value.toString());
                        // instrument = value!;
                        // print("instrument var value : " + instrument.toString());
                        // setState(() {
                        //   value: instrument;
                        // });
                        instrument = value!;
                        TunerSettings settings = TunerSettings(
                            instrumentT: instrument, baseFrequency: setFrequency);
                        context.read<SettingsBloc>().add(SettingsEdited(settings));
                      },
                      )
                  ),
                  const Center(
                    child: Text("A4 Frequency"),
                  ),
                  SizedBox(
                    width: 100,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      controller: frequencyController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Define frequency';
                        } else if (double.tryParse(value) == null) {
                          return 'Not a Number';
                        } else if (double.tryParse(value) == 0.0) {
                          return 'Zero not allowed';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.always,
                      onChanged: (value) {
                        var temp = double.tryParse(value);
                        if(temp != null){
                          TunerSettings settings = TunerSettings(
                              instrumentT: instrument, baseFrequency: temp);
                          context.read<SettingsBloc>().add(SettingsEdited(settings));
                        }
                        // If null, do not save

                      },
                    ),
                  ),
                ]),
          )),
        ],
      );
    });
  }

  @override
  void dispose() {
    frequencyController.dispose();
    super.dispose();
  }
}
