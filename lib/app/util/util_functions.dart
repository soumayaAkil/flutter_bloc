




 import 'dart:ui';

class UtilFunctions {

  static Color getColor(int rFlag, int status) {
    if (status >= 100) return Color.fromARGB(100, 250, 50, 50);
    //    if ((status & 4L)>0)  return Color.argb(100,50,250,50);
    switch (rFlag) {
      case 0:
        return Color.fromARGB(100, 250, 250, 250);
      case 1:
        return Color(0x00C0FFC0);
      case 2:
        return Color(0x00000080);
      case 3:
        return Color(0x00FFFFFF);
      case 4:
        return Color(0x00FFFFFF);
      case 5:
        return Color.fromARGB(100, 250, 250, 250);
      case 6:
        return Color.fromARGB(100, 200, 200, 200);
      case 7:
        return Color.fromARGB(100, 150, 250, 150);
      case 8:
        return Color.fromARGB(100, 250, 150, 150);
      case 9:
        return Color.fromARGB(100, 250, 50, 50);
    }
    return Color(0x00FFFFFF);
  }

  static String getFormatDate(DateTime date) {
    String year = date.year.toString();
    String month = date.month.toString();
    String day = date.day.toString();
    return
      "${year}/${month.padLeft(2, '0')}/${day.padLeft(2, '0')}";
  }
}