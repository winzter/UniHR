import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unihr/src/components/widgets/error_warning.dart';
import 'package:unihr/src/components/widgets/shimmer.dart';
import 'package:unihr/src/features/manager/employees_list/presentation/widgets/card_emp.dart';
import '../bloc/employees_list_bloc.dart';

class EmpPage extends StatefulWidget {
  final EmployeesListBloc bloc;
  final bool isTerminated;

  const EmpPage({super.key, required this.bloc, required this.isTerminated});

  @override
  State<EmpPage> createState() => _EmpPageState();
}

class _EmpPageState extends State<EmpPage> {
  @override
  void initState() {
    super.initState();
    widget.bloc.add(GetEmployeesData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).devicePixelRatio * 7,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<EmployeesListBloc, EmployeesListState>(
                builder: (context, state) {
                  if (state.status == FetchStatus.fetching) {
                    return Expanded(
                      child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                        SliverGridDelegateWithMaxCrossAxisExtent(
                            mainAxisExtent: 300,
                            maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
                            childAspectRatio: 1,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return ShimmerComponent(width: 0, height: 500);
                        },
                      ),
                    );
                  }
                  else if (state.status == FetchStatus.success) {
                    return Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          widget.bloc.add(GetEmployeesData());
                        },
                        child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  mainAxisExtent: 300,
                                  maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
                                  childAspectRatio: 1,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20),
                          itemCount: widget.isTerminated
                              ? state.terminateEmpData.length
                              : state.normalEmpData.length,
                          itemBuilder: (context, index) {
                            return CardEmp(empData: widget.isTerminated?state.terminateEmpData[index]:state.normalEmpData[index]);
                          },
                        ),
                      ),
                    );
                  }
                  else if(state.status == FetchStatus.failed){
                    return ErrorWarning(errorMsg: state.error!.errMsgText!);
                  }
                  return const Center(child: Text("กำลังโหลดข้อมูล..."));
                },
              ),
            ],
          ),
        ));
  }
}
