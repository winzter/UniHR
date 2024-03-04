import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:unihr/src/components/widgets/error_warning.dart';
import 'package:unihr/src/features/user/working_record/presentation/widgets/work_record_body.dart';
import 'package:unihr/src/features/user/working_record/presentation/widgets/work_time_header.dart';
import '../../../../../../injection_container.dart';
import '../../../../../core/error/token_expires.dart';
import '../../../../../core/features/profile/presentation/provider/profile_provider.dart';
import '../bloc/WorkRecord_bloc.dart';
import '../widgets/appBar.dart';

class WorkRecordPage extends StatefulWidget {
  const WorkRecordPage({super.key});

  @override
  State<WorkRecordPage> createState() => _WorkRecordPageState();
}

class _WorkRecordPageState extends State<WorkRecordPage> {
  final WorkRecordBloc workRecordBloc = sl<WorkRecordBloc>();

  @override
  void initState() {
    super.initState();
    TokenExpires.checkTokenExpires(context);
    final ProfileProvider user = Provider.of<ProfileProvider>(context, listen: false);
    workRecordBloc.add(GetIsCheckIn(idEmp: user.profileData.idEmployees!));
  }

  @override
  Widget build(BuildContext context) {
    final ProfileProvider user = Provider.of<ProfileProvider>(context, listen: false);
    return Scaffold(
      appBar: appBar(context),
      body: BlocProvider(
        create: (context) => workRecordBloc,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: RefreshIndicator(
            onRefresh: ()async=>workRecordBloc.add(GetIsCheckIn(idEmp: user.profileData.idEmployees!)),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  BlocBuilder<WorkRecordBloc, WorkRecordState>(builder: (context,state){
                    if(state.status == FetchStatus.fetching){
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            enabled: true,
                            child:Container(
                              width: MediaQuery.of(context).size.width,
                              height: 430,
                              decoration: ShapeDecoration(
                                  color: Colors.grey, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),)
                              ),
                            )),
                      );
                    }
                    else if(state.status == FetchStatus.success){
                      return Container(
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.only(bottom: 15),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.transparent),
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            color: Colors.white),
                        child: Column(
                          children: [const WorkRecordHeader(), WorkRecordBody(workRecordBloc: workRecordBloc,)],
                        ),
                      );
                    }
                    else if(state.status == FetchStatus.failed){
                      return ErrorWarning(errorMsg: state.error!.errMsgText!);
                    }
                    else {
                      return const Text("กำลังดึงข้อมูล");
                    }
                  })

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
