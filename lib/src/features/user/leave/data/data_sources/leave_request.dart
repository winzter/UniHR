import 'package:file_picker/file_picker.dart';

class LeaveRequest {
  final String idLeaveType;
  final String leaveType;
  final String? description;
  final DateTime start;
  final DateTime end;
  final int idEmployees;
  final double used;
  final double? quota;
  final double balance;
  final double remaining;
  final int? idManager;
  final int? idManagerGroup;
  final int? isApprove;
  final int isFullDay;
  final int isActive;
  final int? idHoliday;
  final PlatformFile? file;
  final String? managerEmail;

  LeaveRequest({
    required this.idLeaveType,
    required this.leaveType,
    required this.description,
    required this.start,
    required this.end,
    required this.idEmployees,
    required this.used,
    required this.quota,
    required this.balance,
    required this.remaining,
    required this.idManager,
    required this.idManagerGroup,
    required this.isApprove,
    required this.isFullDay,
    required this.isActive,
    required this.idHoliday,
    required this.file,
    required this.managerEmail,
  });
}