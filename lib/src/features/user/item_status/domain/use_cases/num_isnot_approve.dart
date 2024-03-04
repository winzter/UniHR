import '../entities/entities.dart';
import '../repositories/item_status_repository.dart';

class NumIsNotApprove{
  final ItemStatusRepository repository;
  NumIsNotApprove(this.repository);

  int call(List<RequestTimeEntity> requestData,List<LeaveEntity> leaveData){
    return repository.numIsNotApprove(requestData, leaveData);
  }
}