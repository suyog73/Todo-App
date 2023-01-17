class GetDateAndTime {
  List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sept",
    "Oct",
    "Nov",
    "Dec",
  ];

  List<String> weekDays = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];
  DateTime dateTime = DateTime.now();

  String getDate() {
    String date = "";
    String day = dateTime.day.toString();
    String month = months[dateTime.month - 1];
    String year = dateTime.year.toString();
    date = "$day $month, $year";
    return date;
  }

  String getWeekDay() {
    int weekDay = dateTime.weekday;
    return weekDays[weekDay - 1];
  }
}
