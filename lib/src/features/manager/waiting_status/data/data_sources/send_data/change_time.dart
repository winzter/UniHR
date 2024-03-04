class ChangeTimeSendData {
  final int approveBy;
  final String? approveComment;
  final DateTime? approveDate;
  final String? approveDateText = "Invalid Date";
  final DateTime createDate;
  final String? departmentName;
  final int? idHoliday;
  final dynamic fillInApprove;
  final dynamic fillInChange;
  final String firstname_TH;
  final String? holidayName;
  final int idEmployeeShiftDaily;
  final int idEmployees;
  final int idShift;
  final int idShiftGroup;
  final int idShiftType;
  final int isActive;
  final int isApprove;
  final int isWorkingDay;
  final String lastname_TH;
  final String? positionName;
  final String? shiftGroupName;
  final DateTime workingDate;
  final String workingDateText;

  ChangeTimeSendData({
    required this.approveBy,
    required this.approveComment,
    required this.approveDate,
    required this.createDate,
    required this.departmentName,
    required this.fillInApprove,
    required this.fillInChange,
    required this.firstname_TH,
    required this.idHoliday,
    required this.holidayName,
    required this.idEmployeeShiftDaily,
    required this.idEmployees,
    required this.idShift,
    required this.idShiftGroup,
    required this.idShiftType,
    required this.isActive,
    required this.isApprove,
    required this.isWorkingDay,
    required this.lastname_TH,
    required this.positionName,
    required this.shiftGroupName,
    required this.workingDate,
    required this.workingDateText,
  });
}
