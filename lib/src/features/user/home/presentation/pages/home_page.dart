import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:unihr/src/features/user/shift_ot/presentation/bloc/shift_ot_bloc.dart';
import '../../../../../../injection_container.dart';
import '../../../../../core/error/token_expires.dart';
import '../../../../../core/features/attendance/presentation/provider/attendance_provider.dart';
import '../../../../../core/features/profile/presentation/provider/profile_provider.dart';
import '../../../../../core/provider/bottom_navbar/language_page.dart';
import '../../../leave/presentaion/bloc/leave_bloc.dart';
import '../../../payslip/presentation/provider/payslip_provider.dart';
import '../provider/leave_provider.dart';
import '../widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

enum Language { english, thailand }

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  final DateTime now = DateTime.now();
  final LeaveBloc leaveAuthBloc = sl<LeaveBloc>();
  final ShiftOtBloc shiftOtBloc = sl<ShiftOtBloc>();
  late ProfileProvider profileProvider;
  late AttendanceProvider attendanceProvider;
  late GetPayslipProvider payslipProvider;
  late WaitingProvider waitingProvider;
  int currentPageIndex = 0;
  bool isError = false;
  late String idRole;
  void isLoading() async {
    profileProvider = ProfileProvider.of(context, listen: false);
    payslipProvider = GetPayslipProvider.of(context, listen: false);
    attendanceProvider = AttendanceProvider.of(context, listen: false);
    waitingProvider = WaitingProvider.of(context, listen: false);
    profileProvider.setIsLoading(true);
    TokenExpires.checkTokenExpires(context);
    await profileProvider.getProfileData(context);
    await payslipProvider.getPreviousPayslipData(context);
    await waitingProvider.getAllData(context);
    await attendanceProvider.getAttendanceData(context);
    leaveAuthBloc.add(GetLeaveAvailableEvent(start: DateTime.now(), end: DateTime.now()));
    if (now.day >= 28) {
      shiftOtBloc.add(getShiftOT(
          start: DateFormat('yyyy-MM-dd')
              .format(DateTime(now.year, now.month + 1, 1)),
          end: DateFormat('yyyy-MM-dd')
              .format(DateTime(now.year, now.month + 1, 0))));
    } else {
      shiftOtBloc.add(getShiftOT(
          start: DateFormat('yyyy-MM-dd')
              .format(DateTime(now.year, now.month, 1)),
          end: DateFormat('yyyy-MM-dd')
              .format(DateTime(now.year, now.month + 1, 0))));
    }
    setState(() {
      waitingProvider.isApprove();
      waitingProvider.isNotApprove();
    });
    profileProvider.setIsLoading(false);
  }

  @override
  void initState() {
    super.initState();
    isLoading();
  }

  @override
  Widget build(BuildContext context) {
    final ProfileProvider userData = Provider.of<ProfileProvider>(context);
    super.build(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<LeaveBloc>(
          create: (BuildContext context) => leaveAuthBloc,
        ),
        BlocProvider<ShiftOtBloc>(
          create: (BuildContext context) => shiftOtBloc,
        ),
      ],
      child: Scaffold(
        // appBar: AppBar(
        //   elevation: 0,
        //   scrolledUnderElevation: 0,
        //   toolbarHeight: MediaQuery.of(context).size.height * 0.22,
        //   flexibleSpace: Stack(
        //     children: [
        //       Container(
        //         decoration: const BoxDecoration(
        //           image: DecorationImage(
        //               image: AssetImage("assets/images/background_img.png"),
        //               repeat: ImageRepeat.noRepeat,
        //               fit: BoxFit.cover),
        //         ),
        //       ),
        //       Container(
        //         width: MediaQuery.of(context).size.width,
        //         height: MediaQuery.of(context).size.height * 0.25,
        //         decoration: BoxDecoration(
        //             gradient: LinearGradient(
        //                 begin: Alignment.topCenter,
        //                 end: Alignment.bottomCenter,
        //                 colors: [
        //               Colors.white.withOpacity(0),
        //               Colors.white.withOpacity(0.9)
        //             ])),
        //       ),
        //     ],
        //   ),
        //   title: Column(
        //     children: [
        //       Stack(
        //         children: [
        //           BackdropFilter(
        //             filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
        //             child: Container(
        //               decoration: const BoxDecoration(color: Colors.white),
        //             ),
        //           ),
        //           SizedBox(
        //               height: MediaQuery.of(context).size.height * 0.17,
        //               child: PageView(
        //                 physics: const BouncingScrollPhysics(),
        //                 onPageChanged: (int index) {
        //                   setState(() {
        //                     currentPageIndex = index;
        //                   });
        //                 },
        //                 // controller: controller,
        //                 children: const [
        //                   FirstPageView(),
        //                   SecondPageView(),
        //                   ThirdPageView()
        //                 ],
        //               )),
        //           Positioned(
        //             top: 10,
        //             right: 0,
        //             child: InkWell(
        //                 onTap: () {
        //                   Navigator.push(context,
        //                       MaterialPageRoute(builder: (context) {
        //                     return const LanguageScreen();
        //                   }));
        //                 },
        //                 child: const Icon(Icons.g_translate,
        //                     color: Colors.pink)),
        //           ),
        //         ],
        //       ),
        //       DotsIndicator(
        //         dotsCount: 3,
        //         position: currentPageIndex,
        //         decorator: DotsDecorator(
        //           color: const Color(0xffC4C4C4),
        //           spacing: EdgeInsets.symmetric(
        //               horizontal: MediaQuery.of(context)
        //                   .devicePixelRatio), // Inactive color
        //           activeColor: Colors.white,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        body: Stack(
          children: [
            RefreshIndicator(
              onRefresh: () async {
                isLoading();
              },
              child:
              CustomScrollView(
                slivers: [
                  // Column(
                  //   children: [
                  //     SizedBox(
                  //       height: MediaQuery.of(context).size.height * 0.03,
                  //     ),
                  //     if (userData.profileData.idRole == 2) ...[
                  //       const TextHeader(title: "เมนูทางลัด")
                  //     ],
                  //     SizedBox(
                  //       // height: MediaQuery.of(context).size.height * 0.3,
                  //       width: double.infinity,
                  //       child: const SingleChildScrollView(
                  //         physics: BouncingScrollPhysics(),
                  //         scrollDirection: Axis.horizontal,
                  //         child: MenuCircle(),
                  //       ),
                  //     ),
                  //     if (userData.profileData.idRole == 2) ...[
                  //       const TextHeader(title: "การจัดการ"),
                  //       SizedBox(
                  //         // height: MediaQuery.of(context).size.height * 0.3,
                  //         width: double.infinity,
                  //         child: const SingleChildScrollView(
                  //           physics: BouncingScrollPhysics(),
                  //           scrollDirection: Axis.horizontal,
                  //           child: MenuUserManagerCircle(),
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         height: MediaQuery.of(context).size.height * 0.03,
                  //       ),
                  //     ],
                  //     Row(children: [
                  //       Expanded(
                  //         child: ChartVacation(
                  //           bloc: leaveAuthBloc,
                  //         ),
                  //       ),
                  //       Expanded(
                  //         child: ChartDeduction(
                  //           bloc: shiftOtBloc,
                  //         ),
                  //       )
                  //     ]),
                  //     SizedBox(
                  //       height: MediaQuery.of(context).size.height * 0.02,
                  //     ),
                  //     // if( userData.profileData.email != null && (userData.profileData.email!.contains("SCG") || userData.profileData.email!.contains("user")))...[
                  //     //   userData.isLoading?
                  //     //   Column(
                  //     //     children: [
                  //     //       Padding(
                  //     //         padding: EdgeInsets.only(
                  //     //             left: MediaQuery.of(context).devicePixelRatio * 7.5,
                  //     //             right: MediaQuery.of(context).devicePixelRatio * 7.5,
                  //     //             bottom: MediaQuery.of(context).devicePixelRatio * 4
                  //     //         ),
                  //     //         child: Shimmer.fromColors(
                  //     //             baseColor: Colors.grey.shade300,
                  //     //             highlightColor: Colors.grey.shade100,
                  //     //             enabled: true,
                  //     //             child:Container(
                  //     //               width: MediaQuery.of(context).size.width,
                  //     //               height: 200,
                  //     //               decoration: ShapeDecoration(
                  //     //                   color: Colors.grey, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),)
                  //     //               ),
                  //     //             )),
                  //     //       ),
                  //     //       Padding(
                  //     //         padding: EdgeInsets.only(
                  //     //             left: MediaQuery.of(context).devicePixelRatio * 7.5,
                  //     //             right: MediaQuery.of(context).devicePixelRatio * 7.5,
                  //     //             bottom: MediaQuery.of(context).devicePixelRatio * 4
                  //     //         ),
                  //     //         child: Shimmer.fromColors(
                  //     //             baseColor: Colors.grey.shade300,
                  //     //             highlightColor: Colors.grey.shade100,
                  //     //             enabled: true,
                  //     //             child:Container(
                  //     //               width: MediaQuery.of(context).size.width,
                  //     //               height: 200,
                  //     //               decoration: ShapeDecoration(
                  //     //                   color: Colors.grey, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),)
                  //     //               ),
                  //     //             )),
                  //     //       )
                  //     //     ],
                  //     //   ) :const RecommendedCourse()
                  //     // ],
                  //     const WaitingStatus(),
                  //   ],
                  // ),
                  SliverAppBar(
                    toolbarHeight: MediaQuery.of(context).size.height * 0.22,
                    title: Column(
                      children: [
                        Stack(
                          children: [
                            BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                              child: Container(
                                decoration: const BoxDecoration(color: Colors.white),
                              ),
                            ),
                            SizedBox(
                                height: MediaQuery.of(context).size.height * 0.17,
                                child: PageView(
                                  physics: const BouncingScrollPhysics(),
                                  onPageChanged: (int index) {
                                    setState(() {
                                      currentPageIndex = index;
                                    });
                                  },
                                  // controller: controller,
                                  children: const [
                                    FirstPageView(),
                                    SecondPageView(),
                                    ThirdPageView()
                                  ],
                                )),
                            // Positioned(
                            //   top: 10,
                            //   right: 0,
                            //   child: InkWell(
                            //       onTap: () {
                            //         Navigator.push(context,
                            //             MaterialPageRoute(builder: (context) {
                            //               return const LanguageScreen();
                            //             }));
                            //       },
                            //       child: const Icon(Icons.g_translate,
                            //           color: Colors.pink)),
                            // ),
                          ],
                        ),
                        DotsIndicator(
                          dotsCount: 3,
                          position: currentPageIndex,
                          decorator: DotsDecorator(
                            color: const Color(0xffC4C4C4),
                            spacing: EdgeInsets.symmetric(
                                horizontal: MediaQuery.of(context)
                                    .devicePixelRatio), // Inactive color
                            activeColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    pinned: false,
                    snap: true,
                    floating: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background:
                      Stack(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/images/background_img.png"),
                                  repeat: ImageRepeat.noRepeat,
                                  fit: BoxFit.cover),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.white.withOpacity(0),
                                      Colors.white.withOpacity(0.9)
                                    ])),
                          ),
                        ],
                      ),
                    ),
                    // const FlexibleSpaceBar(
                    //   title: Text('SliverAppBar'),
                    //   background: FlutterLogo(),
                    // ),
                  ),
                    SliverList(delegate: SliverChildListDelegate(
                      [
                        Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            if (userData.profileData.idRole == 2) ...[
                              const TextHeader(title: "เมนูทางลัด")
                            ],
                            SizedBox(
                              // height: MediaQuery.of(context).size.height * 0.3,
                              width: double.infinity,
                              child: const SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                child: MenuCircle(),
                              ),
                            ),
                            if (userData.profileData.idRole == 2) ...[
                              const TextHeader(title: "การจัดการ"),
                              SizedBox(
                                // height: MediaQuery.of(context).size.height * 0.3,
                                width: double.infinity,
                                child: const SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  child: MenuUserManagerCircle(),
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.03,
                              ),
                            ],
                            Row(children: [
                              Expanded(
                                child: ChartVacation(
                                  bloc: leaveAuthBloc,
                                ),
                              ),
                              Expanded(
                                child: ChartDeduction(
                                  bloc: shiftOtBloc,
                                ),
                              )
                            ]),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            // if( userData.profileData.email != null && (userData.profileData.email!.contains("SCG") || userData.profileData.email!.contains("user")))...[
                            //   userData.isLoading?
                            //   Column(
                            //     children: [
                            //       Padding(
                            //         padding: EdgeInsets.only(
                            //             left: MediaQuery.of(context).devicePixelRatio * 7.5,
                            //             right: MediaQuery.of(context).devicePixelRatio * 7.5,
                            //             bottom: MediaQuery.of(context).devicePixelRatio * 4
                            //         ),
                            //         child: Shimmer.fromColors(
                            //             baseColor: Colors.grey.shade300,
                            //             highlightColor: Colors.grey.shade100,
                            //             enabled: true,
                            //             child:Container(
                            //               width: MediaQuery.of(context).size.width,
                            //               height: 200,
                            //               decoration: ShapeDecoration(
                            //                   color: Colors.grey, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),)
                            //               ),
                            //             )),
                            //       ),
                            //       Padding(
                            //         padding: EdgeInsets.only(
                            //             left: MediaQuery.of(context).devicePixelRatio * 7.5,
                            //             right: MediaQuery.of(context).devicePixelRatio * 7.5,
                            //             bottom: MediaQuery.of(context).devicePixelRatio * 4
                            //         ),
                            //         child: Shimmer.fromColors(
                            //             baseColor: Colors.grey.shade300,
                            //             highlightColor: Colors.grey.shade100,
                            //             enabled: true,
                            //             child:Container(
                            //               width: MediaQuery.of(context).size.width,
                            //               height: 200,
                            //               decoration: ShapeDecoration(
                            //                   color: Colors.grey, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),)
                            //               ),
                            //             )),
                            //       )
                            //     ],
                            //   ) :const RecommendedCourse()
                            // ],
                            const WaitingStatus(),
                          ],
                        ),
                      ]
                    ))


                ],
                physics: const BouncingScrollPhysics(),

              ),
              // SingleChildScrollView(
              //   physics: const BouncingScrollPhysics(),
              //   child:
              //   Column(
              //     children: [
              //       SizedBox(
              //         height: MediaQuery.of(context).size.height * 0.03,
              //       ),
              //       if (userData.profileData.idRole == 2) ...[
              //         const TextHeader(title: "เมนูทางลัด")
              //       ],
              //       SizedBox(
              //         // height: MediaQuery.of(context).size.height * 0.3,
              //         width: double.infinity,
              //         child: const SingleChildScrollView(
              //           physics: BouncingScrollPhysics(),
              //           scrollDirection: Axis.horizontal,
              //           child: MenuCircle(),
              //         ),
              //       ),
              //       if (userData.profileData.idRole == 2) ...[
              //         const TextHeader(title: "การจัดการ"),
              //         SizedBox(
              //           // height: MediaQuery.of(context).size.height * 0.3,
              //           width: double.infinity,
              //           child: const SingleChildScrollView(
              //             physics: BouncingScrollPhysics(),
              //             scrollDirection: Axis.horizontal,
              //             child: MenuUserManagerCircle(),
              //           ),
              //         ),
              //         SizedBox(
              //           height: MediaQuery.of(context).size.height * 0.03,
              //         ),
              //       ],
              //       Row(children: [
              //         Expanded(
              //           child: ChartVacation(
              //             bloc: leaveAuthBloc,
              //           ),
              //         ),
              //         Expanded(
              //           child: ChartDeduction(
              //             bloc: shiftOtBloc,
              //           ),
              //         )
              //       ]),
              //       SizedBox(
              //         height: MediaQuery.of(context).size.height * 0.02,
              //       ),
              //       // if( userData.profileData.email != null && (userData.profileData.email!.contains("SCG") || userData.profileData.email!.contains("user")))...[
              //       //   userData.isLoading?
              //       //   Column(
              //       //     children: [
              //       //       Padding(
              //       //         padding: EdgeInsets.only(
              //       //             left: MediaQuery.of(context).devicePixelRatio * 7.5,
              //       //             right: MediaQuery.of(context).devicePixelRatio * 7.5,
              //       //             bottom: MediaQuery.of(context).devicePixelRatio * 4
              //       //         ),
              //       //         child: Shimmer.fromColors(
              //       //             baseColor: Colors.grey.shade300,
              //       //             highlightColor: Colors.grey.shade100,
              //       //             enabled: true,
              //       //             child:Container(
              //       //               width: MediaQuery.of(context).size.width,
              //       //               height: 200,
              //       //               decoration: ShapeDecoration(
              //       //                   color: Colors.grey, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),)
              //       //               ),
              //       //             )),
              //       //       ),
              //       //       Padding(
              //       //         padding: EdgeInsets.only(
              //       //             left: MediaQuery.of(context).devicePixelRatio * 7.5,
              //       //             right: MediaQuery.of(context).devicePixelRatio * 7.5,
              //       //             bottom: MediaQuery.of(context).devicePixelRatio * 4
              //       //         ),
              //       //         child: Shimmer.fromColors(
              //       //             baseColor: Colors.grey.shade300,
              //       //             highlightColor: Colors.grey.shade100,
              //       //             enabled: true,
              //       //             child:Container(
              //       //               width: MediaQuery.of(context).size.width,
              //       //               height: 200,
              //       //               decoration: ShapeDecoration(
              //       //                   color: Colors.grey, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),)
              //       //               ),
              //       //             )),
              //       //       )
              //       //     ],
              //       //   ) :const RecommendedCourse()
              //       // ],
              //       const WaitingStatus(),
              //     ],
              //   ),
              // ),
            ),
            Positioned(
              top: 20,
              right: 15,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 18,vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black.withOpacity(0.3)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return LanguageScreen();
                                }));
                          },
                          child: const Icon(Icons.g_translate,
                              color: Colors.white,size: 27)),
                      const SizedBox(width: 10,),
                      const Icon(Icons.notifications_active_outlined,color: Colors.white,size: 29,)
                    ],
                  ),
                )
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
