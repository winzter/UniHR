import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unihr/src/core/features/attendance/data/data_sources/remote/attendance_remote_datasource.dart';
import 'package:unihr/src/core/features/attendance/data/repositories/attendance_repository_impl.dart';
import 'package:unihr/src/core/features/attendance/domain/use_cases/get_attendance.dart';
import 'package:unihr/src/core/features/attendance/presentation/provider/attendance_provider.dart';
import 'package:unihr/src/core/features/profile/data/datasource/remote/profile_remote_data_source.dart';
import 'package:unihr/src/core/features/profile/data/repository/profile_repository_impl.dart';
import 'package:unihr/src/core/features/profile/domain/usecase/get_profile.dart';
import 'package:unihr/src/core/features/profile/presentation/provider/profile_provider.dart';
import 'package:unihr/src/core/provider/bottom_navbar/bottom_navbar_provider.dart';
import 'package:http/http.dart' as http;
import 'package:unihr/src/features/manager/waiting_status/presentation/providers/radio_button_provider.dart';
import 'package:unihr/src/features/user/item_status/domain/use_cases/use_cases.dart';
import 'src/features/user/edit_profile/data/data_sources/remote/edit_profile_remote_data_source.dart';
import 'src/features/user/edit_profile/data/repositories/profile_repository_impl.dart';
import 'src/features/user/edit_profile/domain/usecases/use_cases.dart';
import 'src/features/user/edit_profile/presentation/provider/edit_profile_provider.dart';
import 'src/features/user/home/presentation/provider/leave_provider.dart';
import 'src/features/user/item_status/data/data_sources/remote/item_status_remote_datasource.dart';
import 'src/features/user/item_status/data/repositories/item_status_repository_impl.dart';
import 'src/features/user/item_status/presentation/providers/radio_button_provider.dart';
import 'src/features/user/payslip/data/data_sources/remote/payslip_remote_data_source.dart';
import 'src/features/user/payslip/data/repositories/payslip_repository_impl.dart';
import 'src/features/user/payslip/domain/usecases/get_payslip.dart';
import 'src/features/user/payslip/presentation/provider/payslip_provider.dart';
import 'src/features/user/shift_ot/data/data_sources/remote/shift_ot_remote_datasource.dart';
import 'src/features/user/shift_ot/data/repositories/shift_ot_repository_impl.dart';
import 'src/features/user/shift_ot/domain/use_cases/get_shift_ot.dart';
import 'src/features/user/shift_ot/presentation/provider/shift_ot_provider.dart';

class Injection extends StatelessWidget {
  final Widget? router;
  const Injection({super.key, this.router});

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => NavIndex()),
          ChangeNotifierProvider(create: (context) => RadioButtonProvider()),
          ChangeNotifierProvider(
              create: (context) => ManagerRadioButtonProvider()),
          // ChangeNotifierProvider(create: (context) => SwitchModeProvider()),

          // * Profile
          ChangeNotifierProvider(
              create: (context) => ProfileProvider(
                  getProfile: GetProfile(
                      repository: ProfileRepositoryImpl(
                          remoteDataSource: ProfileRemoteDataSourceImpl(
                              client: http.Client()))))),

          // * Attendance
          ChangeNotifierProvider(
              create: (context) => AttendanceProvider(
                  getAttendance: GetAttendance(
                      repository: AttendanceRepositoryImpl(
                          remoteDataSource: AttendanceRemoteDataSourceImpl(
                              client: http.Client()))))),

          // * Payslip
          ChangeNotifierProvider(
              create: (_) => GetPayslipProvider(
                  getPayslip: GetPayslip(
                      repository: PayslipRepositoryImpl(
                          remoteDataSource: PayslipRemoteDataSourceImpl(
                              client: http.Client()))))),

          // * Edit Profile
          ChangeNotifierProvider(
              create: (_) => EditProfileProvider(
                    sendEditPhoneNumber: SendEditPhoneNumber(
                        EditProfileRepositoryImpl(
                            chRemoteDataSource: EditProfileRemoteDataSourceImpl(
                                client: http.Client()))),
                    sendEditAddress: SendEditAddress(EditProfileRepositoryImpl(
                        chRemoteDataSource: EditProfileRemoteDataSourceImpl(
                            client: http.Client()))),
                    sendEditEmergencyContract: SendEditEmergencyContract(
                        EditProfileRepositoryImpl(
                            chRemoteDataSource: EditProfileRemoteDataSourceImpl(
                                client: http.Client()))),
                    changePassword: ChangePassword(
                        chRepository: EditProfileRepositoryImpl(
                            chRemoteDataSource: EditProfileRemoteDataSourceImpl(
                                client: http.Client()))),
                  )),

          // * Shift And OT
          ChangeNotifierProvider(
              create: (_) => GetShiftAndOTProvider(
                  getSummaryShiftAndOt: GetShiftAndOT(
                      repository: ShiftAndOtRepositoryImpl(
                          remoteDataSource: ShiftAndOTRemoteDataSourceImpl(
                              client: http.Client()))))),
          /* * Manager * */
          // ChangeNotifierProvider(
          //     create: (context) => ProfileProvider(
          //         getManagerProfile: GetManagerProfile(
          //             repository: ManagerProfileRepositoryImpl(
          //                 remoteDataSource: ManagerProfileRemoteDataSourceImpl(
          //                     client: http.Client()))))),

          ChangeNotifierProvider(
              create: (_) => WaitingProvider(
                  getLeaveData: GetLeaveData(
                      repository: ItemStatusRepositoryImpl(
                          remoteDataSource: ItemStatusRemoteDataSourceImpl(
                              client: http.Client()))),
                  getRequestTimeData: GetRequestTimeData(
                      repository: ItemStatusRepositoryImpl(
                          remoteDataSource: ItemStatusRemoteDataSourceImpl(
                              client: http.Client()))))),
        ],
        child: router,
      );
}
