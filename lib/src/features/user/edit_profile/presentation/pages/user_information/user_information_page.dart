import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:unihr/src/features/user/edit_profile/presentation/widgets/shimmer_profile.dart';
import '../../../../../../core/features/loading_page/loading_page.dart';
import '../../../../../../core/features/profile/presentation/provider/profile_provider.dart';
import '../../../../../../core/provider/bottom_navbar/bottom_navbar_provider.dart';
import '../../widgets/user_information_widgets/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({super.key});

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  performLogout(BuildContext context) {
    final navigationProvider = Provider.of<NavIndex>(context, listen: false);
    navigationProvider.setIndex(0);
    Navigator.pushReplacement(
        context,
        PageTransition(
            type: PageTransitionType.leftToRight,
            child: const LoadingPage(
              isLogIn: false,
            )));
  }

  Future<bool> onLogOut() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(5), // Adjust the radius as needed
            ),
            title: Center(
                child: Column(
              children: [
                Icon(
                  Icons.logout,
                  color: Color(0xFFF15E5E),
                  size: 60,
                ),
                Text(
                  AppLocalizations.of(context)!.logout,
                  style: TextStyle(color: const Color(0xff75838F)),
                ),
              ],
            )),
            content: Text(
              AppLocalizations.of(context)!.wantlogout,
              style: TextStyle(
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    child: Text(AppLocalizations.of(context)!.cancel,
                        style: TextStyle(color: const Color(0xffA5AFBA))),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xFFF15E5E)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Adjust the radius here
                          ),
                        )),
                    child: Text(AppLocalizations.of(context)!.confirm,
                        style: TextStyle(color: Colors.white)),
                    onPressed: () => performLogout(context),
                  ),
                ],
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<ProfileProvider>(context, listen: true);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 150),
        child: Column(children: [
          providerData.isLoading
              ? ShimmerProfile(
                  width: MediaQuery.of(context).size.width, height: 100)
              : Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.transparent),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(2, 3),
                        ),
                      ]),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              AppLocalizations.of(context)!.hello == "Hello"
                                  ? providerData.profileData.positionName_EN ??
                                      AppLocalizations.of(context)!.notspecified
                                  : providerData.profileData.positionName ??
                                      AppLocalizations.of(context)!
                                          .notspecified,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                                AppLocalizations.of(context)!.hello == "Hello"
                                    ? providerData.profileData.companyName_EN ??
                                        AppLocalizations.of(context)!
                                            .notspecified
                                    : providerData.profileData.companyName ??
                                        AppLocalizations.of(context)!
                                            .notspecified,
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 15,
                                    color: const Color(0xff757575))),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                          AppLocalizations.of(context)!.startwork +
                              DateFormat(' dd MMM yyyy').format(
                                  providerData.profileData.hiringDate ??
                                      DateTime.now()),
                          // "เริ่มงาน 01 ก.ย. 2565",
                          style: TextStyle(
                              fontSize: 15, color: const Color(0xffC4C4C4))),
                    ],
                  ),
                ),
          providerData.isLoading
              ? Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: ShimmerProfile(
                      width: MediaQuery.of(context).size.width, height: 170),
                )
              : Reuse3LinesBox(
                  title: AppLocalizations.of(context)!.emergencycontact,
                  detail_1: AppLocalizations.of(context)!.contactname,
                  detail_2: AppLocalizations.of(context)!.emergencyrelationship,
                  detail_3: AppLocalizations.of(context)!.emergencyphone,
                  data_1: providerData.emergencyContact ??
                      AppLocalizations.of(context)!.notspecified,
                  data_2: providerData.emergencyRelationship ??
                      AppLocalizations.of(context)!.notspecified,
                  data_3: providerData.emergencyPhone ??
                      AppLocalizations.of(context)!.notspecified,
                  fix: true),
          providerData.isLoading
              ? Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: ShimmerProfile(
                      width: MediaQuery.of(context).size.width, height: 170),
                )
              : Reuse3LinesBox(
                  title: AppLocalizations.of(context)!.employeeinformation,
                  detail_1: AppLocalizations.of(context)!.employeeid,
                  detail_2: AppLocalizations.of(context)!.personalid,
                  detail_3: AppLocalizations.of(context)!.birthdate,
                  data_1: providerData.profileData.employeeId ??
                      AppLocalizations.of(context)!.notspecified,
                  data_2: providerData.profileData.personalId ??
                      AppLocalizations.of(context)!.notspecified,
                  data_3: DateFormat('dd MMMM yyyy').format(
                      providerData.profileData.birthday ?? DateTime.now()),
                  fix: false),
          providerData.isLoading
              ? Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: ShimmerProfile(
                      width: MediaQuery.of(context).size.width, height: 150),
                )
              : Reuse2LinesBox(
                  title: AppLocalizations.of(context)!.contact,
                  detail_1: AppLocalizations.of(context)!.phonenumber,
                  detail_2: AppLocalizations.of(context)!.email,
                  data_1: providerData.telephoneMobile ??
                      AppLocalizations.of(context)!.notspecified,
                  data_2: providerData.profileData.email ??
                      AppLocalizations.of(context)!.notspecified),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: () {
              onLogOut();
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                AppLocalizations.of(context)!.logout,
                style: TextStyle(fontSize: 17, color: Colors.white),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
