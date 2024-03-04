class CalculateTimeEntity{
  final double xOT;
  final double? compensateAmountHour;
  final double xOTHoliday;
  final double xWorkingDailyHoliday;
  final double xWorkingMonthlyHoliday;
  final int overlapWorking;
  final bool isInTimeFrame;


  const CalculateTimeEntity({
    required this.xOT,
    required this.compensateAmountHour,
    required this.xOTHoliday,
    required this.xWorkingDailyHoliday,
    required this.xWorkingMonthlyHoliday,
    required this.overlapWorking,
    required this.isInTimeFrame,
  });
}

class Error{
  final bool errorNoon;
  final bool errorOnWorkingTime;
  final bool errorTime;

  const Error({required this.errorNoon,required this.errorOnWorkingTime,required this.errorTime});
}

