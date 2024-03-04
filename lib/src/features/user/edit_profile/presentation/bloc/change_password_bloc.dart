import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/usecases/change_password.dart';

part 'change_password_event.dart';

part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final ChangePassword changePassword;

  ChangePasswordBloc({required this.changePassword})
      : super(ChangePasswordInitial()) {
    on<SendChangePasswordEvent>((event, emit) async {
      var resChangePass = await changePassword(event.oldPass, event.newPass, event.confirm);
      resChangePass.fold(
          (l) => emit(
              state.copyWith(status: FetchStatus.failed, errMsg: l.errMsgTitle)),
          (r) => emit(state.copyWith(status: FetchStatus.success)));
    });
  }
}
