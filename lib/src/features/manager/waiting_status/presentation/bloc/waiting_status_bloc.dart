import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/features/profile/domain/entity/profile_entity.dart';
import '../../../../user/item_status/domain/entities/payroll_setting_entity.dart';
import '../../data/data_sources/send_data/change_time.dart';
import '../../domain/entities/entities.dart';
import '../../domain/use_cases/usecases.dart';

part 'waiting_status_event.dart';

part 'waiting_status_state.dart';

class WaitingStatusBloc extends Bloc<WaitingStatusEvent, WaitingStatusState> {
  final GetLeaveRequestManager getLeaveRequestManager;
  final GetRequestTimeManager getRequestTimeManager;
  final GetWithdrawLeaveManager getWithdrawLeaveManager;
  final GetChangeTimeManager getChangeTimeManager;
  final GetPayrollSettingManager getPayrollSettingManager;
  final IsLeaveApprove isLeaveApprove;
  final IsLeaveApprove withdrawLeaveApprove;
  final IsRequestApprove isRequestApprove;

  final IsChangeTimeApprove isChangeTimeApprove;

  List<LeaveRequestManager> leaveData = [];
  List<LeaveRequestManager> leaveNotApproveData = [];
  List<RequestTimeManager> reqTimeData = [];
  List<WithdrawLeaveManager> withdrawData = [];
  List<WithdrawLeaveManager> withdrawNotDataTimeData = [];
  List<ChangeTimeManager> changeTimeData = [];
  List<ChangeTimeManager> changeNotApproveTimeData = [];
  PayrollSettingEntity? payrollData;
  List<RequestTimeManager> dataRequestTime = [];
  List<RequestTimeManager> dataNotApproveRequestTime = [];
  List<RequestTimeManager> dataRequestOT = [];
  List<RequestTimeManager> dataNotApproveRequestOT = [];

