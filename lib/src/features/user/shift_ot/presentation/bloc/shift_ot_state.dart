part of 'shift_ot_bloc.dart';

abstract class ShiftOtState extends Equatable {
  const ShiftOtState();
}

class ShiftOtInitial extends ShiftOtState {
  @override
  List<Object> get props => [];
}

class ShiftOtLoading extends ShiftOtState {
  @override
  List<Object> get props => [];
}

class ShiftOtLoaded extends ShiftOtState {
  final double sumOfShiftAndOt;
  final ShiftAndOtEntity data;

  ShiftOtLoaded({required this.data,required this.sumOfShiftAndOt});

  @override
  List<Object> get props => [data];
}

class ShiftOtFailure extends ShiftOtState{
  final ErrorMessage error;
  const ShiftOtFailure({required this.error});
  @override
  List<Object?> get props => [error];

}