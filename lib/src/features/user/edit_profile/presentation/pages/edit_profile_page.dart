import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../core/features/profile/presentation/provider/profile_provider.dart';
import '../../../../../core/provider/bottom_navbar/bottom_navbar_provider.dart';
import '../widgets/widgets.dart';
import 'change_password/change_password_page.dart';
import 'user_address/user_address_page.dart';
import 'user_information/user_information_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  Future<bool> onBackPress() async{
    final NavIndex navigationProvider =
        Provider.of<NavIndex>(context, listen: false);
    navigationProvider.controller.jumpToPage(0);
    navigationProvider.setIndex(0);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    return WillPopScope(
      onWillPop: onBackPress,
      child: Consumer(builder: (context, ProfileProvider data, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: DefaultTabController(
            length: 3,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: 150,
                    child: AppBar(
                      elevation: 0,
                      toolbarHeight: 80,
                      flexibleSpace: Stack(children: [
                        Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/background_img.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                Colors.white.withOpacity(0),
                                Colors.white.withOpacity(0.95)
                              ])),
                        ),
                      ]),
                      title: TabBar(
                        controller: tabController,
                        onTap: (value) {
                          setState(() {
                            tabController.index = value;
                          });
                        },
                        indicatorWeight: 3,
                        labelPadding: const EdgeInsets.all(0),
                        labelColor: Colors.black,
                        indicator: BoxDecoration(
                            gradient: LinearGradient(colors: [
                          Color(0xff5B4589),
                          Color(0xffE793B8)
                        ])),
                        indicatorPadding:
                            EdgeInsets.only(top: 45, left: 20, right: 20),
                        unselectedLabelColor: const Color(0xff757575),
                        tabs: [
                          TabsMenu(
                              title:
                                  AppLocalizations.of(context)!.personalinfo),
                          TabsMenu(
                              title: AppLocalizations.of(context)!.address),
                          TabsMenu(
                              title:
                                  AppLocalizations.of(context)!.changepassword),
                        ],
                      ),
                    ),
                  ),
                ),
                if (tabController.index != 2)
                  Positioned(
                    top: 70, // 70 default
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        if (profileProvider.isLoading) ...[
                          Container(
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
                            child: Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                enabled: true,
                                child: Container(
                                  width: 110,
                                  height: 110,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: CircleAvatar(
                                    radius: 45,
                                    backgroundColor: Color(0xffc4c4c4),
                                  ),
                                )),
                          ),
                        ]
                        else if (profileProvider.profileData.imageProfile != null) ...[
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
                                    "${profileProvider.profileData.imageProfile}"),
                              ),
                            ),
                          ),
                        ]
                        else ...[
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
                                radius:
                                    MediaQuery.of(context).size.width * 0.135,
                                backgroundColor: Color(0xffc4c4c4),
                                child: Icon(
                                  Icons.person,
                                  size: 90,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                        const SizedBox(
                          height: 15,
                        ),
                        profileProvider.isLoading
                            ? Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                enabled: true,
                                child: Container(
                                  width: 150,
                                  height: 30,
                                  decoration: ShapeDecoration(
                                      color: Colors.grey,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      )),
                                ))
                            : SizedBox(
                                // width: 170,
                                child: Text(
                                  AppLocalizations.of(context)!.address ==
                                          "ที่อยู่"
                                      ? "${data.profileData.titleTh ?? ''} ${data.profileData.firstnameTh ?? 'ไม่พบข้อมูล'} ${data.profileData.lastnameTh ?? ''} \n(${data.profileData.nicknameTh ?? ' - '})"
                                      : "${data.profileData.titleEn ?? ''} ${data.profileData.firstnameEn ?? 'ไม่พบข้อมูล'} ${data.profileData.lastnameEn ?? ''} \n(${data.profileData.nicknameEn ?? ' - '})",
                                  // "นาง นงรักษ์ ฉิมวัย",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                Positioned(
                  top: tabController.index == 2 ? 80 : 250,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: TabBarView(
                    controller: tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: const [
                      UserInformation(),
                      UserAddress(),
                      UserChangePassword(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }
}
