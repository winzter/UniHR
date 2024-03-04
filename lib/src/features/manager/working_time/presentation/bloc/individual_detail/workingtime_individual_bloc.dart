import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../core/error/failures.dart';
import '../../../../../user/timeline/domain/entities/timeline_entity.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/use_cases/usecases.dart';

part 'workingtime_individual_event.dart';
part 'workingtime_individual_state.dart';

class WorkingTimeIndividualBloc extends Bloc<WorkingTimeIndividualEvent, WorkingTimeIndividualState> {

  final GetEmployees getEmployees;
  final GetAttendanceEmpDate getAttendanceEmpDate;
  final GetReasonManager getReasonManager;
  // final SendTimeRequestManager sendTimeRequestManager;

  WorkingTimeIndividualBloc({
    required this.getEmployees,
    // required this.sendTimeRequestManager,
    required this.getAttendanceEmpDate,
    required this.getReasonManager
  }) :
        super(WorkingTimeIndividualInitial(empData: [], empAttendanceData: [], reasons: [])) {

    on<GetEmployeesData>((event, emit) async{
      List<EmployeesEntity> empData = [];
      emit(WorkingTimeIndividualLoading(
          empData: state.empData,
          empAttendanceData: state.empAttendanceData,
          reasons: state.reasons));
      var res = await getEmployees();
      res.fold((l) => emit(WorkingTimeIndividualFailure(
          empData: state.empData,
          error: l,
          empAttendanceData: state.empAttendanceData,
          reasons: state.reasons)),
              (r) => empData = r);
      var resReasons = await getReasonManager();
      resReasons.fold(
              (l) => emit(WorkingTimeIndividualFailure(
                  empData: state.empData,
                  error: l,
                  empAttendanceData: state.empAttendanceData,
                  reasons: state.reasons)),
              (r) => emit(WorkingTimeIndividualLoaded(
                  empData: empData,
                  empAttendanceData: state.empAttendanceData,
                  reasons: r.map((e) => e.name).where((name) => name != null).toList().cast<String>(),
                  showingData: [],
                  idEmp: null)));
    });

    on<GetAttendanceEmpDateData>((event, emit) async{
      emit(WorkingTimeIndividualLoading(
          empData: state.empData,
          empAttendanceData: state.empAttendanceData,
          reasons: state.reasons,));
      var res = await getAttendanceEmpDate(event.id,event.start,event.end);
      res.fold((l) => emit(WorkingTimeIndividualFailure(
          empData: state.empData,
          error: l,
          empAttendanceData: state.empAttendanceData,
          reasons: state.reasons)),
              (r) => emit(WorkingTimeIndividualLoaded(
                  empData: state.empData,
                  empAttendanceData: r,
                  reasons: state.reasons,
                  showingData: r.sublist(
                      1,r.length-1),
                  idEmp: event.id)));
    });

    // on<SendTimeRequestData>((event, emit) async{
    //   emit(WorkingTimeIndividualLoading(
    //       empData: state.empData,
    //       empAttendanceData: state.empAttendanceData,
    //       reasons: state.reasons));
    //   var response = await sendTimeRequestManager(
    //       event.result,
    //       event.idEmployee,
    //       event.idRequestType,
    //       event.requestReason,
    //       event.otherReason,
    //       event.start,
    //       event.end,
    //       event.workEndDate,
    //       event.note,
    //       event.profileData
    //   );
    //   response.fold(
    //           (l) => emit(WorkingTimeIndividualFailure(error: l, reasons: state.reasons, empData: state.empData, empAttendanceData: state.empAttendanceData)),
    //           (r) => emit(SendTimeRequestSuccess(empData: state.empData, empAttendanceData: state.empAttendanceData, reasons: state.reasons)));
    // });

  }
}
