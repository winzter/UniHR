import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unihr/src/components/widgets/error_warning.dart';
import 'package:unihr/src/components/widgets/shimmer.dart';
import 'package:unihr/src/features/manager/working_time/presentation/bloc/individual_detail/workingtime_individual_bloc.dart';
import '../../../../../../../injection_container.dart';
import '../../../domain/entities/entities.dart';
import '../../widgets/individual_detail/form.dart';
import '../../widgets/individual_detail/timetable_body.dart';

class IndividualDetail extends StatefulWidget {
  const IndividualDetail({super.key});

  @override
  State<IndividualDetail> createState() => _IndividualDetailState();
}

class _IndividualDetailState extends State<IndividualDetail> {
  List<EmployeesEntity> empData = [];
  final WorkingTimeIndividualBloc bloc = sl<WorkingTimeIndividualBloc>();


  void initState(){
    super.initState();
    bloc.add(GetEmployeesData());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocBuilder<WorkingTimeIndividualBloc,WorkingTimeIndividualState>(
            builder: (context,state){
              if(state is WorkingTimeIndividualInitial){
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Column(
                    children: [
                      SearchFormIndividual(bloc: bloc, empData: state.empData,),
                      Text("กำลังโหลดข้อมูล",style: GoogleFonts.kanit())
                    ],
                  ),
                );
              }
              else if(state is WorkingTimeIndividualLoading){
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Column(
                    children: [
                      SearchFormIndividual(bloc: bloc, empData: state.empData,),
                      Expanded(child: ShimmerComponent(width: MediaQuery.of(context).size.width, height: 150))
                    ],
                  ),
                );
              }
              else if(state is WorkingTimeIndividualLoaded){
                return  Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Column(
                    children: [
                      SearchFormIndividual(bloc: bloc, empData: state.empData,),
                      Expanded(
                        child: TimeTableBody(
                          attendanceData: state.empAttendanceData,
                          showingData: state.showingData,
                          reasons: state.reasons,
                          idEmp: state.idEmp,
                          empData: state.empData,),
                      ),
                    ],
                  ),
                );
              }
              else if(state is WorkingTimeIndividualFailure){
                return ErrorWarning(errorMsg: state.error.errMsgText!);
              }
              return SearchFormIndividual(bloc: bloc, empData: state.empData,);
            }),
      ),
    );
  }
}
