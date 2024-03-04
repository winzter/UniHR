part of 'leave_bloc.dart';

abstract class LeaveEvent extends Equatable {
  const LeaveEvent();
}

class GetLeaveHistoryData extends LeaveEvent {
  final DateTime? year;

  GetLeaveHistoryData({required this.year});
  @override
  List<Object?> get props => [year];
}

class GetAllLeaveData extends LeaveEvent {
  @override
  List<Object?> get props => [];
}

class GetLeaveAvailableEvent extends LeaveEvent {
  final DateTime start;
  final DateTime end;
  const GetLeaveAvailableEvent({
    required this.start,
    required this.end,
  });
  @override
  List<Object?> get props => [start, end];
}

class GetLeaveSettingEvent extends LeaveEvent {
  @override
  List<Object?> get props => [];
}

class DeleteLeaveHistoryData extends LeaveEvent {
  final LeaveHistoryEntity leaveHistory;
  final int index;

  const DeleteLeaveHistoryData({
    required this.leaveHistory,
    required this.index,
  });

  @override
  List<Object?> get props => [leaveHistory, index];
}

class GetDayCannotLeaveData extends LeaveEvent {
  final DateTime start;
  final DateTime end;
  final int idEmp;

  const GetDayCannotLeaveData({
    required this.start,
    required this.end,
    required this.idEmp,
  });

  @override
  List<Object?> get props => [start, end, idEmp];
}

class SendLeaveRequestData extends LeaveEvent {
  final int? idManager;
  final int? idManagerGroup;
  final int? idHoliday;
  final List<HolidayLeaveEntity> holidayLeave;
  final int idEmployees;
  final bool isFullDay;
  final LeaveAvailableEntity leaveType;
  final DateTime startDay;
  final DateTime endDay;
  final String? note;
  final FilePickerResult? file;
  final double used;
  final double remaining;

  final String? managerEmail;
  final BuildContext context;

  const SendLeaveRequestData({
    required this.idManager,
    required this.idManagerGroup,
    required this.idHoliday,
    required this.idEmployees,
    required this.isFullDay,
    required this.leaveType,
    required this.startDay,
    required this.endDay,
    required this.note,
    required this.file,
    required this.used,
    required this.remaining,
    required this.context,
    required this.managerEmail,
    required this.holidayLeave,
  });

  @override
  List<Object?> get props => [
        idManager,
        idEmployees,
        idHoliday,
        isFullDay,
        leaveType,
        startDay,
        endDay,
        note,
        used,
        context,
        holidayLeave,
      ];
}
