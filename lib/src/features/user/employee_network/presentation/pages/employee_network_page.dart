import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../../../../../injection_container.dart';
import '../../../../../components/widgets/shimmer.dart';
import '../../../../../core/features/profile/presentation/provider/profile_provider.dart';
import '../bloc/employee_network_bloc.dart';
import '../widgets/widgets.dart';

class EmployeeNetworkPage extends StatefulWidget {
  const EmployeeNetworkPage({Key? key}) : super(key: key);

  @override
  State<EmployeeNetworkPage> createState() => _EmployeeNetworkPageState();
}

class _EmployeeNetworkPageState extends State<EmployeeNetworkPage> {
  final EmployeeNetworkBloc employeeNetworkBloc = sl<EmployeeNetworkBloc>();

  @override
  void initState() {
    super.initState();
    employeeNetworkBloc.add(GetAllEmpData());
  }

  @override
  Widget build(BuildContext context) {
    final ProfileProvider userData = Provider.of<ProfileProvider>(context);
    return BlocProvider(
      create: (context) => employeeNetworkBloc,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: empNetworkAppbar(context),
          body: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        "assets/images/employees_list_manager/background_img.png"),
                    fit: BoxFit.cover)),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).devicePixelRatio * 8,
                vertical: MediaQuery.of(context).devicePixelRatio * 4,
              ),
              child: Column(
                children: [
                  Header(
                    firstnameTH: userData.profileData.firstnameTh!,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  BlocBuilder<EmployeeNetworkBloc, EmployeeNetworkState>(
                    builder: (context, state) {
                      return SearchForm(
                        allEmpData: state.allEmpData, bloc: employeeNetworkBloc,
                      );
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  BlocBuilder<EmployeeNetworkBloc, EmployeeNetworkState>(
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [Text("จำนวนพนักงาน ${state.allEmpData.length} คน")],
                      );
                    },
                  ),
                  const SizedBox(height: 5,),
                  BlocBuilder<EmployeeNetworkBloc, EmployeeNetworkState>(
                    builder: (context, state) {
                      if (state.status == FetchStatus.fetching) {
                        return Expanded(child: ShimmerComponent(width: MediaQuery.of(context).size.width,height: 120,));
                      } else if (state.status == FetchStatus.success) {
                        return Expanded(
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: state.allEmpData.length,
                            itemBuilder: (context, index) {
                              return CardEachEmp(
                                  empData: state.allEmpData[index]);
                            },
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
        ),
      ),
    );
  }
}
