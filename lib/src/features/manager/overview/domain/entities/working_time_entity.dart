import 'package:equatable/equatable.dart';

class WorkingTimeEntity extends Equatable {
  final int? employeeTotal;
  final WorkingTimeEmployeeInfo? workingTimeEmployeeInfo;

  WorkingTimeEntity({
    this.employeeTotal,
    this.workingTimeEmployeeInfo,
  });

  @override
  List<Object?> get props => [employeeTotal, workingTimeEmployeeInfo];
}

class WorkingTimeEmployeeInfo extends Equatable {
  final List<Leave>? leave;
  final int? leaveTotal;
  final int? lateTotal;
  final int? absentTotal;
  final List<Top5Employee>? top5LateEmployees;
  final List<Top5Employee>? top5AbsentEmployees;

  WorkingTimeEmployeeInfo({
    this.leave,
    this.leaveTotal,
    this.lateTotal,
    this.absentTotal,
    this.top5LateEmployees,
    this.top5AbsentEmployees,
  });

  @override
  List<Object?> get props => [
        leave,
        leaveTotal,
        lateTotal,
        absentTotal,
        top5LateEmployees,
        top5AbsentEmployees,
      ];
}

class Leave extends Equatable {
  final int? idLeave;
  final int? idLeaveType;
  final String? name;
  final String? description;
  final DateTime? start;
  final String? startText;
  final DateTime? end;
  final String? endText;
  final int? isFullDay;
  final String? firstnameTh;
  final String? lastnameTh;
  final String? imageProfile;

  Leave({
    this.idLeave,
    this.idLeaveType,
    this.name,
    this.description,
    this.start,
    this.startText,
    this.end,
    this.endText,
    this.isFullDay,
    this.firstnameTh,
    this.lastnameTh,
    this.imageProfile,
  });

  @override
  List<Object?> get props => [
        idLeave,
        idLeaveType,
        name,
        description,
        start,
        startText,
        end,
        endText,
        isFullDay,
        firstnameTh,
        lastnameTh,
        imageProfile,
      ];
}

class Top5Employee extends Equatable {
  final int? idEmployees;
  final String? firstnameTh;
  final String? lastnameTh;
  final String? firstname_EN;
  final String? lastname_EN;
  final String? imageName;
  final int? lateTotal;
  final int? absentTotal;
  final String? imageProfile;

  Top5Employee({
    this.idEmployees,
    this.firstnameTh,
    this.lastnameTh,
    this.firstname_EN,
    this.lastname_EN,
    this.imageName,
    this.lateTotal,
    this.absentTotal,
    this.imageProfile,
  });

  @override
  List<Object?> get props => [
        idEmployees,
        firstnameTh,
        lastnameTh,
        firstname_EN,
        lastname_EN,
        imageName,
        lateTotal,
        absentTotal,
        imageProfile,
      ];
}
