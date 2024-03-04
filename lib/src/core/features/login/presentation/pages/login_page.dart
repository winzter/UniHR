import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:unihr/src/core/features/loading_page/loading_page.dart';
import '../../../../../../injection_container.dart';
import '../../../../provider/bottom_navbar/language_page.dart';
import '../../../profile/presentation/provider/profile_provider.dart';
import '../bloc/login_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late bool obscure = true;
  bool userFieldError = false;
  bool passwordFieldError = false;

  int wrongCount = 0;
  // bool isLoginFail = false;
  // bool isLoading = false;
  Map loginData = {"username": "", "password": ""};

  Future<bool> onBackPress() async {
    SystemNavigator.pop();
    return false;
  }


  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<ProfileProvider>(context);
    return WillPopScope(
      onWillPop: onBackPress,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocProvider(
          create: (context) => sl<LoginBloc>(),
          child: Scaffold(
            body: Stack(
              children: [
                Container(
                  constraints: const BoxConstraints.expand(),
                  child: Image.asset(
                    'assets/images/splash.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Form(
                        autovalidateMode: AutovalidateMode.disabled,
                        key: formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 50),
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Stack(
                                  children: [
                                    Center(
                                      child: Image.asset(
                                        "assets/images/UniLogoDark.png",
                                        height: 250,
                                        width: 250,
                                      ),
                                    ),
                                    Positioned(
                                      top: 10,
                                      right: 0,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return LanguageScreen();
                                          }));
                                        },
                                        child: Icon(
                                          Icons.g_translate,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.logIn,
                                    style: TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3),
                                      ),
                                    ]),
                                child: TextFormField(
                                  style: TextStyle(fontSize: 18),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      setState(() => userFieldError = true);
                                      return AppLocalizations.of(context)!
                                          .plsuuser;
                                    }
                                    setState(() => userFieldError = false);
                                    return null;
                                  },
                                  onChanged: (String username) {
                                    setState(() {
                                      loginData["username"] = username;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        left: 10.0, top: 15.0, bottom: 15.0),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    fillColor: Colors.white,
                                    filled: true,
                                    labelText:
                                        AppLocalizations.of(context)!.username,
                                    labelStyle: TextStyle(
                                        fontSize: 18,
                                        color: userFieldError
                                            ? Colors.red
                                            : Colors.grey),
                                    prefixIcon: Icon(
                                        Icons.account_circle_rounded,
                                        color: userFieldError
                                            ? Colors.red
                                            : Colors.grey),
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    errorStyle: TextStyle(fontSize: 15),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Container(
                                // height: 55,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3),
                                      ),
                                    ]),
                                child: TextFormField(
                                  style: TextStyle(fontSize: 18),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      setState(() => passwordFieldError = true);
                                      return AppLocalizations.of(context)!
                                          .plsupass;
                                    } else if (value.length < 8) {
                                      setState(() => passwordFieldError = true);
                                      return AppLocalizations.of(context)!
                                          .password8characters;
                                    }
                                    setState(() => passwordFieldError = false);
                                    return null;
                                  },
                                  onChanged: (String password) {
                                    setState(() {
                                      loginData["password"] = password;
                                    });
                                  },
                                  obscureText: obscure,
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintStyle: TextStyle(),
                                    labelText:
                                        AppLocalizations.of(context)!.password,
                                    labelStyle: TextStyle(
                                        fontSize: 18,
                                        color: passwordFieldError
                                            ? Colors.red
                                            : Colors.grey),
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: passwordFieldError
                                          ? Colors.red
                                          : Colors.grey,
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() => obscure = !obscure);
                                      },
                                      icon: Icon(
                                        obscure
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                    ),
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    errorStyle: TextStyle(fontSize: 15),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              BlocBuilder<LoginBloc, LoginState>(
                                builder: (context, state) {
                                  if (state is LoginStateLoading) {
                                    return Column(
                                      children: [
                                        SizedBox(
                                          height: 50,
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              elevation: 5,
                                              backgroundColor:
                                                  const Color(0xffc6c6c6),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                            ),
                                            onPressed: () {
                                              FocusScope.of(context).unfocus();
                                              if (formKey.currentState!
                                                  .validate()) {
                                                debugPrint("success");
                                                userData.setPayslipValidate(false);
                                              } else {
                                                debugPrint("not success");
                                              }
                                            },
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const SizedBox(
                                                        height: 25,
                                                        width: 25,
                                                        child:
                                                            CircularProgressIndicator(
                                                          color: Colors.white,
                                                        )),
                                                    const SizedBox(
                                                      width: 15,
                                                    ),
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .loggingin,
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                )),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    );
                                  } else if (state is LoginStateFailure) {
                                    return Column(
                                      children: [
                                        SizedBox(
                                          height: 50,
                                          width: double.infinity,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                elevation: 5,
                                                backgroundColor:
                                                    const Color(0xff6FC9E4),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                              ),
                                              onPressed: () {
                                                FocusScope.of(context)
                                                    .unfocus();
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  context.read<LoginBloc>().add(
                                                      LoginEventDoLogin(
                                                          username: loginData[
                                                              "username"],
                                                          password: loginData[
                                                              "password"]));
                                                  // logInProvider.login(loginData["username"], loginData["password"]);
                                                  debugPrint("success");
                                                } else {
                                                  debugPrint("not success");
                                                }
                                              },
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .logIn,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white),
                                              )),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!
                                              .usernameorpasswordisincorrect,
                                          style: TextStyle(
                                              fontSize: 15, color: Colors.red),
                                        )
                                      ],
                                    );
                                  }
                                  else if (state is LoginStateSuccess) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      Navigator.of(context).pushAndRemoveUntil(
                                        PageTransition(
                                          type: PageTransitionType.leftToRight,
                                          child: const LoadingPage(
                                            isLogIn: true,
                                          ), // Replace with your home page
                                        ),
                                        (route) => false,
                                      );
                                    });
                                    return SizedBox(
                                      height: 50,
                                      width: double.infinity,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            elevation: 5,
                                            backgroundColor:
                                                const Color(0xff6FC9E4),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                          ),
                                          onPressed: () {
                                            FocusScope.of(context).unfocus();
                                          },
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .loginsuccessful,
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white),
                                          )),
                                    );
                                  } else {
                                    return Column(
                                      children: [
                                        SizedBox(
                                          height: 50,
                                          width: double.infinity,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                elevation: 5,
                                                backgroundColor:
                                                    const Color(0xff6FC9E4),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                              ),
                                              onPressed: () {
                                                FocusScope.of(context)
                                                    .unfocus();
                                                if (formKey.currentState!.validate()) {
                                                  context.read<LoginBloc>().add(
                                                      LoginEventDoLogin(
                                                          username: loginData["username"],
                                                          password: loginData["password"]));
                                                  userData.setPayslipValidate(false);
                                                  log("success");
                                                } else {
                                                  log("not success");
                                                }
                                              },
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .logIn,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white),
                                              )),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    );
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



