

import 'package:app_tuner/Tuner/TunerPage.dart';

class TunerDisplay{
  TunerDisplay(String? ins, double? freq, String? playedNote,double? newTrace,String? statu){
    instruction = ins ?? instruction;
    frequency = freq ?? frequency;
    note = playedNote ?? note;
    newDif = newTrace ?? newDif;
    status3 = statu ?? status3;

  }
  TunerDisplay.initial(){
    instruction = "Click Start";
    frequency = 0;
    note = "";
    newDif = 0;
    status3 = "Click Start";
  }
  String instruction = "";
  double frequency = 0;
  String note = "";
  double newDif= 0;
  String status3 = "";
}