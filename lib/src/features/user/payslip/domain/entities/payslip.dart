import 'package:equatable/equatable.dart';

class PayslipEntity extends Equatable {
  final String? employeeId;
  final String? titleTh;
  final String? firstnameTh;
  final String? lastnameTh;
  final String? bookId;
  final int? idPosition;
  final String? positionName;
  final dynamic idDepartment;
  final String? departmentName;
  final int? idPayrunDetail;
  final int? idPayrun;
  final int? idEmployees;
  final int? workingDay;
  final int? absence;
  final double? additionsTaxable;
  final double? additionsNonTaxable;
  final double? totalOt;
  final double? totalEarnings;
  final double? deductionTaxable;
  final double? deductionNonTaxable;
  final double? totalDeductions;
  final double? net;
  final double? otOneHours;
  final double? otOneFiveHours;
  final double? otTwoHours;
  final double? otThreeHours;
  final dynamic paymentType;
  final DateTime? monthPeriod;
  final String? payDate;
  final dynamic isCheck;
  final int? idCompany;
  final double? totalShiftPay;
  final double? accumulateEarnings;
  final double? accumulateTax;
  final double? accumulateSso;
  final double? accumulatePf;
  final DateTime? start;
  final DateTime? end;
  final String? companyName;
  final List<TionEntity>? addition;
  final List<TionEntity>? deduction;

  const PayslipEntity({
    this.employeeId,
    this.titleTh,
    this.firstnameTh,
    this.lastnameTh,
    this.bookId,
    this.idPosition,
    this.positionName,
    this.idDepartment,
    this.departmentName,
    this.idPayrunDetail,
    this.idPayrun,
    this.idEmployees,
    this.workingDay,
    this.absence,
    this.additionsTaxable,
    this.additionsNonTaxable,
    this.totalOt,
    this.totalEarnings,
    this.deductionTaxable,
    this.deductionNonTaxable,
    this.totalDeductions,
    this.net,
    this.otOneHours,
    this.otOneFiveHours,
    this.otTwoHours,
    this.otThreeHours,
    this.paymentType,
    this.monthPeriod,
    this.payDate,
    this.isCheck,
    this.idCompany,
    this.totalShiftPay,
    this.accumulateEarnings,
    this.accumulateTax,
    this.accumulateSso,
    this.accumulatePf,
    this.start,
    this.end,
    this.companyName,
    this.addition,
    this.deduction,
  });

  @override
  List<Object?> get props => [
    employeeId,
    titleTh,
    firstnameTh,
    lastnameTh,
    bookId,
    idPosition,
    positionName,
    idDepartment,
    departmentName,
    idPayrunDetail,
    idPayrun,
    idEmployees,
    workingDay,
    absence,
    additionsTaxable,
    additionsNonTaxable,
    totalOt,
    totalEarnings,
    deductionTaxable,
    deductionNonTaxable,
    totalDeductions,
    net,
    otOneHours,
    otOneFiveHours,
    otTwoHours,
    otThreeHours,
    paymentType,
    monthPeriod,
    payDate,
    isCheck,
    idCompany,
    totalShiftPay,
    accumulateEarnings,
    accumulateTax,
    accumulateSso,
    accumulatePf,
    start,
    end,
    companyName,
    addition,
    deduction,
      ];
}

class TionEntity extends Equatable {
  final int? idPayrunDetailMain;
  final int? idEmployees;
  final int? idPayrunDetail;
  final int? idPayrollType;
  final double? value;
  final DateTime? payround;
  final dynamic valueHour;
  final dynamic valueActual;
  final int? idPayrun;
  final String? name;
  final int? isAddition;
  final String? payroundText;
  final int? idPayrunDetailAddition;
  final int? idAddition;

  const TionEntity({
    this.idPayrunDetailMain,
    this.idEmployees,
    this.idPayrunDetail,
    this.idPayrollType,
    this.value,
    this.payround,
    this.valueHour,
    this.valueActual,
    this.idPayrun,
    this.name,
    this.isAddition,
    this.payroundText,
    this.idPayrunDetailAddition,
    this.idAddition,
  });

  @override
  List<Object?> get props => [
    idPayrunDetailMain,
    idEmployees,
    idPayrunDetail,
    idPayrollType,
    value,
    payround,
    valueHour,
    valueActual,
    idPayrun,
    name,
    isAddition,
    payroundText,
    idPayrunDetailAddition,
    idAddition,
      ];
}
