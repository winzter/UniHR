class CalculateTimeEntity{
  final int xOT;
  final int xOTHoliday;
  final int xWorkingDailyHoliday;
  final int xWorkingMonthlyHoliday;
  final int overlapWorking;

  const CalculateTimeEntity({required this.xOT,
    required this.xOTHoliday,
    required this.xWorkingDailyHoliday,
    required this.xWorkingMonthlyHoliday,
    required this.overlapWorking});
}

class Error{
  final bool errorNoon;
  final bool errorOnWorkingTime;
  final bool errorTime;

  const Error({required this.errorNoon,required this.errorOnWorkingTime,required this.errorTime});
}

