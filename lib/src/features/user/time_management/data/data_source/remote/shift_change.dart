class ShiftChange {
  final int idEmployees;
  final int idShift;
  final int idShiftType;
  final DateTime workingDate;
  final int idShiftGroup;
  final int isWorkingDay;
  final int? idHoliday;

  ShiftChange({
    required this.idEmployees,
    required  this.idShift,
    required  this.idShiftType,
    required  this.workingDate,
    required  this.idShiftGroup,
    required  this.isWorkingDay,
    required this.idHoliday,
  });
}
