import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unihr/src/features/user/noti_user/presentation/widgets/appbar.dart';
import 'package:unihr/src/features/user/noti_user/presentation/widgets/shimmer.dart';
import '../../../../../../injection_container.dart';
import '../bloc/notiattendance_bloc.dart';

class NotiattendacePage extends StatefulWidget {
  const NotiattendacePage({super.key});

  @override
  State<NotiattendacePage> createState() => _NotiattendacePageState();
}

class _NotiattendacePageState extends State<NotiattendacePage>
    with AutomaticKeepAliveClientMixin {
  final NotiattendBloc notiattendBloc = sl<NotiattendBloc>();

  @override
  void initState() {
    super.initState();
    notiattendBloc.add(GetNotiattendData());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBars(context),
      body: BlocProvider(
        create: (context) => notiattendBloc,
        child: Column(children: [
          SizedBox(
            height: 20,
          ),
          Expanded(child: BlocBuilder<NotiattendBloc, NotiattendState>(
              builder: (context, state) {
            if (state is NotiattendInitial) {
              return Center(child: Text("กำลังโหลดข้อมูล", style: TextStyle()));
            } else if (state is NotiattendLoading)
              return ShimmerComponent(
                  width: MediaQuery.of(context).size.width, height: 100);
            else if (state is NotiattendLoaded) {
              return ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return ListTile(
                        title: Text(state.notiattendancedData[1].pattern!.timeIn
                            .toString()));
                  });
            } else if (state is NotiattendFailure) {
              return Text("เกิดข้อผิดพลาด ${state.error}", style: TextStyle());
            } else {
              return Container();
            }
          }))
        ]),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
