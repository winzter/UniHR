import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unihr/src/features/manager/employees_list/presentation/pages/emp_page.dart';
import '../../../../../../injection_container.dart';
import '../bloc/employees_list_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmployeesListPage extends StatefulWidget {
  const EmployeesListPage({super.key});

  @override
  State<EmployeesListPage> createState() => _EmployeesListPageState();
}

class _EmployeesListPageState extends State<EmployeesListPage>
    with SingleTickerProviderStateMixin {
  final EmployeesListBloc employeesListBloc = sl<EmployeesListBloc>();
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => employeesListBloc,
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
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
                        image: AssetImage("assets/images/background_img.png"),
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
                      "${AppLocalizations.of(context)!.normalemp}",
                      style: TextStyle(
                          fontSize: 18.5, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "${AppLocalizations.of(context)!.empout}",
                      style: TextStyle(
                          fontSize: 18.5, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            "assets/images/employees_list_manager/background_img.png"),
                        fit: BoxFit.cover)),
                child: TabBarView(
                  controller: tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    EmpPage(
                      bloc: employeesListBloc,
                      isTerminated: false,
                    ),
                    EmpPage(
                      bloc: employeesListBloc,
                      isTerminated: true,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
