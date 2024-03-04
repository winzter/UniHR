import 'package:equatable/equatable.dart';

class PayrollSettingEntity extends Equatable{
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
  final dynamic decimalRounding;
  final dynamic decimalNumber;
  final dynamic paymentPeriod;
  final dynamic firstCutOff;
  final dynamic secondCutOff;
  final dynamic firstPayDate;
  final dynamic secondPayDate;
  final dynamic earlyCheckIn;
  final dynamic isLeavePayResign;
  final dynamic firstPayslipDate;
  final dynamic firstPayslipTime;
  final dynamic secondPayslipDate;
  final dynamic secondPayslipTime;
  final dynamic firstAddition;
  final dynamic secondAddition;
  final dynamic firstDeduction;
  final dynamic secondDeduction;
  final List<dynamic>? payment;

  PayrollSettingEntity({
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
    this.paymentPeriod,
    this.firstCutOff,
    this.secondCutOff,
    this.firstPayDate,
    this.secondPayDate,
    this.earlyCheckIn,
    this.isLeavePayResign,
    this.firstPayslipDate,
    this.firstPayslipTime,
    this.secondPayslipDate,
    this.secondPayslipTime,
    this.firstAddition,
    this.secondAddition,
    this.firstDeduction,
    this.secondDeduction,
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
    paymentPeriod,
    firstCutOff,
    secondCutOff,
    firstPayDate,
    secondPayDate,
    earlyCheckIn,
    isLeavePayResign,
    firstPayslipDate,
    firstPayslipTime,
    secondPayslipDate,
    secondPayslipTime,
    firstAddition,
    secondAddition,
    firstDeduction,
    secondDeduction,
    payment,
  ];
}
