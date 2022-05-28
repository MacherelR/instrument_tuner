// import 'package:app_tuner/models/Settings.dart';
// import 'package:flutter/material.dart';
// import 'package:pitchupdart/instrument_type.dart';

// import '../Blocs/settings_bloc.dart';

// class SettingsForm extends StatelessWidget {
//   const SettingsForm({Key? key, required this.settings}) : super(key: key);
//   final TunerSettings settings;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: <Widget>[
//         Text('Instrument Type'),
//         DropdownButton<InstrumentType>(
//           value: settings.instrumentType,
//           icon: const Icon(Icons.arrow_downward),
//           items: InstrumentType.values.map((InstrumentType classType) {
//             return DropdownMenuItem<InstrumentType>(
//               value: classType,
//               child: Text(classType.toString()));
//           }).toList(),
//           onChanged: (value) {
//             context.bloc<SettingsBloc>().add(
//               SettingsEdited(
//         ),

//       ],
//     )
//   }
// }
