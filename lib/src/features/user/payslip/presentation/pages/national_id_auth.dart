import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unihr/src/features/user/payslip/presentation/pages/payslip_page.dart';
import '../../../../../components/widgets/background_img.dart';
import '../../../../../components/widgets/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../core/features/profile/presentation/provider/profile_provider.dart';

class NationalIdAuth extends StatefulWidget {
  const NationalIdAuth({Key? key}) : super(key: key);

  @override
  _NationalIdAuthState createState() => _NationalIdAuthState();
}

class _NationalIdAuthState extends State<NationalIdAuth> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController idController = TextEditingController();
  bool isCorrect = false;

  @override
  Widget build(BuildContext context) {
    final ProfileProvider userProfile = Provider.of<ProfileProvider>(context);
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            BackgroundImg(),
            AppbarBack(),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.17,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Gap(height: 25),
                      SizedBox(
                        // width: 170,
                        child: Text(
                          AppLocalizations.of(context)!.hello == "Hello"
                              ? "${userProfile.profileData.firstnameEn ?? 'ไม่พบข้อมูล'}"
                              : "${userProfile.profileData.firstnameTh ?? 'ไม่พบข้อมูล'}",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Gap(height: 15),
                      if (userProfile.profileData.imageProfile != null) ...[
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              radius: 55,
                              backgroundColor: Color(0xffc4c4c4),
                              backgroundImage: NetworkImage(
                                  "${userProfile.profileData.imageProfile}"),
                            ),
                          ),
                        ),
                      ] else ...[
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              radius: 55,
                              backgroundColor: Color(0xffc4c4c4),
                              child: Icon(
                                Icons.person,
                                size: 75,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                      Gap(height: 55),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "${AppLocalizations.of(context)!.verifyyouridentitywithyourIDcardnumber}",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      Gap(height: 10),
                      Form(
                        key: formKey,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            controller: idController,
                            style: TextStyle(fontSize: 18),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "${AppLocalizations.of(context)!.pleaseenterrequiredinformationcompletely}";
                              } else if (value !=
                                  userProfile.profileData.personalId) {
                                return "${AppLocalizations.of(context)!.idcardnumberisincorrect}";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 0),
                                hintText:
                                    "${AppLocalizations.of(context)!.personalid}",
                                hintStyle: TextStyle(fontSize: 18),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                errorStyle: TextStyle(fontSize: 15)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 5,
                              backgroundColor: const Color(0xff6FC9E4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              if (formKey.currentState!.validate()) {
                                userProfile.setPayslipValidate(true);
                                setState(() {
                                  isCorrect = true;
                                });
                                await Future.delayed(Duration(seconds: 1));
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PaySlipPage(),
                                    ));
                              }
                            },
                            child: Text(
                              "${AppLocalizations.of(context)!.confirm}",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (isCorrect)
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.3),
                      // Colors.black.withOpacity(0.95)
                    ])),
                child: Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
