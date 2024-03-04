import 'package:equatable/equatable.dart';

class HolidayLeaveEntity extends Equatable{
  final int? idHoliday;
  final String? name;
  final DateTime? dateHoliday;
  final String? compensateName;
  final DateTime? compensateDate;
  final int? idCompany;
  final int? holidayYear;
  final int? showTimeline;
  final int? isActive;

  HolidayLeaveEntity({
    this.idHoliday,
    this.name,
    this.dateHoliday,
    this.compensateName,
    this.compensateDate,
    this.idCompany,
    this.holidayYear,
    this.showTimeline,
    this.isActive,
  });

  @override
  List<Object?> get props => [
    idHoliday,
    name,
    dateHoliday,
    compensateName,
    compensateDate,
    idCompany,
    holidayYear,
    showTimeline,
    isActive,
  ];
}
