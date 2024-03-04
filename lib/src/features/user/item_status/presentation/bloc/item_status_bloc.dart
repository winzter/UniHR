import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../domain/entities/entities.dart';
import '../../domain/use_cases/use_cases.dart';

part 'item_status_event.dart';
part 'item_status_state.dart';

class ItemStatusBloc extends Bloc<ItemStatusEvent, ItemStatusState> {
  final GetLeaveData getLeaveData;
  final GetRequestTimeData getRequestTimeData;
  final GetWithdraw getWithdraw;
  final GetPayrollSetting getPayrollSetting;
  final DeleteItem deleteItem;

  List<LeaveEntity> leaveData = [];
  List<RequestTimeEntity> reqTimeData = [];
  List<WithdrawEntity> withdrawData = [];
  PayrollSettingEntity? payrollSettingData;
  List<dynamic> dataRequestTime = [];
  List<dynamic> dataRequestCompensate = [];
  List<dynamic> dataRequestOT = [];
  List<dynamic> allData = [];

  ItemStatusBloc({
    required this.getLeaveData,
    required this.getRequestTimeData,
    required this.getWithdraw,
    required this.getPayrollSetting,
    required this.deleteItem
  }) : super(ItemStatusInitial()) {

    on<GetItemStatusData>((event, emit) async{
      emit(ItemStatusLoading());
      leaveData.clear();
      reqTimeData.clear();
      withdrawData.clear();
      dataRequestTime.clear();
      dataRequestCompensate.clear();
      dataRequestOT.clear();
      allData.clear();
      var resLeave = await getLeaveData(event.startDate,event.endDate);
      var resReqTime = await getRequestTimeData(event.startDate,event.endDate);
      var resWithdraw = await getWithdraw(event.startDate,event.endDate);
      var resPayrollData = await getPayrollSetting();
      resLeave.fold(
              (l) => emit(ItemStatusStateFailure(error: l)),
              (r)=>leaveData=r);
      resReqTime.fold(
              (l) => emit(ItemStatusStateFailure(error: l)),
              (r) => reqTimeData = r);
      resWithdraw.fold(
              (l) => emit(ItemStatusStateFailure(error: l)),
              (r)=> withdrawData=r);
      for(var i in reqTimeData){
        if (i.idRequestType == 1) {
          dataRequestTime.add(i);
        }
        if (i.idRequestType == 2) {
          dataRequestOT.add(i);
        }
        if(i.idRequestType == 3){
          dataRequestCompensate.add(i);
        }
      }
      allData = [...reqTimeData,...leaveData];
      resPayrollData.fold(
              (l) => emit(ItemStatusStateFailure(error: l)),
              (r) {
                payrollSettingData = r;
                emit(ItemStatusLoaded(
                  leaveData: leaveData,
                  requestTimeData: reqTimeData,
                  withdrawData: withdrawData,
                  payrollSettingData: r,
                  allData: allData,
                  dataRequestCompensate: dataRequestCompensate,
                  dataRequestOT: dataRequestOT,
                  dataRequestTime: dataRequestTime
                ));
              });
    });

    on<DeleteItemData>((event,emit) async{
      emit(ItemStatusLoading());
      Either<ErrorMessage, void> deleteRes;
      if (reqTimeData.isNotEmpty && leaveData.isNotEmpty) {
        if (event.index < reqTimeData.length && event.type != "ขอลา") {
          deleteRes = await deleteItem(dataRequestTime: event.requestTime);
          allData.removeAt(event.index);
          if (event.type == "ขอรับรองเวลาทำงาน" || event.type == "ขอทำงานล่วงเวลา") {
            if(event.type == "ขอรับรองเวลาทำงาน"){
              dataRequestTime.removeAt(event.index);
            }else{
              dataRequestOT.removeAt(event.index);
            }
            reqTimeData.removeAt(reqTimeData.indexWhere((data) => data.idRequestTime == event.requestTime!.idRequestTime,));
          } else if (event.type == "all") {
            reqTimeData.removeAt(event.index);
            if(event.requestTime!.idRequestType == 1){
              dataRequestTime.removeAt(dataRequestTime.indexWhere((data) => data.idRequestTime == event.requestTime!.idRequestTime,));
            }else if(event.requestTime!.idRequestType == 2 ){
              dataRequestOT.removeAt(dataRequestOT.indexWhere((data) => data.idRequestTime == event.requestTime!.idRequestTime,));
            }
          }
        }
        else if(event.type == "ขอทำชั่วโมงCompensate"){
          deleteRes = await deleteItem(dataRequestTime: event.requestTime);
          dataRequestCompensate.removeAt(dataRequestCompensate.indexWhere((data) => data.idRequestTime == event.requestTime!.idRequestTime,));
        }
        else {
          deleteRes = await deleteItem(dataLeave: event.leaveData);
          if (event.type == "all") {
            leaveData.removeAt((event.index - reqTimeData.length).abs());
          } else if (event.type == "ขอลา") {
            leaveData.removeAt(event.index);
          }
        }
        deleteRes.fold(
                (l) => emit(ItemStatusSendRequestFailed()),
                (r) => emit(ItemStatusSendRequestSuccess(
                      leaveData: leaveData,
                      requestTimeData: reqTimeData,
                      withdrawData: withdrawData,
                      payrollSettingData: payrollSettingData,
                      allData: allData,
                      dataRequestOT: dataRequestOT,
                      dataRequestTime: dataRequestTime
                )));
        // item.numIsNotApprove();
      }

      // emit(ItemStatusLoaded(
      //     leaveData: leaveData,
      //     requestTimeData: reqTimeData,
      //     withdrawData: withdrawData,
      //     payrollSettingData: payrollSettingData,
      //     allData: allData,
      //     dataRequestOT: dataRequestOT,
      //     dataRequestTime: dataRequestTime
      // ));
    });
  }
}
