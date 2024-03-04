import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unihr/src/features/user/edit_profile/presentation/provider/edit_profile_provider.dart';
import '../../widgets/user_change_password_widgets/one_line_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../widgets/widgets.dart';

class UserChangePassword extends StatefulWidget {
  const UserChangePassword({super.key});

  @override
  State<UserChangePassword> createState() => _UserChangePasswordState();
}

class _UserChangePasswordState extends State<UserChangePassword> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController confirmPassController = TextEditingController();
  TextEditingController oldPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  String confirm = "";
  String oldPass = "";
  String newPass = "";
  late bool obscure1;
  late bool obscure2;
  late bool obscure3;

  OutlineInputBorder borderStyle = const OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xffC4C4C4)),
      borderRadius: BorderRadius.all(Radius.circular(10)));
  @override
  void initState() {
    super.initState();
    obscure1 = true;
    obscure2 = true;
    obscure3 = true;
  }

  @override
  Widget build(BuildContext context) {
    final EditProfileProvider changePassword =
        Provider.of<EditProfileProvider>(context);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Form(
          autovalidateMode: AutovalidateMode.disabled,
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 45, left: 25, right: 25, bottom: 35),
            child: Container(
              padding: const EdgeInsets.only(
                  top: 15, left: 25, right: 25, bottom: 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(2, 3),
                    ),
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Text(
                    AppLocalizations.of(context)!.changepassword,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  )),
                  const Gap(
                    height: 10,
                    width: 0,
                  ),
                  OneLineText(
                      text: AppLocalizations.of(context)!.atleast8_16charactersenglishandnumbers),
                  OneLineText(
                      text: AppLocalizations.of(context)!.passwordenglishornumbersonly),
                  OneLineText(
                      text: AppLocalizations.of(context)!.passwordatleast1englishletter),
                  const Gap(
                    height: 10,
                    width: 0,
                  ),
                  Text(
                    AppLocalizations.of(context)!.currentpassword,
                  ),
                  TextFormField(
                    controller: oldPassController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "กรุณาใส่รหัสผ่าน";
                      }
                      return null;
                    },
                    onChanged: (String value) {
                      setState(() {
                        oldPass = value;
                      });
                    },
                    obscureText: obscure1,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(
                          top: 5, bottom: 5, left: 10, right: 10),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscure1 = !obscure1;
                          });
                        },
                        icon: Icon(
                            obscure1 ? Icons.visibility_off : Icons.visibility),
                      ),
                      border: borderStyle,
                      enabledBorder: borderStyle,
                      focusedBorder: borderStyle,
                    ),
                  ),
                  const Gap(
                    height: 10,
                    width: 0,
                  ),
                  Text(
                    AppLocalizations.of(context)!.newpassword,
                  ),
                  TextFormField(
                    controller: newPassController,
                    validator: (value) {
                      if (value!.isEmpty || !RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).*$')
                      // if (value!.isEmpty || !RegExp(r'\w')
                              .hasMatch(value)) {
                        return "รหัสผ่านต้องมีตัวเลขหรือตัวหนังสืออย่างน้อย 1 ตัว";
                      }
                      if (value.length < 8) {
                        return "รหัสผ่านต้องมีอย่างน้อย 8-16 ตัวอักษร";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        newPass = value;
                      });
                    },
                    obscureText: obscure2,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(
                          top: 5, bottom: 5, left: 10, right: 10),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscure2 = !obscure2;
                          });
                        },
                        icon: Icon(
                            obscure2 ? Icons.visibility_off : Icons.visibility),
                      ),
                      border: borderStyle,
                      enabledBorder: borderStyle,
                      focusedBorder: borderStyle,
                    ),
                  ),
                  const Gap(
                    height: 10,
                    width: 0,
                  ),
                  Text(
                    AppLocalizations.of(context)!.confirmnewpassword,
                  ),
                  TextFormField(
                    controller: confirmPassController,
                    validator: (value) {
                      if (value!.isNotEmpty) {
                        if (newPass != confirm) {
                          return "รหัสผ่านใหม่ไม่ตรงกัน";
                        }
                      }
                      if (value.isEmpty || !RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).*$').hasMatch(value)) {
                        return "รหัสผ่านต้องมีตัวเลขหรือตัวหนังสืออย่างน้อย 1 ตัว";
                      }
                      if (value.length < 8) {
                        return "รหัสผ่านต้องมีอย่างน้อย 8-16 ตัวอักษร";
                      }
                      return null;
                    },
                    onChanged: (String value) {
                      setState(() {
                        confirm = value;
                      });
                    },
                    obscureText: obscure3,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(
                          top: 5, bottom: 5, left: 10, right: 10),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscure3 = !obscure3;
                          });
                        },
                        icon: Icon(
                            obscure3 ? Icons.visibility_off : Icons.visibility),
                      ),
                      border: borderStyle,
                      focusedBorder: borderStyle,
                      enabledBorder: borderStyle,
                    ),
                  ),
                  const Gap(
                    height: 10,
                    width: 0,
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffE793B8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          changePassword.changePasswordData(oldPass, newPass, confirm, context)
                              .then((value) {
                            if (!value) {
                              oldPass = '';
                              newPass = '';
                              confirm = '';
                              confirmPassController.text = '';
                              oldPassController.text = '';
                              newPassController.text = '';
                              setState(() {});
                            }
                          });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                            AppLocalizations.of(context)!.confirmpasswordchange,
                            style:
                                TextStyle(fontSize: 17, color: Colors.white)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
