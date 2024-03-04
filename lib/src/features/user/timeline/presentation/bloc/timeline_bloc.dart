import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/features/profile/domain/entity/profile_entity.dart';
import '../../domain/entities/entities.dart';
import '../../domain/use_cases/usecases.dart';

part 'timeline_event.dart';
part 'timeline_state.dart';

class TimelineBloc extends Bloc<TimelineEvent, TimelineState> {
  final GetAttendanceByDate getAttendanceByDate;
  final GetReason getReason;
  final GetEvents getEvents;
  final SendTimeRequest sendTimeRequest;
  final GetPayrollSettingTimeLine getPayrollSettingTimeLine;
  TimelineBloc({
    required this.getAttendanceByDate,
    required this.getReason,
    required this.getEvents,
    required this.sendTimeRequest,
    required this.getPayrollSettingTimeLine,
  }) : super(TimelineInitial()) {
    on<GetTimeLineData>((event, emit) async {
      emit(state.copyWith(status: FetchStatus.fetching,currentTime: DateTime.now(),));
      List<TimeLineEntity> data = [];
      List<String> reasonsData = [];
      List<ReasonEntity> reasonAllData = [];
      PayrollSetting? payrollData;
      String startDate = DateFormat("yyyy-MM-dd").format(event.startDate);
      String endDate = DateFormat("yyyy-MM-dd").format(event.endDate);

      var response = await getAttendanceByDate(startDate, endDate);
      var reasons = await getReason(event.idCompany);
      var payroll = await getPayrollSettingTimeLine();
      response.fold(
          (l) => emit(state.copyWith(status: FetchStatus.failed, error: l,currentTime: DateTime.now(),)),
          (r) {
        data = r;
      });
      reasons.fold(
          (l) => emit(state.copyWith(status: FetchStatus.failed, error: l,currentTime: DateTime.now(),)),
          (r) {
        reasonAllData = r;
        reasonsData = r
            .map((e) => e.name)
            .where((name) => name != null)
            .toList()
            .cast<String>();
      });
      payroll.fold(
          (l) => emit(state.copyWith(status: FetchStatus.failed, error: l,currentTime: DateTime.now(),)),
          (r) => payrollData = r);
      if(data.isNotEmpty && payrollData != null && reasonsData.isNotEmpty){
        emit(state.copyWith(
          status: FetchStatus.success,
          attendanceData: data,
          showingData: data.sublist(1, data.length - 1),
          events: getEvents(data.sublist(1, data.length - 1)),
          reasons: reasonsData,
          reasonAllData: reasonAllData,
          payrollData: payrollData,
          currentTime: DateTime.now(),
        ));
      }else{
        emit(state.copyWith(status: FetchStatus.failed,currentTime: DateTime.now(),));
      }
    });

    on<SendTimeRequestData>((event, emit) async {
      emit(state.copyWith(status: FetchStatus.fetching));
      var response = await sendTimeRequest(
        event.result,
        event.amountHour,
        event.idEmployee,
        event.idRequestType,
        event.requestReason,
        event.otherReason,
        event.start,
        event.end,
        event.workEndDate,
        event.note,
        event.profileData,
        event.reasonAllData,
      );
      response.fold(
          (l) => emit(state.copyWith(status: FetchStatus.failed, error: l)),
          (r) {
        emit(state.copyWith(status: FetchStatus.success, duplicateErr: r));
      });
    });
  }
}
