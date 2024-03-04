import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:unihr/src/features/manager/overview/domain/entities/cost_entity.dart';
import '../../../../../core/error/failures.dart';
import '../../domain/entities/entities.dart';
import '../../domain/use_cases/use_cases.dart';

part 'overview_event.dart';

part 'overview_state.dart';

class OverviewBloc extends Bloc<OverviewEvent, OverviewState> {
  final GetDepartment getDepartment;
  final GetOverview getOverview;
  final GetOverTime getOverTime;

  final GetWorkingTime getWorkingTime;
  final GetCost getCost;

  OverviewBloc({
    required this.getOverview,
    required this.getDepartment,
    required this.getOverTime,
    required this.getWorkingTime,
    required this.getCost,
  }) : super(OverviewInitial()) {
    on<GetDepartmentData>((event, emit) async {
      Map<int, String> divisionName = {999: "ทั้งหมด"};
      Map<int, String> departmentName = {999: "ทั้งหมด"};
      Map<int, String> sectionName = {999: "ทั้งหมด"};
      emit(state.copyWith(
        status: FetchStatus.fetching,
      ));
      Either<ErrorMessage, List<DepartmentEntity>> res = await getDepartment();
      res.fold(
          (l) => emit(state.copyWith(status: FetchStatus.failed, error: l)),
          (r) {
        for (var i in r) {
          if (i.idDivision != null) {
            divisionName[i.idDivision] = i.divisionName;
          } else if (i.idDepartment != null) {
            departmentName[i.idDepartment!] = i.departmentName!;
          } else {
            for (var j in i.sections!) {
              if (j.idSection != null) {
                sectionName[j.idSection!] = j.sectionName!;
              }
            }
          }
        }
        emit(state.copyWith(
          status: FetchStatus.success,
          departmentData: r,
          divisionName: divisionName,
          departmentName: departmentName,
          sectionName: sectionName,
        ));
      });
    });

    on<GetOverviewData>((event, emit) async {
      emit(state.copyWith(
        status: FetchStatus.fetching,
        selectedSectionName: state.selectedSectionName,
        selectedDivisionName: state.selectedDivisionName,
        selectedDepartmentName: state.selectedDepartmentName,
      ));
      int? idDepartment;
      int? idSection;
      state.departmentName.forEach((key, value) {
        if (state.selectedDepartmentName == value) {
          idDepartment = key;
        }
      });
      state.sectionName.forEach((key, value) {
        if (state.selectedSectionName == value) {
          idSection = key;
        }
      });
      Either<ErrorMessage, OverviewEntity> res = await getOverview(
        event.month,
        event.year,
        idDepartment,
        idSection,
      );
      res.fold(
          (ErrorMessage l) =>
              emit(state.copyWith(status: FetchStatus.failed, error: l)),
          (OverviewEntity r) => emit(state.copyWith(
                status: FetchStatus.success,
                overviewData: r,
                selectedSectionName: state.selectedSectionName,
                selectedDivisionName: state.selectedDivisionName,
                selectedDepartmentName: state.selectedDepartmentName,
              )));
    });

    on<ChangeDate>((event, emit) async {
      emit(state.copyWith(
        date: event.date,
        selectedSectionName: state.selectedSectionName,
        selectedDivisionName: state.selectedDivisionName,
        selectedDepartmentName: state.selectedDepartmentName,
      ));
    });

    on<GetOvertimeData>((event, emit) async {
      emit(state.copyWith(status: FetchStatus.fetching));
      Either<ErrorMessage, OvertimeEntity> res = await getOverTime(
          event.month, event.year, event.idDepartment, event.idSection);
      res.fold(
          (l) => emit(state.copyWith(status: FetchStatus.failed, error: l)),
          (r) => emit(state.copyWith(
                status: FetchStatus.success,
                overtimeData: r,
                selectedSectionName: state.selectedSectionName,
                selectedDivisionName: state.selectedDivisionName,
                selectedDepartmentName: state.selectedDepartmentName,
              )));
    });

    on<GetWorkingTimeData>((event, emit) async {
      emit(state.copyWith(status: FetchStatus.fetching));
      Either<ErrorMessage, WorkingTimeEntity> res = await getWorkingTime(
          event.month, event.year, event.idDepartment, event.idSection);
      res.fold(
          (l) => emit(state.copyWith(status: FetchStatus.failed, error: l)),
          (r) => emit(state.copyWith(
                status: FetchStatus.success,
                workingTimeData: r,
                selectedSectionName: state.selectedSectionName,
                selectedDivisionName: state.selectedDivisionName,
                selectedDepartmentName: state.selectedDepartmentName,
              )));
    });

    on<GetCostData>((event, emit) async {
      emit(state.copyWith(status: FetchStatus.fetching));
      Either<ErrorMessage, CostEntity> res = await getCost(
          event.month, event.year, event.idDepartment, event.idSection);
      res.fold(
          (l) => emit(state.copyWith(status: FetchStatus.failed, error: l)),
          (r) => emit(state.copyWith(
                status: FetchStatus.success,
                costData: r,
                selectedSectionName: state.selectedSectionName,
                selectedDivisionName: state.selectedDivisionName,
                selectedDepartmentName: state.selectedDepartmentName,
              )));
    });

    on<DivisionChange>((event, emit) async {
      Map<int, String> newDepartmentName = {999: "ทั้งหมด"};
      if (event.divisionName != "ทั้งหมด") {
        int? divisionKey;
        state.divisionName.forEach((key, value) {
          if (value == event.divisionName) {
            divisionKey = key;
          }
        });
        if (divisionKey != null) {
          for (var i in state.departmentData) {
            if (divisionKey == i.idDivision && i.idDepartment != null) {
              newDepartmentName[i.idDepartment!] = i.departmentName!;
            }
          }
        }
        emit(state.copyWith(
            departmentName: newDepartmentName,
            selectedDivisionName: event.divisionName));
      } else {
        emit(state.copyWith(
            departmentName: state.departmentName,
            selectedDivisionName: event.divisionName));
      }
    });

    on<DepartmentChange>((event, emit) async {
      Map<int, String> newSectionName = {999: "ทั้งหมด"};
      if (event.departmentName != "ทั้งหมด") {
        int? departmentKey;

        state.departmentName.forEach((key, value) {
          if (value == event.departmentName) {
            departmentKey = key;
          }
        });
        if (departmentKey != null) {
          for (var i in state.departmentData) {
            if (i.sections!.isNotEmpty) {
              for (var j in i.sections!) {
                if (departmentKey == i.idDepartment && j.idSection != null) {
                  newSectionName[j.idSection!] = j.sectionName!;
                }
              }
            }
          }
        }
        emit(state.copyWith(
          sectionName: newSectionName,
          selectedDepartmentName: event.departmentName,
          selectedDivisionName: state.selectedDivisionName,
        ));
      } else {
        emit(state.copyWith(
          sectionName: state.sectionName,
          selectedDepartmentName: event.departmentName,
          selectedDivisionName: state.selectedDivisionName,
        ));
      }
    });

    on<SectionChange>((event, emit) async {
      emit(state.copyWith(
        selectedSectionName: event.sectionName,
        selectedDepartmentName: state.selectedDepartmentName,
        selectedDivisionName: state.selectedDivisionName,
      ));
    });

    on<SearchOverviewData>((event, emit) async {
      int? idDepartment;
      int? idSection;
      state.departmentName.forEach((key, value) {
        if (state.selectedDepartmentName == value) {
          idDepartment = key;
        }
      });
      state.sectionName.forEach((key, value) {
        if (state.selectedSectionName == value) {
          idSection = key;
        }
      });
      emit(state.copyWith(
        status: FetchStatus.fetching,
        selectedSectionName: state.selectedSectionName,
        selectedDivisionName: state.selectedDivisionName,
        selectedDepartmentName: state.selectedDepartmentName,
      ));
      Either<ErrorMessage, OverviewEntity> res = await getOverview(
          state.date!.month.toString(),
          state.date!.year.toString(),
          idDepartment,
          idSection);
      res.fold(
          (ErrorMessage l) => emit(state.copyWith(
                status: FetchStatus.failed,
                error: l,
                selectedSectionName: state.selectedSectionName,
                selectedDivisionName: state.selectedDivisionName,
                selectedDepartmentName: state.selectedDepartmentName,
              )),
          (OverviewEntity r) => emit(state.copyWith(
                status: FetchStatus.success,
                overviewData: r,
                selectedSectionName: state.selectedSectionName,
                selectedDivisionName: state.selectedDivisionName,
                selectedDepartmentName: state.selectedDepartmentName,
              )));
    });
  }
}
