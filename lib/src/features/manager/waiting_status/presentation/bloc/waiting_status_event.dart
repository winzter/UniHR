part of 'waiting_status_bloc.dart';

abstract class WaitingStatusEvent extends Equatable {
  const WaitingStatusEvent();
}

class GetWaitingStatus extends WaitingStatusEvent {
  final String? start;
  final String? end;
  final ProfileEntity managerData;

  GetWaitingStatus(
      {required this.start, required this.end, required this.managerData});

  @override
  List<Object?> get props => [start, end, managerData];
}

class IsApproveLeaveWaitingStatus extends WaitingStatusEvent {
  final List<int> indexes;
  final List<LeaveRequestManager> leaveRequestLists;
  final List<WithdrawLeaveManager> withdrawLeaveRequestLists;
  final List<WithdrawLeaveManager> idLeaveEmployeesWithdraw;
  final int isApprove;
  final String? comment;

  IsApproveLeaveWaitingStatus(
      {required this.indexes,
      required this.idLeaveEmployeesWithdraw,
      required this.leaveRequestLists,
      required this.withdrawLeaveRequestLists,
      required this.isApprove,
      required this.comment});

  @override
  List<Object?> get props => [
        idLeaveEmployeesWithdraw,
        isApprove,
        comment,
        leaveRequestLists,
        withdrawLeaveRequestLists
      ];
}

class IsApprovewithdrawLeaveWaitingStatus extends WaitingStatusEvent {
  final List<int> indexes;
  final List<LeaveRequestManager> leaveRequestLists;
  final List<WithdrawLeaveManager> withdrawLeaveRequestLists;
  final List<WithdrawLeaveManager> idLeaveEmployeesWithdraw;
  final int isApprove;
  final String? comment;

  IsApprovewithdrawLeaveWaitingStatus(
      {required this.indexes,
      required this.idLeaveEmployeesWithdraw,
      required this.leaveRequestLists,
      required this.withdrawLeaveRequestLists,
      required this.isApprove,
      required this.comment});

  @override
  List<Object?> get props => [
        idLeaveEmployeesWithdraw,
        isApprove,
        comment,
        leaveRequestLists,
        withdrawLeaveRequestLists
      ];
}

class IsApproveRequestTimeWaitingStatus extends WaitingStatusEvent {
  final int idManager;
  final List<int> indexes;
  final String type;
  final String commentManagerLV1;
  final String commentManagerLV2;
  final int? isManagerLV1Approve;

  IsApproveRequestTimeWaitingStatus({
    required this.indexes,
    required this.idManager,
    required this.type,
    required this.commentManagerLV1,
    required this.commentManagerLV2,
    required this.isManagerLV1Approve,
  });

  @override
  List<Object?> get props => [
        type,
        commentManagerLV1,
        commentManagerLV2,
        isManagerLV1Approve,
      ];
}

class IsApproveChangeTime extends WaitingStatusEvent {
  final List<int> indexes;
  final int isApprove;
  final int idManager;
  final String commentManager;

  // final List<ChangeTimeSendData> data;

  IsApproveChangeTime({
    required this.indexes,
    required this.isApprove,
    required this.commentManager,
    required this.idManager,
  });

  @override
  List<Object?> get props => [indexes, isApprove, commentManager];
}
