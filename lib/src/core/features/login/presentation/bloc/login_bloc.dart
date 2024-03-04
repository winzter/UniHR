import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:equatable/equatable.dart';
import '../../../../error/failures.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/use_cases/login_usecase.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;
  LoginBloc({required this.loginUseCase,}) : super(LoginInitial()) {

    on<LoginEventDoLogin>((event, emit) async{
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo? androidInfo;
      IosDeviceInfo? iosInfo;
      if(Platform.isAndroid){
        androidInfo = await deviceInfo.androidInfo;
      }else{
        iosInfo = await deviceInfo.iosInfo;
      }
      emit(LoginStateLoading());
      await Future.delayed(const Duration(seconds: 2));
      var resultLogin = await loginUseCase(
          event.username,
          event.password,
          Platform.isAndroid?androidInfo!.id.toString():iosInfo!.identifierForVendor.toString()
          );
      resultLogin.fold((l) => {
        emit(LoginStateFailure(error: l))
      }, (r) => {
        emit(LoginStateSuccess(loginEntity: r,isLogin: true))
      });
    });
  }
}
