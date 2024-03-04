import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/use_cases/login_usecase.dart';

class LoginProvider extends ChangeNotifier{
  bool _isLoading = false;
  final LoginUseCase loginUseCase;

  LoginProvider({required this.loginUseCase});

  bool get isLoading => _isLoading;

  LoginEntity? loginData;


  // Future<void> login(String username,String password) async {
  //   _isLoading = true;
  //   await Future.delayed(const Duration(seconds: 2));
  //   var data = await loginUseCase(username,password);
  //   loginData = data.foldRight(loginData, (r, previous) => r);
  //   _isLoading = false;
  //   notifyListeners();
  // }

  static LoginProvider of(BuildContext context, {listen = true}) =>
      Provider.of<LoginProvider>(context, listen: listen);
}