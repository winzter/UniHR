import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:unihr/src/core/features/profile/domain/usecase/get_profile.dart';
import 'package:unihr/src/features/manager/employees_list/data/data_sources/remote/employees_remote_data_source.dart';
import 'package:unihr/src/features/manager/employees_list/data/repositories/employees_repository_impl.dart';
import 'package:unihr/src/features/manager/employees_list/domain/repositories/employees_repository.dart';
import 'package:unihr/src/features/manager/employees_list/presentation/bloc/employees_list_bloc.dart';
import 'package:unihr/src/features/manager/overview/data/data_sources/remote/overview_remote_data_source.dart';
import 'package:unihr/src/features/manager/overview/data/repositories/overview_repositories_impl.dart';
import 'package:unihr/src/features/manager/overview/domain/repositories/overview_repository.dart';
import 'package:unihr/src/features/manager/overview/domain/use_cases/use_cases.dart';
import 'package:unihr/src/features/manager/overview/presentation/bloc/overview_bloc.dart';
import 'package:unihr/src/features/manager/waiting_status/data/data_sources/remote/waiting_status_remote_datasource.dart';
import 'package:unihr/src/features/manager/waiting_status/domain/repositories/waiting_status_repository.dart';
import 'package:unihr/src/features/manager/waiting_status/domain/use_cases/usecases.dart';
import 'package:unihr/src/features/manager/waiting_status/presentation/bloc/waiting_status_bloc.dart';
import 'package:unihr/src/features/manager/working_time/presentation/bloc/daily_detail_bloc/working_time_bloc.dart';
import 'package:unihr/src/features/manager/working_time/presentation/bloc/individual_detail/workingtime_individual_bloc.dart';
import 'package:unihr/src/features/user/bluetooth_beacon/data/data_sources/remote/bluetooth_beacon_data_source.dart';
import 'package:unihr/src/features/user/bluetooth_beacon/data/repositories/bluetooth_beacon_repository_impl.dart';
import 'package:unihr/src/features/user/bluetooth_beacon/domain/repositories/bluetooth_beacon_repository.dart';
import 'package:unihr/src/features/user/bluetooth_beacon/domain/use_cases/send_check_inout.dart';
import 'package:unihr/src/features/user/bluetooth_beacon/presentation/bloc/bluetooth_bloc.dart';
import 'package:unihr/src/features/user/employee_network/data/data_sources/remote/employee_network_remote_datasources.dart';
import 'package:unihr/src/features/user/employee_network/data/repositories/employee_network_repository_impl.dart';
import 'package:unihr/src/features/user/employee_network/domain/repositories/employee_network_repository.dart';
import 'package:unihr/src/features/user/employee_network/domain/use_cases/use_cases.dart';
import 'package:unihr/src/features/user/employee_network/presentation/bloc/employee_network_bloc.dart';
import 'package:unihr/src/features/user/shift_ot/domain/repositories/shift_ot_repository.dart';
import 'package:unihr/src/features/user/shift_ot/domain/use_cases/get_shift_ot.dart';
import 'package:unihr/src/features/user/time_management/data/data_source/remote/time_management_remote_data_source.dart';
import 'package:unihr/src/features/user/time_management/data/repositories/time_management_repository_impl.dart';
import 'package:unihr/src/features/user/time_management/domain/repositories/time_management_repository.dart';
import 'package:unihr/src/features/user/time_management/domain/use_cases/use_cases.dart';
import 'package:unihr/src/features/user/time_management/presentation/bloc/time_management_bloc.dart';
import 'package:unihr/src/features/user/travelling/data/data_sources/remote/travelling_remote_data_source.dart';
import 'package:unihr/src/features/user/travelling/data/repositories/travelling_repository_impl.dart';
import 'package:unihr/src/features/user/travelling/domain/repositories/travelling_repostiory.dart';
import 'package:unihr/src/features/user/travelling/domain/use_cases/usecases.dart';
import 'package:unihr/src/features/user/travelling/presentation/bloc/LocationBloc_bloc.dart';
import 'package:unihr/src/features/user/working_record/data/data_sources/remote/working_record_remote_datasource.dart';
import 'package:unihr/src/features/user/working_record/data/repositories/working_record_repository_impl.dart';
import 'package:unihr/src/features/user/working_record/domain/repositories/working_record_repository.dart';
import 'package:unihr/src/features/user/working_record/presentation/bloc/WorkRecord_bloc.dart';
import 'src/core/features/login/data/data_sources/remote/login_api.dart';
import 'src/core/features/login/data/repositories/login_repository_impl.dart';
import 'src/core/features/login/domain/repositories/login_repository.dart';
import 'src/core/features/login/domain/use_cases/login_usecase.dart';
import 'src/core/features/login/presentation/bloc/login_bloc.dart';
import 'src/features/manager/employees_list/domain/use_cases/usecases.dart';
import 'src/features/manager/waiting_status/data/repositories/wait_status_repository_impl.dart';
import 'src/features/manager/working_time/data/data_sources/remote/working_time_remote_datasource.dart';
import 'src/features/manager/working_time/data/repositories/working_time_repository_impl.dart';
import 'src/features/manager/working_time/domain/repositories/working_time_repository.dart';
import 'src/features/manager/working_time/domain/use_cases/usecases.dart';
import 'src/features/user/gps/data/data_sources/remote/gps_remote_data_source.dart';
import 'src/features/user/gps/data/repositories/gps_repository_impl.dart';
import 'src/features/user/gps/domain/repositories/gps_repository.dart';
import 'src/features/user/gps/domain/use_cases/usecases.dart';
import 'src/features/user/gps/presentation/bloc/gps_bloc.dart';
import 'src/features/user/item_status/data/data_sources/remote/item_status_remote_datasource.dart';
import 'src/features/user/item_status/data/repositories/item_status_repository_impl.dart';
import 'src/features/user/item_status/domain/repositories/item_status_repository.dart';
import 'src/features/user/item_status/domain/use_cases/use_cases.dart';
import 'src/features/user/item_status/presentation/bloc/item_status_bloc.dart';
import 'src/features/user/leave/data/data_sources/remote/leave_remote_data_source.dart';
import 'src/features/user/leave/data/repositories/leave_repository_impl.dart';
import 'src/features/user/leave/domain/repositories/leave_repository.dart';
import 'src/features/user/leave/domain/use_cases/use_cases.dart';
import 'src/features/user/leave/presentaion/bloc/leave_bloc.dart';
import 'src/features/user/payslip/data/data_sources/remote/payslip_remote_data_source.dart';
import 'src/features/user/shift_ot/data/data_sources/remote/shift_ot_remote_datasource.dart';
import 'src/features/user/shift_ot/data/repositories/shift_ot_repository_impl.dart';
import 'src/features/user/shift_ot/presentation/bloc/shift_ot_bloc.dart';
import 'src/features/user/timeline/data/data_sources/remote/attendance_remote_datasource.dart';
import 'src/features/user/timeline/data/repositories/attendance_repository_impl.dart';
import 'src/features/user/timeline/domain/repositories/attendance_repository.dart';
import 'src/features/user/timeline/domain/use_cases/usecases.dart';
import 'src/features/user/timeline/presentation/bloc/timeline_bloc.dart';
import 'src/features/user/working_record/domain/use_cases/usecases.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // * Bloc
  sl.registerFactory(() => LoginBloc(
        loginUseCase: sl(),
      ));

  // * User
  // ! ItemStatus
  sl.registerFactory(() => ItemStatusBloc(
      getLeaveData: sl(),
      getRequestTimeData: sl(),
      getWithdraw: sl(),
      getPayrollSetting: sl(),
      deleteItem: sl()));
  // ! Leave
  sl.registerFactory(() => LeaveBloc(
        getLeaveHistory: sl(),
        deleteLeaveHistory: sl(),
        getLeaveAuthority: sl(),
        sendLeaveRequest: sl(),
        getManagerLeave: sl(),
        getDayCannotLeave: sl(),
        getHolidayLeave: sl(),
        getLeaveSettingData: sl(),
        getLeaveAvailableData: sl(),
      ));

  // ! GPS
  sl.registerFactory(
      () => GpsBloc(getLocation: sl(), sendLocation: sl(), getBeacons: sl()));

  // ! Employee Network
  sl.registerFactory(() => EmployeeNetworkBloc(
        getEmployeeNetworkData: sl(),
        getEachEmployeeNetworkData: sl(),
      ));

  // ! TimeLine
  sl.registerFactory(() => TimelineBloc(
      getAttendanceByDate: sl(),
      getReason: sl(),
      getEvents: sl(),
      sendTimeRequest: sl(),
      getPayrollSettingTimeLine: sl()));

  // ! Shift ant OT
  sl.registerFactory(() => ShiftOtBloc(getShiftAndOT: sl()));

  // ! Time Management
  sl.registerFactory(() => TimeManagementBloc(
        getShift: sl(),
        getTimeSchedule: sl(),
        getHoliday: sl(),
        sendShiftChange: sl(),
        withdrawChangTime: sl(),
        getShiftHoliday: sl(),
        withDrawChangeTime: sl(),
        getHolidayEn: sl(),
      ));

  // ! Travelling
  sl.registerFactory(() => LocationBloc(
      sendRouteRecord: sl(), getTimeLineById: sl(), isCheckIn: sl()));

  // ! Work Record
  sl.registerFactory(() => WorkRecordBloc(
        sendWorkingRecord: sl(),
        isCheckInWorkRecord: sl(),
      ));

  // ! Bluetooth
  sl.registerFactory(() => BluetoothBloc(sentCheckInOut: sl()));

  // ! Noti

  // ! ---------------------------------------------------------------------------------------------------------------------------------

  // * Manager
  // ! ManagerWaitingStatus
  sl.registerFactory(() => WaitingStatusBloc(
        getLeaveRequestManager: sl(),
        getRequestTimeManager: sl(),
        getWithdrawLeaveManager: sl(),
        getChangeTimeManager: sl(),
        getPayrollSettingManager: sl(),
        isLeaveApprove: sl(),
        isRequestApprove: sl(),
        isChangeTimeApprove: sl(),
        withdrawLeaveApprove: sl(),
      ));

  // ! ManagerWorkingTime
  sl.registerFactory(() => WorkingTimeBloc(
      getEmployeesAttendance: sl(),
      getEmployeesLeave: sl(),
      getEmployees: sl()));
  sl.registerFactory(() => WorkingTimeIndividualBloc(
      getEmployees: sl(),
      getAttendanceEmpDate: sl(),
      getReasonManager: sl(),
      // sendTimeRequestManager: sl()
  ));

  // ! ManagerOverview
  sl.registerFactory(() => OverviewBloc(
        getOverview: sl(),
        getDepartment: sl(),
        getOverTime: sl(),
        getWorkingTime: sl(),
        getCost: sl(),
      ));

  // ! ManagerEmployeesList
  sl.registerFactory(() => EmployeesListBloc(
        getEmployeesList: sl(),
        getEachEmployee: sl(),
      ));

  // * UseCase
  sl.registerLazySingleton(() => LoginUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetProfile(repository: sl()));

  // ! ItemStatus
  sl.registerLazySingleton(() => GetLeaveData(repository: sl()));
  sl.registerLazySingleton(() => GetRequestTimeData(repository: sl()));
  sl.registerLazySingleton(() => GetWithdraw(repository: sl()));
  sl.registerLazySingleton(() => GetPayrollSetting(repository: sl()));
  sl.registerLazySingleton(() => DeleteItem(repository: sl()));

  // ! GPS
  sl.registerLazySingleton(() => GetLocation(repository: sl()));
  sl.registerLazySingleton(() => SendLocation(repository: sl()));
  sl.registerLazySingleton(() => GetBeacons(repository: sl()));

  // ! Employee Network
  sl.registerLazySingleton(() => GetEmployeeNetworkData(repository: sl()));
  sl.registerLazySingleton(() => GetEachEmployeeNetworkData(repository: sl()));

  // ! Leave
  sl.registerLazySingleton(() => GetLeaveHistory(repository: sl()));
  sl.registerLazySingleton(() => DeleteLeaveHistory(repository: sl()));
  sl.registerLazySingleton(() => GetLeaveAuthority(repository: sl()));
  sl.registerLazySingleton(() => SendLeaveRequest(repository: sl()));
  sl.registerLazySingleton(() => GetManagerLeave(repository: sl()));
  sl.registerLazySingleton(() => GetDayCannotLeave(repository: sl()));
  sl.registerLazySingleton(() => GetHolidayLeave(repository: sl()));
  sl.registerLazySingleton(() => GetLeaveSettingData(repository: sl()));
  sl.registerLazySingleton(() => GetLeaveAvailableData(repository: sl()));

  // ! TimeLine
  sl.registerLazySingleton(() => GetAttendanceByDate(repository: sl()));
  sl.registerLazySingleton(() => GetReason(repository: sl()));
  sl.registerLazySingleton(() => GetEvents(repository: sl()));
  sl.registerLazySingleton(() => SendTimeRequest(repository: sl()));
  sl.registerLazySingleton(() => GetPayrollSettingTimeLine(repository: sl()));

  // ! Shift and OT
  sl.registerLazySingleton(() => GetShiftAndOT(repository: sl()));

  // ! Bluetooth
  sl.registerLazySingleton(() => SentCheckInOut(repository: sl()));

  // ! Work Record
  sl.registerLazySingleton(() => SendWorkingRecord(repository: sl()));
  sl.registerLazySingleton(() => IsCheckInWorkRecord(repository: sl()));

  // ! Travelling
  sl.registerLazySingleton(() => SendRouteRecord(repository: sl()));
  sl.registerLazySingleton(() => GetTimelineById(repository: sl()));
  sl.registerLazySingleton(() => IsCheckIn(repository: sl()));

  // ! Time Management
  sl.registerLazySingleton(() => GetShift(repository: sl()));
  sl.registerLazySingleton(() => GetTimeSchedule(repository: sl()));
  sl.registerLazySingleton(() => GetHoliday(repository: sl()));
  sl.registerLazySingleton(() => SendShiftChange(repository: sl()));
  sl.registerLazySingleton(() => WithDrawChangeTime(repository: sl()));
  sl.registerLazySingleton(() => GetCheckHoliday(repository: sl()));

  // ! WaitingStatus Manager
  sl.registerLazySingleton(() => GetLeaveRequestManager(repository: sl()));
  sl.registerLazySingleton(() => GetRequestTimeManager(repository: sl()));
  sl.registerLazySingleton(() => GetWithdrawLeaveManager(repository: sl()));
  sl.registerLazySingleton(() => GetChangeTimeManager(repository: sl()));
  sl.registerLazySingleton(() => GetPayrollSettingManager(repository: sl()));
  sl.registerLazySingleton(() => IsLeaveApprove(repository: sl()));
  sl.registerLazySingleton(() => IsRequestApprove(repository: sl()));
  sl.registerLazySingleton(() => IsChangeTimeApprove(repository: sl()));

  // ! WorkingTime Manager
  sl.registerLazySingleton(() => GetEmployeesAttendance(repository: sl()));
  sl.registerLazySingleton(() => GetEmployeesLeave(repository: sl()));
  sl.registerLazySingleton(() => GetEmployees(repository: sl()));
  sl.registerLazySingleton(() => GetAttendanceEmpDate(repository: sl()));
  sl.registerLazySingleton(() => GetReasonManager(repository: sl()));
  // sl.registerLazySingleton(() => SendTimeRequestManager(repository: sl()));

  // ! Overview Manager
  sl.registerLazySingleton(() => GetDepartment(repository: sl()));
  sl.registerLazySingleton(() => GetOverview(repository: sl()));
  sl.registerLazySingleton(() => GetOverTime(repository: sl()));
  sl.registerLazySingleton(() => GetWorkingTime(repository: sl()));
  sl.registerLazySingleton(() => GetCost(repository: sl()));

  // ! EmployeesList Manager
  sl.registerLazySingleton(() => GetEmployeesList(repository: sl()));
  sl.registerLazySingleton(() => GetEachEmployee(repository: sl()));

  // * Repository
  sl.registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImpl(loginApi: sl()));

  // ! ItemStatus
  sl.registerLazySingleton<ItemStatusRepository>(
      () => ItemStatusRepositoryImpl(remoteDataSource: sl()));

  // ! Gps
  sl.registerLazySingleton<GpsRepository>(
      () => GpsRepositoryImpl(remoteDatasource: sl()));

  // ! Employee Network
  sl.registerLazySingleton<EmployeeNetworkRepository>(
      () => EmployeeNetworkRepositoryImpl(remoteDataSource: sl()));

  // ! Leave
  sl.registerLazySingleton<LeaveRepository>(
      () => LeaveRepositoryImpl(remoteDataSource: sl()));

  // ! TimeLine
  sl.registerLazySingleton<TimeLineRepository>(
      () => TimeLineRepositoryImpl(remoteDataSource: sl()));

  // ! Time Management
  sl.registerLazySingleton<TimeManagementRepository>(
      () => TimeManagementRepositoryImpl(remoteDataSource: sl()));

  // ! Shift and OT
  sl.registerLazySingleton<ShiftAndOTRepository>(
      () => ShiftAndOtRepositoryImpl(remoteDataSource: sl()));

  // ! Travelling
  sl.registerLazySingleton<TravellingRepository>(
      () => TravellingRepositoryImpl(remoteDataSource: sl()));

  // ! Bluetooth
  sl.registerLazySingleton<BluetoothBeaconRepository>(
      () => BluetoothBeaconRepositoryImpl(remoteDatasource: sl()));

  // ! Bluetooth
  sl.registerLazySingleton<WorkingRecordRepository>(
      () => WorkingRecordRepositoryImpl(remoteDataSource: sl()));

  // ! WaitingStatus Manager
  sl.registerLazySingleton<WaitingStatusRepository>(
      () => WaitingStatusRepositoryImpl(remoteDataSource: sl()));

  // ! WorkingTime Manager
  sl.registerLazySingleton<WorkingTimeRepository>(
      () => WorkingTimeRepositoryImpl(remoteDataSource: sl()));

  // ! Overview Manager
  sl.registerLazySingleton<OverviewRepository>(
      () => OverviewRepositoryImpl(remoteDataSource: sl()));

  // ! EmployeesList Manager
  sl.registerLazySingleton<EmployeesListRepository>(
      () => EmployeesListRepositoryImpl(remoteDataSource: sl()));

  // * Data Source
  sl.registerLazySingleton<LoginApi>(() => LoginApiImpl(client: sl()));

  // ! ItemStatus
  sl.registerLazySingleton<ItemStatusRemoteDataSource>(
      () => ItemStatusRemoteDataSourceImpl(client: sl()));

  // ! GPS
  sl.registerLazySingleton<GpsRemoteDatasource>(
      () => GpsRemoteDatasourceImpl(client: sl()));

  // ! Employee Network
  sl.registerLazySingleton<EmployeeNetworkRemoteDataSource>(
      () => EmployeeNetworkRemoteDataSourceImpl(dio: sl()));

  // ! Leave
  sl.registerLazySingleton<LeaveRemoteDataSource>(
      () => LeaveRemoteDataSourceImpl(client: sl(), dio: sl()));

  // ! TimeLine
  sl.registerLazySingleton<TimeLineRemoteDataSource>(
      () => TimeLineRemoteDataSourceImpl(client: sl()));

  // ! Payslip
  sl.registerLazySingleton<PayslipRemoteDataSource>(
      () => PayslipRemoteDataSourceImpl(client: sl()));

  // ! Shift and OT
  sl.registerLazySingleton<ShiftAndOTRemoteDataSource>(
      () => ShiftAndOTRemoteDataSourceImpl(client: sl()));

  // ! Travelling
  sl.registerLazySingleton<TravellingRemoteDataSource>(
      () => TravellingRemoteDataSourceImpl(dio: sl()));

  // ! Bluetooth
  sl.registerLazySingleton<BluetoothBeaconRemoteDatasource>(
      () => BluetoothBeaconRemoteDatasourceImpl(client: sl()));

  // ! Bluetooth
  sl.registerLazySingleton<WorkingRecordRemoteDataSource>(
      () => WorkingRecordRemoteDataSourceImpl(client: sl()));

  // ! Time Management
  sl.registerLazySingleton<TimeManagementRemoteDataSource>(
      () => TimeManagementRemoteDataSourceImpl(dio: sl()));

  // ! WaitingStatus Manager
  sl.registerLazySingleton<WaitingStatusRemoteDataSource>(
      () => WaitingStatusRemoteDataSourceImpl(client: sl()));

  // ! WorkingTime Manager
  sl.registerLazySingleton<WorkingTimeRemoteDataSource>(
      () => WorkingTimeRemoteDataSourceImpl(client: sl()));

  // ! Overview Manager
  sl.registerLazySingleton<OverviewRemoteDataSource>(
      () => OverviewRemoteDataSourceImpl(dio: sl()));

  // ! EmployeesList Manager
  sl.registerLazySingleton<EmployeesListRemoteDataSource>(
      () => EmployeesListRemoteDataSourceImpl(dio: sl()));

  // * External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Dio());
}
