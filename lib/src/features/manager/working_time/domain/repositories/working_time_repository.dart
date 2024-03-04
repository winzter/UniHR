import 'package:dartz/dartz.dart';
import 'package:unihr/src/features/user/timeline/domain/entities/timeline_entity.dart';
import '../../../../../core/error/failures.dart';
import '../entities/entities.dart';

abstract class WorkingTimeRepository{
  Future<Either<ErrorMessage,List<EmployeesAttendanceEntity>>> getEmployeesAttendance(String start);
  Future<Either<ErrorMessage,List<EmployeesLeaveEntity>>> getEmployeesLeave(String start);
  Future<Either<ErrorMessage,List<EmployeesEntity>>> getEmployees();
  Future<Either<ErrorMessage,List<PayrollSettingEntity>>> getPayrollSetting();
  Future<Either<ErrorMessage,List<ReasonEntity>>> getReasonManager();
  Future<Either<ErrorMessage,List<TimeLineEntity>>> getAttendanceEmpDate(int id,String start,String end);
  // Future<Either<ErrorMessage,void>> sendTimeRequestManager(
  //     CalculateTimeEntity result,
  //     int idEmployee,
  //     int idRequestType,
  //     String requestReason,
  //     String otherReason,
  //     DateTime start,
  //     DateTime end,
  //     DateTime workEndDate,
  //     EmployeesEntity profileData
  //     );
}