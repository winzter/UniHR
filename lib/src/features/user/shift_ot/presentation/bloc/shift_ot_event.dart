part of 'shift_ot_bloc.dart';

abstract class ShiftOtEvent extends Equatable {
  const ShiftOtEvent();
}

class getShiftOT extends ShiftOtEvent{
  final String start;
  final String end;
  getShiftOT({required this.start,required this.end});

  @override
  List<Object?> get props => [start,end];

}
