part of 'waiting_status_bloc.dart';

abstract class WaitingStatusState extends Equatable {
  final List<ChangeTimeManager> changeTimeData;
  final List<RequestTimeManager> requestTimeData;
  final List<LeaveRequestManager> leaveRequestData;
  final List<LeaveRequestManager> leaveNotApproveData;
  final List<WithdrawLeaveManager> withdrawLeaveData;
  final List<WithdrawLeaveManager> withdrawNotLeaveData;
  final PayrollSettingEntity? payrollSetting;
  final List<RequestTimeManager> dataOt;
  final List<RequestTimeManager> dataNotApproveOt;
  final List<RequestTimeManager> dataRequestTime;
  final List<RequestTimeManager> dataNotApproveRequestTime;

  const WaitingStatusState({
    required this.withdrawNotLeaveData,
    required this.changeTimeData,
    required this.requestTimeData,
    required this.leaveRequestData,
    required this.leaveNotApproveData,
    required this.withdrawLeaveData,
    required this.payrollSetting,
    required this.dataOt,
    required this.dataNotApproveOt,
    required this.dataRequestTime,
    required this.dataNotApproveRequestTime,
  });
}

class WaitingStatusInitial extends WaitingStatusState {
  WaitingStatusInitial(
      {required super.withdrawNotLeaveData,
      required super.changeTimeData,
      required super.requestTimeData,
      required super.leaveRequestData,
      required super.leaveNotApproveData,
      required super.withdrawLeaveData,
      required super.payrollSetting,
      required super.dataOt,
      required super.dataNotApproveOt,
      required super.dataRequestTime,
      required super.dataNotApproveRequestTime});

  @override
  List<Object> get props => [];
}

class WaitingStatusLoaded extends WaitingStatusState {
  WaitingStatusLoaded(
      {required super.withdrawNotLeaveData,
      required super.changeTimeData,
      required super.requestTimeData,
      required super.leaveRequestData,
      required super.leaveNotApproveData,
      required super.withdrawLeaveData,
      required super.payrollSetting,
      required super.dataOt,
      required super.dataNotApproveOt,
      required super.dataRequestTime,
      required super.dataNotApproveRequestTime});

  @override
  List<Object?> get props => [
        changeTimeData,
        requestTimeData,
        leaveRequestData,
        withdrawLeaveData,
        payrollSetting
      ];
}

class WaitingStatusLoading extends WaitingStatusState {
  WaitingStatusLoading(
      {required super.withdrawNotLeaveData,
      required super.changeTimeData,
      required super.requestTimeData,
      required super.leaveRequestData,
      required super.leaveNotApproveData,
      required super.withdrawLeaveData,
      required super.payrollSetting,
      required super.dataOt,
      required super.dataNotApproveOt,
      required super.dataRequestTime,
      required super.dataNotApproveRequestTime});

  @override
  List<Object?> get props => [];
}

class WaitingStatusFailure extends WaitingStatusState {
  final ErrorMessage error;

  const WaitingStatusFailure(
      {required this.error,
      required super.withdrawNotLeaveData,
      required super.changeTimeData,
      required super.requestTimeData,
      required super.leaveRequestData,
      required super.leaveNotApproveData,
      required super.withdrawLeaveData,
      required super.payrollSetting,
      required super.dataOt,
      required super.dataNotApproveOt,
      required super.dataRequestTime,
      required super.dataNotApproveRequestTime});

  @override
  List<Object?> get props => [error];
}

class WaitingStatusSendRequestSuccess extends WaitingStatusState {

  const WaitingStatusSendRequestSuccess(
      {
        required super.withdrawNotLeaveData,
        required super.changeTimeData,
        required super.requestTimeData,
        required super.leaveRequestData,
        required super.leaveNotApproveData,
        required super.withdrawLeaveData,
        required super.payrollSetting,
        required super.dataOt,
        required super.dataNotApproveOt,
        required super.dataRequestTime,
        required super.dataNotApproveRequestTime});

  @override
  List<Object?> get props => [];
}

class WaitingStatusSendRequestFailed extends WaitingStatusState {

  const WaitingStatusSendRequestFailed(
      {
        required super.withdrawNotLeaveData,
        required super.changeTimeData,
        required super.requestTimeData,
        required super.leaveRequestData,
        required super.leaveNotApproveData,
        required super.withdrawLeaveData,
        required super.payrollSetting,
        required super.dataOt,
        required super.dataNotApproveOt,
        required super.dataRequestTime,
        required super.dataNotApproveRequestTime});

  @override
  List<Object?> get props => [];
}
