String convertDateTimeToString(DateTime dateTime) {
//year in foremat yyyy
  String year = dateTime.year.toString();

  //month in foremat mm
  String month = dateTime.month.toString();
  if (month.length == 1) {
    month = "0$month";
  }

  //day in foremat dd
  String day = dateTime.day.toString();
  if (day.length == 1) {
    day = "0$day";
  }
  String ddmmyyyy = "$day/$month/$year";

  return ddmmyyyy;
}
