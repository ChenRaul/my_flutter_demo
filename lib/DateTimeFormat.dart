class DateTimeFormat{

  //格式化日期。// yyyy-MM-dd HH:mm:ss
  static String getFormatDate(String date){
    DateTime d = DateTime.parse(date);
    //日期格式化
    return '${d.year}-${d.month.toString().padLeft(2,'0')}-${d.day.toString().padLeft(2,'0')} ${d.hour.toString().padLeft(2,'0')}:${d.minute.toString().padLeft(2,'0')}:${d.second.toString().padLeft(2,'0')}';

  }

}