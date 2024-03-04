import 'package:equatable/equatable.dart';

class HolidayEntity extends Equatable {
  final int? idHoliday;
  final String? name;
  final String? name_EN;
  final DateTime? dateHoliday;
  final dynamic compensateName;
  final dynamic compensateDate;
  final int? idCompany;
  final int? holidayYear;
  final int? showTimeline;
  final int? isActive;

  HolidayEntity({
    this.idHoliday,
    this.name,
    this.name_EN,
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
        name_EN,
        dateHoliday,
        compensateName,
        compensateDate,
        idCompany,
        holidayYear,
        showTimeline,
        isActive,
      ];
}
