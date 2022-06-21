import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension StringExtension on String {
  String get capsFirstLetterOfSentence => '${this[0].toUpperCase()}${substring(1)}';

  String get allInCaps => toUpperCase();

  String get capitalizeFirstLetterOfSentence => split(" ").map((str) => str.capsFirstLetterOfSentence).join(" ");

  String get removeWhiteSpace => replaceAll(" ", "");

  bool get isEmptyString => removeWhiteSpace.isEmpty;

  String get encodedURL => Uri.encodeFull(this);

  bool get isTrue => (this == "1" || toLowerCase() == "t" || toLowerCase() == "true" || toLowerCase() == "y" || toLowerCase() == "yes");

  ///Date Format
  String getCustomDateTimeFormat(String inputFormat, String outputFormat, {bool isCheckPresent = false}) {
    if(this == "" || inputFormat== "" || outputFormat== ""){
      return "";
    }
    DateTime dateTime = getDateTimeObject(inputFormat);
    String value = DateFormat(outputFormat).format(dateTime);
    if(isCheckPresent){
      DateTime _currentDateTime = DateTime.now();
      if(dateTime.year == _currentDateTime.year && dateTime.month == _currentDateTime.month && dateTime.day == _currentDateTime.day){
        value = "Present";
      }
    }
    return value;
  }

  DateTime getDateTimeObject(String inputFormat, {bool utc = false, bool local = false}){
    DateTime _date = DateFormat(inputFormat).parse(this, utc);
    if(local){
      _date = _date.toLocal();
    }
    return _date;
  }

  TimeOfDay getTimeOfDayObject(String inputFormat, {bool utc = false, bool local = false}){
    DateTime _date = getDateTimeObject(inputFormat, utc: utc, local: local);
    return TimeOfDay(hour: _date.hour, minute: _date.minute);
  }

  String getCustomDateTimeFromUTC(String outputFormat){
    if(this != "" && outputFormat != ""){
      try {
        DateTime temp = DateTime.parse(this).toUtc().toLocal();
        return DateFormat(outputFormat).format(temp);
      } catch (e){
        return DateFormat(outputFormat).format(DateTime.now());
      }
    }
    else{
      return "";
    }
  }

}