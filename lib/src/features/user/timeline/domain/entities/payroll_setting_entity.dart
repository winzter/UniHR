import 'package:equatable/equatable.dart';

class PayrollSetting extends Equatable{
  final int? idPayrollSetting;
  final int? idCompany;
  final int? xWorkingDailyHoliday;
  final double? xWorkingMonthlyHoliday;
  final double? xOt;
  final int? xOtHoliday;
  final int? morningShiftFee;
  final int? afternoonShiftFee;
  final int? nightShiftFee;
  final int? delayTimes;
  final String? decimalRounding;
  final int? decimalNumber;
  final String? paymentRound;
  final int? firstCutRoundDate;
  final int? firstCutOff;
  final int? firstCutOffNextMonth;
  final dynamic secondCutOff;
  final String? firstRoundOt;
  final String? firstRoundLateAbsentLeave;
  final int? firstPayDate;
  final int? firstPayDateNextMonth;
  final dynamic secondPayDate;
  final dynamic earlyCheckIn;
  final dynamic isLeavePayResign;
  final int? firstPayslipDate;
  final String? firstPayslipTime;
  final int? firstPayslipNextMonth;
  final String? fitstPaysilpPublicType;
  final dynamic secondPayslipDate;
  final dynamic secondPayslipTime;
  final dynamic firstAddition;
  final dynamic secondAddition;
  final dynamic firstDeduction;
  final dynamic secondDeduction;
  final int? isPayShift;
  final int? lateDockSalary;
  final dynamic lateSso;
  final int? lateTax;
  final dynamic latePf;
  final int? absentDockSalary;
  final dynamic absentSso;
  final int? absentTax;
  final dynamic absentPf;
  final int? calculateOt;
  final dynamic otSso;
  final int? otTax;
  final dynamic otPf;
  final int? calculateShiftFee;
  final int? shiftFeeSso;
  final int? shiftFeeTax;
  final dynamic shiftFeePf;
  final int? calculateDiligence;
  final dynamic diligenceMethod;
  final dynamic diligenceSso;
  final dynamic diligenceTax;
  final dynamic diligencePf;
  final dynamic payDayoff;
  final List<dynamic>? payment;

  PayrollSetting({
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
    this.payDayoff,
    this.payment,
  });
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
    payDayoff,
    payment,
  ];
}
