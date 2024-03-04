import 'package:equatable/equatable.dart';

class ShiftAndOtEntity extends Equatable{
  final DateTime? start;
  final DateTime? end;
  final int? idPaymentType;
  final DockEntity? dock;
  final int? isShiftFee;
  final List<DataTableEntity>? dataTable;
  final RateEntity? rate;

  ShiftAndOtEntity({
    this.start,
    this.end,
    this.idPaymentType,
    this.dock,
    this.dataTable,
    this.rate,
    this.isShiftFee,
  });

  @override
  List<Object?> get props => [
    start,
    end,
    idPaymentType,
    dock,
    dataTable,
    rate,
    isShiftFee,
  ];

}

class DataTableEntity extends Equatable{
  final String? date;
  final double? otOneHours;
  final double? otOneAmount;
  final double? otOneFiveHours;
  final double? otOneFiveAmount;
  final double? otTwoHours;
  final double? otTwoAmount;
  final double? otThreeHours;
  final double? otThreeAmount;
  final DataRenderEntity? dataRender;
  final double? shiftPayMorning;
  final double? shiftPayAfternoon;
  final double? shiftPayNight;
  final double? shiftPayTotal;

  DataTableEntity({
    this.date,
    this.otOneHours,
    this.otOneAmount,
    this.otOneFiveHours,
    this.otOneFiveAmount,
    this.otTwoHours,
    this.otTwoAmount,
    this.otThreeHours,
    this.otThreeAmount,
    this.dataRender,
    this.shiftPayMorning,
    this.shiftPayAfternoon,
    this.shiftPayNight,
    this.shiftPayTotal,
  });

  @override
  List<Object?> get props => [
    date,
    otOneHours,
    otOneAmount,
    otOneFiveHours,
    otOneFiveAmount,
    otTwoHours,
    otTwoAmount,
    otThreeHours,
    otThreeAmount,
    dataRender,
    shiftPayMorning,
    shiftPayAfternoon,
    shiftPayNight,
    shiftPayTotal,
  ];

}

class DataRenderEntity extends Equatable{
  final int? idShiftPattern;
  final int? indexScheduleId;
  final int? idShift;
  final String? shiftName;
  final int? idShiftType;
  final String? shiftTypeName;
  final String? timeIn;
  final String? timeOut;
  final int? breakTime;
  final int? isWorkingDay;
  final int? lateIn;
  final int? workingHours;
  final int? period;
  final int? idShiftGroup;
  final String? shiftGroupName;
  final int? shiftStartInMonday;
  final DateTime? shiftStartDate;
  final int? shiftNumber;
  final int? workDay;
  final int? isTimeFrame;
  final int? idWorkingType;
  final String? workingTypeName;

  DataRenderEntity({
    this.idShiftPattern,
    this.indexScheduleId,
    this.idShift,
    this.shiftName,
    this.idShiftType,
    this.shiftTypeName,
    this.timeIn,
    this.timeOut,
    this.breakTime,
    this.isWorkingDay,
    this.lateIn,
    this.workingHours,
    this.period,
    this.idShiftGroup,
    this.shiftGroupName,
    this.shiftStartInMonday,
    this.shiftStartDate,
    this.shiftNumber,
    this.workDay,
    this.isTimeFrame,
    this.idWorkingType,
    this.workingTypeName,
  });

  @override
  List<Object?> get props => [
    idShiftPattern,
    indexScheduleId,
    idShift,
    shiftName,
    idShiftType,
    shiftTypeName,
    timeIn,
    timeOut,
    breakTime,
    isWorkingDay,
    lateIn,
    workingHours,
    period,
    idShiftGroup,
    shiftGroupName,
    shiftStartInMonday,
    shiftStartDate,
    shiftNumber,
    workDay,
    isTimeFrame,
    idWorkingType,
    workingTypeName,
  ];

}

class DockEntity extends Equatable{
  final DateTime? start;
  final DateTime? end;
  final AbsentEntity? lateEarly;
  final AbsentEntity? absent;

  DockEntity({
    this.start,
    this.end,
    this.lateEarly,
    this.absent,
  });

  @override
  List<Object?> get props => [
    start,
    end,
    lateEarly,
    absent,
  ];
}

class AbsentEntity extends Equatable{
  final int? value;
  final int? amount;

  AbsentEntity({
    this.value,
    this.amount,
  });

  @override
  List<Object?> get props => [
    value,
    amount,
  ];
}

class RateEntity extends Equatable{
  final double? manDay;
  final double? otRate;
  final double? proRate;

  RateEntity({
    this.manDay,
    this.otRate,
    this.proRate,
  });

  @override
  List<Object?> get props => [
    manDay,
    otRate,
    proRate,
  ];
}
