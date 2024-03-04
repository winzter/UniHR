import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:unihr/src/features/user/employee_network/presentation/bloc/employee_network_bloc.dart';
import '../../../../../../injection_container.dart';
import '../../../../../core/error/token_expires.dart';
import '../widgets/widgets.dart';

class EmployeeDetailPage extends StatefulWidget {
  final int idEmp;

  const EmployeeDetailPage({super.key, required this.idEmp});

  @override
  State<EmployeeDetailPage> createState() => _EmployeeDetailPageState();
}

class _EmployeeDetailPageState extends State<EmployeeDetailPage>
    with SingleTickerProviderStateMixin {
  final EmployeeNetworkBloc bloc = sl<EmployeeNetworkBloc>();

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    TokenExpires.checkTokenExpires(context);
    tabController = TabController(length: 3, vsync: this);
    bloc.add(GetEachEmpData(idEmp: widget.idEmp));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: [
      BackgroundImg(),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            plainAppBar(context),
            BlocBuilder<EmployeeNetworkBloc, EmployeeNetworkState>(
              builder: (context, state) {
                if (state.status == FetchStatus.fetching) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            enabled: true,
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: CircleAvatar(
                                radius: 55,
                                backgroundColor: Color(0xffc4c4c4),
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              enabled: true,
                              child: Container(
                                width:
                                    MediaQuery.of(context).size.width * 0.7,
                                height: 30,
                                decoration: ShapeDecoration(
                                    color: Colors.grey,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20),
                                    )),
                              )),
                        )
                      ],
                    ),
                  );
                }
                else if (state.status == FetchStatus.success) {
                  return Column(
                    children: [
                      if (state.eachEmpData!.imageProfile != null) ...[
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
                                  "${state.eachEmpData!.imageProfile}"),
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
                                size: 70,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        // width: 170,
                        child: Text(
                          "${state.eachEmpData!.titleTh ?? ''} ${state.eachEmpData!.firstnameTh ?? 'ไม่พบข้อมูล'} ${state.eachEmpData!.lastnameTh ?? ''} \n(${state.eachEmpData!.nicknameTh ?? ' - '})",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    BlocBuilder<EmployeeNetworkBloc, EmployeeNetworkState>(
                      builder: (context, state) {
                        if (state.status == FetchStatus.fetching) {
                          return ShimmerEmp(height: 90,);
                        } else if (state.status == FetchStatus.success) {
                          return OverviewDetail(overviewDetail: state.eachEmpData!.overview ?? '-');
                        }
                        return const SizedBox();
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BlocBuilder<EmployeeNetworkBloc, EmployeeNetworkState>(
                      builder: (context, state) {
                        if (state.status == FetchStatus.fetching) {
                          return ShimmerEmp(height: 150,);
                        } else if (state.status == FetchStatus.success) {
                          return ContractDetail(eachEmpData: state.eachEmpData!);
                        }
                        return const SizedBox();
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BlocBuilder<EmployeeNetworkBloc, EmployeeNetworkState>(
                      builder: (context, state) {
                        if (state.status == FetchStatus.fetching) {
                          return ShimmerEmp(height: 200,);
                        } else if (state.status == FetchStatus.success) {
                          return InformationDetail(eachEmpData: state.eachEmpData!);
                        }
                        return const SizedBox();
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BlocBuilder<EmployeeNetworkBloc, EmployeeNetworkState>(
                      builder: (context, state) {
                        if(state.status == FetchStatus.fetching){
                          return ShimmerEmp(height: 200);
                        }else if(state.status == FetchStatus.success){
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: MediaQuery.of(context).devicePixelRatio * 5,
                                  vertical: MediaQuery.of(context).devicePixelRatio * 3),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(15)),
                              child: DefaultTabController(
                                length: 3,
                                child: Column(
                                  children: [
                                    TabBar(
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
                                            Color(0xff68D5E8),
                                            Color(0xffF394BC)
                                          ])),
                                      indicatorPadding: EdgeInsets.only(
                                          top: 45, left: 25, right: 25),
                                      unselectedLabelColor:
                                      const Color(0xff757575),
                                      tabs: const [
                                        TabsMenu(title: "Personal"),
                                        TabsMenu(title: "Address"),
                                        TabsMenu(title: "Education"),
                                      ],
                                    ),
                                    Container(
                                      height: 230,
                                      child: TabBarView(
                                          controller: tabController,
                                          physics:
                                          const NeverScrollableScrollPhysics(),
                                          children: [
                                            if (state.eachEmpData != null) ...[
                                              PersonalDetail(eachEmpData: state.eachEmpData!),
                                              AddressDetail(address: "${state.eachEmpData!.houseNo ?? '-'} ${state.eachEmpData!.subDistrict ?? '-'} ${state.eachEmpData!.district ?? '-'} ${state.eachEmpData!.provience ?? '-'} ${state.eachEmpData!.areaCode ?? '-'}"),
                                              EducationDetail(eachEmpData: state.eachEmpData!)
                                            ] else ...[
                                              Center(
                                                  child: Text("ไม่มีข้อมูล")),
                                              Center(
                                                  child: Text("ไม่มีข้อมูล")),
                                              Center(
                                                  child: Text("ไม่มีข้อมูล")),
                                            ]
                                          ]),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
        ]),
      ),
    );
  }
}
