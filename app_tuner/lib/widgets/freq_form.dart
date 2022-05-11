import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FrequencyForm extends StatefulWidget {
  const FrequencyForm({Key? key}) : super(key: key);
  final defaultFreq = 440.0;
  @override
  State<FrequencyForm> createState() => _FrequencyFormState();
}

class _FrequencyFormState extends State<FrequencyForm> {
  final _formKey = GlobalKey<FormState>();
  final defaultFrequency = 440.0;
  final frequencyController = TextEditingController(text: '440.0');
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
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
              ),
            ),
          ],
        ));
  }

  @override
  void dispose() {
    frequencyController.dispose();
    super.dispose();
  }
}