  WaitingStatusBloc({
    required this.withdrawLeaveApprove,
    required this.getLeaveRequestManager,
    required this.getPayrollSettingManager,
    required this.getRequestTimeManager,
    required this.getWithdrawLeaveManager,
    required this.getChangeTimeManager,
    required this.isLeaveApprove,
    required this.isRequestApprove,
    required this.isChangeTimeApprove,
  }) : super(WaitingStatusInitial(
          changeTimeData: [],
          requestTimeData: [],
          leaveRequestData: [],
          leaveNotApproveData: [],
          withdrawLeaveData: [],
          payrollSetting: null,
          dataOt: [],
          dataNotApproveOt: [],
          dataRequestTime: [],
          dataNotApproveRequestTime: [],
          withdrawNotLeaveData: [],
        )) {
    on<GetWaitingStatus>((event, emit) async {
      leaveData.clear();
      leaveNotApproveData.clear();
      withdrawNotDataTimeData.clear();
      reqTimeData.clear();
      withdrawData.clear();
      changeTimeData.clear();
      changeNotApproveTimeData.clear();
      dataRequestTime.clear();
      dataNotApproveRequestTime.clear();
      dataRequestOT.clear();
      dataNotApproveRequestOT.clear();
      emit(WaitingStatusLoading(
        changeTimeData: state.changeTimeData,
        requestTimeData: state.requestTimeData,
        leaveRequestData: state.leaveRequestData,
        leaveNotApproveData: state.leaveNotApproveData,
        withdrawLeaveData: state.withdrawLeaveData,
        payrollSetting: state.payrollSetting,
        dataOt: state.dataOt,
        dataNotApproveOt: state.dataNotApproveOt,
        dataRequestTime: state.requestTimeData,
        dataNotApproveRequestTime: state.dataNotApproveOt,
        withdrawNotLeaveData: state.withdrawNotLeaveData,
      ));
      var resLeave =
          await getLeaveRequestManager(start: event.start, end: event.end);
      var resReqTime =
          await getRequestTimeManager(start: event.start, end: event.end);
      var resWithdraw =
          await getWithdrawLeaveManager(start: event.start, end: event.end);
      var resChangeTime = await getChangeTimeManager();
      var resPayroll = await getPayrollSettingManager();
      resLeave.fold(
          (l) => emit(WaitingStatusFailure(
                error: l,
                changeTimeData: state.changeTimeData,
                requestTimeData: state.requestTimeData,
                leaveRequestData: state.leaveRequestData,
                leaveNotApproveData: state.leaveNotApproveData,
                withdrawLeaveData: state.withdrawLeaveData,
                payrollSetting: state.payrollSetting,
                dataOt: state.dataOt,
                dataNotApproveOt: state.dataNotApproveOt,
                dataRequestTime: state.requestTimeData,
                dataNotApproveRequestTime: state.dataNotApproveOt,
                withdrawNotLeaveData: state.withdrawNotLeaveData,
              )),
          (r) => leaveData = r);
      resReqTime.fold(
          (l) => emit(WaitingStatusFailure(
                error: l,
                changeTimeData: state.changeTimeData,
                requestTimeData: state.requestTimeData,
                leaveRequestData: state.leaveRequestData,
                leaveNotApproveData: state.leaveNotApproveData,
                withdrawLeaveData: state.withdrawLeaveData,
                payrollSetting: state.payrollSetting,
                dataOt: state.dataOt,
                dataNotApproveOt: state.dataNotApproveOt,
                dataRequestTime: state.requestTimeData,
                dataNotApproveRequestTime: state.dataNotApproveOt,
                withdrawNotLeaveData: state.withdrawNotLeaveData,
              )),
          (r) => reqTimeData = r);
      resWithdraw.fold(
          (l) => emit(WaitingStatusFailure(
                error: l,
                changeTimeData: state.changeTimeData,
                requestTimeData: state.requestTimeData,
                leaveRequestData: state.leaveRequestData,
                leaveNotApproveData: state.leaveNotApproveData,
                withdrawLeaveData: state.withdrawLeaveData,
                payrollSetting: state.payrollSetting,
                dataOt: state.dataOt,
                dataNotApproveOt: state.dataNotApproveOt,
                dataRequestTime: state.requestTimeData,
                dataNotApproveRequestTime: state.dataNotApproveOt,
                withdrawNotLeaveData: state.withdrawNotLeaveData,
              )),
          (r) => withdrawData = r);
      resChangeTime.fold(
          (l) => emit(WaitingStatusFailure(
                error: l,
                changeTimeData: state.changeTimeData,
                requestTimeData: state.requestTimeData,
                leaveRequestData: state.leaveRequestData,
                leaveNotApproveData: state.leaveNotApproveData,
                withdrawLeaveData: state.withdrawLeaveData,
                payrollSetting: state.payrollSetting,
                dataOt: state.dataOt,
                dataNotApproveOt: state.dataNotApproveOt,
                dataRequestTime: state.requestTimeData,
                dataNotApproveRequestTime: state.dataNotApproveOt,
                withdrawNotLeaveData: state.withdrawNotLeaveData,
              )),
          (r) => changeTimeData = r);
      resPayroll.fold(
          (l) => emit(WaitingStatusFailure(
                error: l,
                changeTimeData: state.changeTimeData,
                requestTimeData: state.requestTimeData,
                leaveRequestData: state.leaveRequestData,
                leaveNotApproveData: state.leaveNotApproveData,
                withdrawLeaveData: state.withdrawLeaveData,
                payrollSetting: state.payrollSetting,
                dataOt: state.dataOt,
                dataNotApproveOt: state.dataNotApproveOt,
                dataRequestTime: state.requestTimeData,
                dataNotApproveRequestTime: state.dataNotApproveOt,
                withdrawNotLeaveData: state.withdrawNotLeaveData,
              )),
          (r) => payrollData = r);
      for (var data in leaveData) {
        if (data.isApprove == null) {
          leaveNotApproveData.add(data);
        }
      }
      for (var data in withdrawData) {
        if (data.isApprove == null) {
          withdrawNotDataTimeData.add(data);
        }
      }
      for (var data in reqTimeData) {
        if (data.idRequestType == 2 || data.idRequestType == 3) {
          dataRequestOT.add(data);
          if (data.isDoubleApproval == 0 && data.isManagerLv1Approve == null) {
            dataNotApproveRequestOT.add(data);
          } else if (data.isDoubleApproval == 1 &&
              data.isManagerLv1Approve == null) {
            dataNotApproveRequestOT.add(data);
          } else if (data.isDoubleApproval == 1 &&
              data.isManagerLv2Approve == null &&
              data.managerLv2ApproveBy == event.managerData.idEmployees!) {
            dataNotApproveRequestOT.add(data);
          }
        }
      }
      for (var data in reqTimeData) {
        if (data.idRequestType == 1) {
          dataRequestTime.add(data);
          if (data.isDoubleApproval == 0 && data.isManagerLv1Approve == null) {
            dataNotApproveRequestTime.add(data);
          }
        }
      }
      for (var data in changeTimeData) {
        if (data.isApprove == null) {
          changeNotApproveTimeData.add(data);
        }
      }
      emit(WaitingStatusLoaded(
        changeTimeData: changeNotApproveTimeData,
        requestTimeData: reqTimeData,
        leaveRequestData: leaveData,
        withdrawLeaveData: withdrawData,
        payrollSetting: payrollData!,
        dataOt: dataRequestOT,
        dataRequestTime: dataRequestTime,
        dataNotApproveOt: dataNotApproveRequestOT,
        leaveNotApproveData: leaveNotApproveData,
        dataNotApproveRequestTime: dataNotApproveRequestTime,
        withdrawNotLeaveData: withdrawNotDataTimeData,
      ));
    });
    on<IsApprovewithdrawLeaveWaitingStatus>((event, emit) async {
      List<int> idwithdraw = [];
      for (var i in event.indexes) {
        idwithdraw.add(withdrawNotDataTimeData[i].idLeaveEmployeesWithdraw!);
      }
      List<int> idlave = [];
      for (var i in event.indexes) {
        idwithdraw.add(withdrawNotDataTimeData[i].idLeave!);
      }

      var sendwithdrawLeave = await withdrawLeaveApprove(
          commentManager: event.comment!,
          idLeave: idlave,
          idLeaveEmployeesWithdraw: idwithdraw,
          isApprove: event.isApprove);
      sendwithdrawLeave.fold(
          (l) => emit(WaitingStatusSendRequestFailed(
                changeTimeData: state.changeTimeData,
                requestTimeData: state.requestTimeData,
                leaveRequestData: state.leaveRequestData,
                leaveNotApproveData: state.leaveNotApproveData,
                withdrawLeaveData: state.withdrawLeaveData,
                payrollSetting: state.payrollSetting,
                dataOt: state.dataOt,
                dataNotApproveOt: state.dataNotApproveOt,
                dataRequestTime: state.requestTimeData,
                dataNotApproveRequestTime: state.dataNotApproveOt,
                withdrawNotLeaveData: state.withdrawNotLeaveData,
              )),
          (r) => emit(WaitingStatusSendRequestSuccess(
                changeTimeData: state.changeTimeData,
                requestTimeData: state.requestTimeData,
                leaveRequestData: state.leaveRequestData,
                leaveNotApproveData: state.leaveNotApproveData,
                withdrawLeaveData: state.withdrawLeaveData,
                payrollSetting: state.payrollSetting,
                dataOt: state.dataOt,
                dataNotApproveOt: state.dataNotApproveOt,
                dataRequestTime: state.requestTimeData,
                dataNotApproveRequestTime: state.dataNotApproveOt,
                withdrawNotLeaveData: state.withdrawNotLeaveData,
              )));
    });

    on<IsApproveLeaveWaitingStatus>((event, emit) async {
      List<int> idLeave = [];
      for (var i in event.indexes) {
        idLeave.add(leaveNotApproveData[i].idLeave!);
      }
      var sendLeaveApprove = await isLeaveApprove(
          commentManager: event.comment!,
          idLeave: idLeave,
          idLeaveEmployeesWithdraw: [],
          isApprove: event.isApprove);
      sendLeaveApprove.fold(
          (l) => emit(WaitingStatusSendRequestFailed(
                // error: l,
                changeTimeData: state.changeTimeData,
                requestTimeData: state.requestTimeData,
                leaveRequestData: state.leaveRequestData,
                leaveNotApproveData: state.leaveNotApproveData,
                withdrawLeaveData: state.withdrawLeaveData,
                payrollSetting: state.payrollSetting,
                dataOt: state.dataOt,
                dataNotApproveOt: state.dataNotApproveOt,
                dataRequestTime: state.requestTimeData,
                dataNotApproveRequestTime: state.dataNotApproveOt,
                withdrawNotLeaveData: state.withdrawNotLeaveData,
              )),
          (r) => emit(WaitingStatusSendRequestSuccess(
                changeTimeData: state.changeTimeData,
                requestTimeData: state.requestTimeData,
                leaveRequestData: state.leaveRequestData,
                leaveNotApproveData: state.leaveNotApproveData,
                withdrawLeaveData: state.withdrawLeaveData,
                payrollSetting: state.payrollSetting,
                dataOt: state.dataOt,
                dataNotApproveOt: state.dataNotApproveOt,
                dataRequestTime: state.requestTimeData,
                dataNotApproveRequestTime: state.dataNotApproveOt,
                withdrawNotLeaveData: state.withdrawNotLeaveData,
              )));
    });

    on<IsApproveRequestTimeWaitingStatus>((event, emit) async {
      List<int> idRequestTime = [];
      if (event.type == "ขอรับรองเวลาทำงาน") {
        for (var i in event.indexes) {
          idRequestTime.add(dataNotApproveRequestTime[i].idRequestTime!);
        }
        var sendRequestApprove = await isRequestApprove(
            commentManagerLV1: event.commentManagerLV1,
            commentManagerLV2: event.commentManagerLV2,
            idRequestTimeLv1: idRequestTime,
            idRequestTimeLv2: [],
            isManagerLV1Approve: event.isManagerLV1Approve!,
            isManagerLV2Approve: null);
        sendRequestApprove.fold(
            (l) => emit(WaitingStatusSendRequestFailed(
                  changeTimeData: state.changeTimeData,
                  requestTimeData: state.requestTimeData,
                  leaveRequestData: state.leaveRequestData,
                  leaveNotApproveData: state.leaveNotApproveData,
                  withdrawLeaveData: state.withdrawLeaveData,
                  payrollSetting: state.payrollSetting,
                  dataOt: state.dataOt,
                  dataNotApproveOt: state.dataNotApproveOt,
                  dataRequestTime: state.requestTimeData,
                  dataNotApproveRequestTime: state.dataNotApproveOt,
                  withdrawNotLeaveData: state.withdrawNotLeaveData,
                )),
            (r) => emit(WaitingStatusSendRequestSuccess(
                  changeTimeData: state.changeTimeData,
                  requestTimeData: state.requestTimeData,
                  leaveRequestData: state.leaveRequestData,
                  leaveNotApproveData: state.leaveNotApproveData,
                  withdrawLeaveData: state.withdrawLeaveData,
                  payrollSetting: state.payrollSetting,
                  dataOt: state.dataOt,
                  dataNotApproveOt: state.dataNotApproveOt,
                  dataRequestTime: state.requestTimeData,
                  dataNotApproveRequestTime: state.dataNotApproveOt,
                  withdrawNotLeaveData: state.withdrawNotLeaveData,
                )));
      } else if (event.type == "ขอทำงานล่วงเวลา") {
        List<int> idRequestTimeLV1 = [];
        List<int> idRequestTimeLV2 = [];
        for (var i in event.indexes) {
          if (dataNotApproveRequestOT[i].isDoubleApproval == 1) {
            if (dataNotApproveRequestOT[i].managerLv2ApproveBy != null &&
                dataNotApproveRequestOT[i].managerLv2ApproveBy ==
                    event.idManager) {
              idRequestTimeLV2.add(dataNotApproveRequestOT[i].idRequestTime!);
            }
          }
          if (dataNotApproveRequestOT[i].managerLv1ApproveBy! ==
              event.idManager) {
            idRequestTimeLV1.add(dataNotApproveRequestOT[i].idRequestTime!);
          }
        }
        var sendRequestApprove = await isRequestApprove(
            commentManagerLV1: event.commentManagerLV1,
            commentManagerLV2: event.commentManagerLV2,
            idRequestTimeLv1: idRequestTimeLV1,
            idRequestTimeLv2: idRequestTimeLV2,
            isManagerLV1Approve: event.isManagerLV1Approve!,
            isManagerLV2Approve: idRequestTimeLV2.isNotEmpty
                ? event.isManagerLV1Approve!
                : null);
        sendRequestApprove.fold(
            (l) => emit(WaitingStatusSendRequestFailed(
                changeTimeData: state.changeTimeData,
                requestTimeData: state.requestTimeData,
                leaveRequestData: state.leaveRequestData,
                leaveNotApproveData: state.leaveNotApproveData,
                withdrawLeaveData: state.withdrawLeaveData,
                payrollSetting: state.payrollSetting,
                dataOt: state.dataOt,
                dataNotApproveOt: state.dataNotApproveOt,
                dataRequestTime: state.requestTimeData,
                dataNotApproveRequestTime: state.dataNotApproveOt,
                withdrawNotLeaveData: state.withdrawNotLeaveData)),
            (r) => emit(WaitingStatusSendRequestSuccess(
                changeTimeData: state.changeTimeData,
                requestTimeData: state.requestTimeData,
                leaveRequestData: state.leaveRequestData,
                leaveNotApproveData: state.leaveNotApproveData,
                withdrawLeaveData: state.withdrawLeaveData,
                payrollSetting: state.payrollSetting,
                dataOt: state.dataOt,
                dataNotApproveOt: state.dataNotApproveOt,
                dataRequestTime: state.requestTimeData,
                dataNotApproveRequestTime: state.dataNotApproveOt,
                withdrawNotLeaveData: state.withdrawNotLeaveData)));
      }
    });

    on<IsApproveChangeTime>((event, emit) async {
      List<ChangeTimeManager> data = [];
      List<ChangeTimeSendData> sendData = [];
      event.indexes.forEach((element) {
        data.add(state.changeTimeData[element]);
      });
      data.forEach((e) {
        sendData.add(ChangeTimeSendData(
          approveBy: event.idManager,
          approveComment: event.commentManager,
          approveDate: DateTime.now(),
          createDate: e.createDate!,
          departmentName: e.departmentName??"",
          idHoliday: e.idHoliday,
          fillInApprove: null,
          fillInChange: null,
          firstname_TH: e.firstnameTh!,
          holidayName: e.holidayName,
          idEmployeeShiftDaily: e.idEmployeeShiftDaily!,
          idEmployees: e.idEmployees!,
          idShift: e.idShift!,
          idShiftGroup: e.idShiftGroup!,
          idShiftType: e.idShiftType!,
          isActive: 1,
          isApprove: event.isApprove,
          isWorkingDay: e.isWorkingDay!,
          lastname_TH: e.lastnameTh!,
          positionName: e.positionName!,
          shiftGroupName: e.shiftGroupName!,
          workingDate: e.workingDate!,
          workingDateText: e.workingDateText!,
        ));
      });
      var res = await isChangeTimeApprove(sendTimeData: sendData);
      res.fold(
          (l) => emit(WaitingStatusSendRequestFailed(
              changeTimeData: state.changeTimeData,
              requestTimeData: state.requestTimeData,
              leaveRequestData: state.leaveRequestData,
              leaveNotApproveData: state.leaveNotApproveData,
              withdrawLeaveData: state.withdrawLeaveData,
              payrollSetting: state.payrollSetting,
              dataOt: state.dataOt,
              dataNotApproveOt: state.dataNotApproveOt,
              dataRequestTime: state.requestTimeData,
              dataNotApproveRequestTime: state.dataNotApproveOt,
              withdrawNotLeaveData: state.withdrawNotLeaveData)),
          (r) => emit(WaitingStatusSendRequestSuccess(
              changeTimeData: state.changeTimeData,
              requestTimeData: state.requestTimeData,
              leaveRequestData: state.leaveRequestData,
              leaveNotApproveData: state.leaveNotApproveData,
              withdrawLeaveData: state.withdrawLeaveData,
              payrollSetting: state.payrollSetting,
              dataOt: state.dataOt,
              dataNotApproveOt: state.dataNotApproveOt,
              dataRequestTime: state.requestTimeData,
              dataNotApproveRequestTime: state.dataNotApproveOt,
              withdrawNotLeaveData: state.withdrawNotLeaveData)));
    });
  }
}
