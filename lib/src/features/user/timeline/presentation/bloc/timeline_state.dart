part of 'timeline_bloc.dart';

enum FetchStatus { fetching, success, failed, init }

class TimelineState extends Equatable {
  final List<String> reasons;
  final PayrollSetting? payrollData;
  final List<TimeLineEntity> attendanceData;
  final List<ReasonEntity> reasonAllData;
  final List<TimeLineEntity> showingData;
  final Map<String, List<String>> events;
  final List<String> selectedEvents = [
    "วันหยุดประจำปี",
    "ทำงานล่วงเวลา",
    "ขอรับรองเวลาทำงาน",
    "ขอลางาน",
    "ขาดงาน",
  ];
  final ErrorMessage? error;
  final ErrorTimeLine? duplicateErr;
  final FetchStatus status;
  final DateTime? currentTime;

  TimelineState({
    this.reasons = const [],
    this.payrollData = null,
    this.attendanceData = const [],
    this.reasonAllData = const [],
    this.showingData = const [],
    this.events = const {},
    this.error = null,
    this.duplicateErr = null,
    this.status = FetchStatus.init,
    this.currentTime = null,
  });

  TimelineState copyWith({
    List<String>? reasons,
    PayrollSetting? payrollData,
    List<TimeLineEntity>? attendanceData,
    List<ReasonEntity>? reasonAllData,
    List<TimeLineEntity>? showingData,
    Map<String, List<String>>? events,
    ErrorMessage? error,
    ErrorTimeLine? duplicateErr,
    FetchStatus? status,
    DateTime? currentTime,
  }) {
    return TimelineState(
      reasons: reasons ?? this.reasons,
      payrollData: payrollData ?? this.payrollData,
      attendanceData: attendanceData ?? this.attendanceData,
      reasonAllData: reasonAllData ?? this.reasonAllData,
      showingData: showingData ?? this.showingData,
      events: events ?? this.events,
      error: error ?? this.error,
      duplicateErr: duplicateErr ?? this.duplicateErr,
      status: status ?? this.status,
      currentTime: currentTime ?? this.currentTime,
    );
  }

  @override
  List<Object?> get props => [
        reasons,
        payrollData,
        attendanceData,
        reasonAllData,
        showingData,
        events,
        error,
        duplicateErr,
        currentTime,
      ];
}

class TimelineInitial extends TimelineState {
  @override
  List<Object?> get props => [];
}
