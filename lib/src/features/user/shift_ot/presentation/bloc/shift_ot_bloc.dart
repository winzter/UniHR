import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../domain/entities/shift_ot_entitiy.dart';
import '../../domain/use_cases/get_shift_ot.dart';

part 'shift_ot_event.dart';
part 'shift_ot_state.dart';

class ShiftOtBloc extends Bloc<ShiftOtEvent, ShiftOtState> {
  final GetShiftAndOT getShiftAndOT;
  ShiftOtBloc({required this.getShiftAndOT}) : super(ShiftOtInitial()) {

    on<getShiftOT>((event, emit) async{
      emit(ShiftOtLoading());
      var resShift = await getShiftAndOT(event.start,event.end);
      resShift.fold(
              (l) => emit(ShiftOtFailure(error: l)), 
              (r) {
                double sum = 0;
                for(var i in r.dataTable!){
                  sum+=(i.otThreeAmount??0)+(i.otOneAmount??0)+(i.otOneFiveAmount??0)+(i.otTwoAmount??0)+(i.shiftPayTotal??0);
                }
                emit(ShiftOtLoaded(data: r, sumOfShiftAndOt:sum ));
              });
    });
  }
}
