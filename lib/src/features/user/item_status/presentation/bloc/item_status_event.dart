part of 'item_status_bloc.dart';

abstract class ItemStatusEvent extends Equatable {
  const ItemStatusEvent();
}

class GetItemStatusData extends ItemStatusEvent{
  final String startDate;
  final String endDate;

  const GetItemStatusData({required this.startDate,required this.endDate});
  @override
  List<Object?> get props => [startDate,endDate];
}
class DeleteItemData extends ItemStatusEvent{
  final int index;
  final String type;
  final RequestTimeEntity? requestTime;
  final LeaveEntity? leaveData;
  const DeleteItemData({required this.index,required this.type, this.requestTime, this.leaveData});
  @override
  List<Object?> get props => [index,requestTime,leaveData];

}




