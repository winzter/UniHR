import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unihr/src/components/widgets/shimmer.dart';
import 'package:unihr/src/features/manager/employees_list/presentation/bloc/employees_list_bloc.dart';
import '../../../../../../injection_container.dart';
import '../../domain/entities/employees_list_entity.dart';
import 'emp_detail_pages/pages.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmpDetailPage extends StatefulWidget {
  final EmployeesListEntity empData;

  final int idEmp;

  const EmpDetailPage({
    super.key,
    required this.empData,
    required this.idEmp,
  });

  @override
  State<EmpDetailPage> createState() => _EmpDetailPageState();
}

class _EmpDetailPageState extends State<EmpDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  final EmployeesListBloc employeesListBloc = sl<EmployeesListBloc>();

  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    employeesListBloc.add(GetEachEmployeeData(idEmp: widget.idEmp));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => employeesListBloc,
      child: Scaffold(
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
                  height: MediaQuery.of(context).size.height * 0.17,
                  child: AppBar(
                    leading: IconButton(
                      onPressed: () {
                        Navigator.pop((context));
                      },
                      icon: Icon(Icons.arrow_back_ios),
                    ),
                    elevation: 0,
                    toolbarHeight: MediaQuery.of(context).size.height * 0.1,
                    flexibleSpace: Stack(children: [
                      Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image:
                                AssetImage("assets/images/background_img.png"),
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
                              Colors.white.withOpacity(0.5)
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
                      indicatorWeight: 2,
                      labelPadding: const EdgeInsets.all(2),
                      labelColor: Colors.white,
                      indicatorColor: const Color(0xff5B4589),
                      unselectedLabelColor: const Color(0xffC4C4C4),
                      tabs: [
                        Text(
                          "${AppLocalizations.of(context)!.personalinfo}",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "${AppLocalizations.of(context)!.address}",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "${AppLocalizations.of(context)!.education}",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: MediaQuery.of(context).size.height * 0.145, // 70 default
                  left: MediaQuery.of(context).size.width * 0.1,
                  right: 0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal:
                            MediaQuery.of(context).devicePixelRatio * 5),
                    child: Container(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).devicePixelRatio * 3.5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(flex: 30, child: const SizedBox()),
                          Expanded(
                            flex: 70,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "${widget.empData.titleTh} ${widget.empData.firstnameTh} ${widget.empData.lastnameTh} \n(${widget.empData.nicknameTh ?? ' - '})",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "${widget.empData.titleEn}. ${widget.empData.firstnameEn} ${widget.empData.lastnameEn}",
                                        style: TextStyle(fontSize: 14),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        AppLocalizations.supportedLocales ==
                                                "th"
                                            ? "${widget.empData.positionName ?? '${AppLocalizations.of(context)!.notspecified}'}"
                                            : "${widget.empData.positionName_EN ?? '${AppLocalizations.of(context)!.notspecified}'}",
                                        style: TextStyle(fontSize: 14)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.135, // 70 default
                left: MediaQuery.of(context).size.width * -0.6,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: BlocBuilder<EmployeesListBloc, EmployeesListState>(
                    builder: (context, state) {
                      if (state.status == FetchStatus.success) {
                        return state.eachEmpData?.imageProfile == null
                            ? CircleAvatar(
                                radius: 55,
                                backgroundColor: Color(0xffc4c4c4),
                                child: Icon(
                                  Icons.person,
                                  size: 90,
                                  color: Colors.white,
                                ),
                              )
                            : CircleAvatar(
                                radius: 65,
                                backgroundColor: Colors.transparent,
                                child: ClipOval(
                                  child: Image.network(
                                    "${state.eachEmpData?.imageProfile}",
                                  ),
                                ));
                      }
                      return CircleAvatar(
                        radius: 55,
                        backgroundColor: Color(0xffc4c4c4),
                        child: Icon(
                          Icons.person,
                          size: 90,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.3,
                left: 0,
                right: 0,
                bottom: 0,
                child: SizedBox.expand(
                  child: Container(
                    child: BlocBuilder<EmployeesListBloc, EmployeesListState>(
                      builder: (context, state) {
                        if (state.status == FetchStatus.fetching) {
                          return ShimmerComponent(
                              width: MediaQuery.of(context).size.width,
                              height: 150);
                        } else if (state.status == FetchStatus.success) {
                          return Padding(
                            padding: EdgeInsets.only(
                                left: 30,
                                right: 30,
                                top:
                                    MediaQuery.of(context).devicePixelRatio * 4,
                                bottom: 0),
                            child: TabBarView(
                              controller: tabController,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                EmpInfoPage(
                                  empData: state.eachEmpData!,
                                ),
                                EmpAddressPage(
                                  empData: state.eachEmpData!,
                                ),
                                EmpEducationPage(empData: state.eachEmpData!),
                              ],
                            ),
                          );
                        } else {
                          return Center(
                              child: Text(
                                  "มีข้อผิดพลาดเกิดขึ้น กรุณาลองใหม่อีกครั้ง"));
                        }
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
