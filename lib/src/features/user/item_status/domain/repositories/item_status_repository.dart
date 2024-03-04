import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/entities.dart';

abstract class ItemStatusRepository{

  // * get leave data
  Future<Either<ErrorMessage, List<LeaveEntity>>> getLeave(
      String startDate, String endDate);

  // * get request time data
  Future<Either<ErrorMessage, List<RequestTimeEntity>>> getRequestTime(
      String startDate, String endDate);

  // * get withdraw data
  Future<Either<ErrorMessage, List<WithdrawEntity>>> getWithdraw(
      String startDate, String endDate);

  // * get payroll data
  Future<Either<ErrorMessage, PayrollSettingEntity>> getPayrollSetting();

  // * delete item
  Future<Either<ErrorMessage, void>> deleteItem(
      {LeaveEntity? dataLeave, RequestTimeEntity? dataRequestTime});

  // * check date is full day
  String isFullDay(DateTime start, DateTime end);

  // * count number of none approved status
  int numIsNotApprove(List<RequestTimeEntity> requestData , List<LeaveEntity> leaveData);

}