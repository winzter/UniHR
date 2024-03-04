import 'package:equatable/equatable.dart';

class PayrollSettingEntity extends Equatable{
  final int? idPayrollSetting;
  final int? idCompany;
  final double? xWorkingDailyHoliday;
  final double? xWorkingMonthlyHoliday;
  final double? xOt;
  final double? xOtHoliday;
  final double? morningShiftFee;
  final double? afternoonShiftFee;
  final double? nightShiftFee;
  final int? delayTimes;
  final dynamic decimalRounding;
  final dynamic decimalNumber;
  final dynamic paymentRound;
  final dynamic firstCutRoundDate;
  final dynamic firstCutOff;
  final dynamic firstCutOffNextMonth;
  final dynamic secondCutOff;
  final dynamic firstRoundOt;
  final dynamic firstRoundLateAbsentLeave;
  final dynamic firstPayDate;
  final dynamic firstPayDateNextMonth;
  final dynamic secondPayDate;
  final dynamic earlyCheckIn;
  final dynamic isLeavePayResign;
  final int? firstPayslipDate;
  final String? firstPayslipTime;
  final dynamic firstPayslipNextMonth;
  final dynamic fitstPaysilpPublicType;
  final dynamic secondPayslipDate;
  final dynamic secondPayslipTime;
  final dynamic firstAddition;
  final dynamic secondAddition;
  final dynamic firstDeduction;
  final dynamic secondDeduction;
  final int? isPayShift;
  final dynamic lateDockSalary;
  final dynamic lateSso;
  final dynamic lateTax;
  final dynamic latePf;
  final dynamic absentDockSalary;
  final dynamic absentSso;
  final dynamic absentTax;
  final dynamic absentPf;
  final dynamic calculateOt;
  final dynamic otSso;
  final dynamic otTax;
  final dynamic otPf;
  final dynamic calculateShiftFee;
  final dynamic shiftFeeSso;
  final dynamic shiftFeeTax;
  final dynamic shiftFeePf;
  final dynamic calculateDiligence;
  final dynamic diligenceMethod;
  final dynamic diligenceSso;
  final dynamic diligenceTax;
  final dynamic diligencePf;
  final List<dynamic>? payment;

  const PayrollSettingEntity({
    this.idPayrollSetting,
    this.idCompany,
    this.xWorkingDailyHoliday,
    this.xWorkingMonthlyHoliday,
    this.xOt,
    this.xOtHoliday,
    this.morningShiftFee,
    this.afternoonShiftFee,
    this.nightShiftFee,
    this.delayTimes,
    this.decimalRounding,
    this.decimalNumber,
    this.paymentRound,
    this.firstCutRoundDate,
    this.firstCutOff,
    this.firstCutOffNextMonth,
    this.secondCutOff,
    this.firstRoundOt,
    this.firstRoundLateAbsentLeave,
    this.firstPayDate,
    this.firstPayDateNextMonth,
    this.secondPayDate,
    this.earlyCheckIn,
    this.isLeavePayResign,
    this.firstPayslipDate,
    this.firstPayslipTime,
    this.firstPayslipNextMonth,
    this.fitstPaysilpPublicType,
    this.secondPayslipDate,
    this.secondPayslipTime,
    this.firstAddition,
    this.secondAddition,
    this.firstDeduction,
    this.secondDeduction,
    this.isPayShift,
    this.lateDockSalary,
    this.lateSso,
    this.lateTax,
    this.latePf,
    this.absentDockSalary,
    this.absentSso,
    this.absentTax,
    this.absentPf,
    this.calculateOt,
    this.otSso,
    this.otTax,
    this.otPf,
    this.calculateShiftFee,
    this.shiftFeeSso,
    this.shiftFeeTax,
    this.shiftFeePf,
    this.calculateDiligence,
    this.diligenceMethod,
    this.diligenceSso,
    this.diligenceTax,
    this.diligencePf,
    this.payment,});

  @override
  List<Object?> get props => [
    idPayrollSetting,
    idCompany,
    xWorkingDailyHoliday,
    xWorkingMonthlyHoliday,
    xOt,
    xOtHoliday,
    morningShiftFee,
    afternoonShiftFee,
    nightShiftFee,
    delayTimes,
    decimalRounding,
    decimalNumber,
    paymentRound,
    firstCutRoundDate,
    firstCutOff,
    firstCutOffNextMonth,
    secondCutOff,
    firstRoundOt,
    firstRoundLateAbsentLeave,
    firstPayDate,
    firstPayDateNextMonth,
    secondPayDate,
    earlyCheckIn,
    isLeavePayResign,
    firstPayslipDate,
    firstPayslipTime,
    firstPayslipNextMonth,
    fitstPaysilpPublicType,
    secondPayslipDate,
    secondPayslipTime,
    firstAddition,
    secondAddition,
    firstDeduction,
    secondDeduction,
    isPayShift,
    lateDockSalary,
    lateSso,
    lateTax,
    latePf,
    absentDockSalary,
    absentSso,
    absentTax,
    absentPf,
    calculateOt,
    otSso,
    otTax,
    otPf,
    calculateShiftFee,
    shiftFeeSso,
    shiftFeeTax,
    shiftFeePf,
    calculateDiligence,
    diligenceMethod,
    diligenceSso,
    diligenceTax,
    diligencePf,
    payment,
  ];
}