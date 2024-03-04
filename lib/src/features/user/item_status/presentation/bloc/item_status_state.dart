part of 'item_status_bloc.dart';

abstract class ItemStatusState extends Equatable {
  const ItemStatusState();

}

class ItemStatusInitial extends ItemStatusState {
  @override
  List<Object> get props => [];
}

class ItemStatusLoading extends ItemStatusState{
  @override
  List<Object?> get props => [];
}

class ItemStatusLoaded extends ItemStatusState{
   final List<LeaveEntity>? leaveData;
   final List<RequestTimeEntity>? requestTimeData;
   final List<WithdrawEntity>? withdrawData;
   final PayrollSettingEntity? payrollSettingData;
   final List<dynamic>? allData;
   final List<dynamic>? dataRequestOT;
   final List<dynamic>? dataRequestCompensate;
   final List<dynamic>? dataRequestTime;
   const ItemStatusLoaded({
     this.leaveData,
     this.requestTimeData,
     this.withdrawData,
     this.payrollSettingData,
     this.allData,
     this.dataRequestOT,
     this.dataRequestTime,
     this.dataRequestCompensate,
   });
  @override
  List<Object?> get props => [
    leaveData,
    requestTimeData,
    withdrawData,
    dataRequestCompensate,
  ];

}


class ItemStatusStateFailure extends ItemStatusState{
  final ErrorMessage error;

  const ItemStatusStateFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

class ItemStatusSendRequestSuccess extends ItemStatusState{
  final List<LeaveEntity>? leaveData;
  final List<RequestTimeEntity>? requestTimeData;
  final List<WithdrawEntity>? withdrawData;
  final PayrollSettingEntity? payrollSettingData;
  final List<dynamic>? allData;
  final List<dynamic>? dataRequestOT;
  final List<dynamic>? dataRequestCompensate;
  final List<dynamic>? dataRequestTime;
  const ItemStatusSendRequestSuccess({
    this.leaveData,
    this.requestTimeData,
    this.withdrawData,
    this.payrollSettingData,
    this.allData,
    this.dataRequestOT,
    this.dataRequestTime,
    this.dataRequestCompensate,
  });
  @override
  List<Object?> get props => [
    leaveData,
    requestTimeData,
    withdrawData,
    dataRequestCompensate,
  ];
}

class ItemStatusSendRequestFailed extends ItemStatusState{

  const ItemStatusSendRequestFailed();

@override
List<Object?> get props => [];
}
