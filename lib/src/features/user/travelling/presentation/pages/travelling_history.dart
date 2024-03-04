import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:unihr/src/components/widgets/error_warning.dart';
import 'package:unihr/src/components/widgets/shimmer.dart';
import 'package:unihr/src/features/user/travelling/presentation/widgets/travel_history_card.dart';
import '../../../../../../injection_container.dart';
import '../../../../../components/widgets/appbar.dart';
import '../bloc/LocationBloc_bloc.dart';
import '../widgets/date_range.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TravellingHistoryPage extends StatefulWidget {
  final int idEmp;
  final Position userLocation;
  const TravellingHistoryPage(
      {super.key, required this.idEmp, required this.userLocation});

  @override
  State<TravellingHistoryPage> createState() => _TravellingHistoryPageState();
}

class _TravellingHistoryPageState extends State<TravellingHistoryPage> {
  final LocationBloc bloc = sl<LocationBloc>();
  final DateTime now = DateTime.now();

  void initState() {
    super.initState();
    bloc.add(
      GetCurrentAddress(lat: widget.userLocation.latitude, lng: widget.userLocation.longitude, now: now, idEmp: widget.idEmp),
    );
    bloc.add(GetTimeLineDataById(idEmp: widget.idEmp, date: DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: Scaffold(
        appBar:
            appBar(context, "${AppLocalizations.of(context)!.travelhistory}"),
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.024,
            ),
            DateRangeButton(
              bloc: bloc,
              idEmp: widget.idEmp,
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<LocationBloc, LocationState>(
              builder: (context, state) {
                if (state.status == FetchStatus.fetching) {
                  return Flexible(
                    child: ShimmerComponent(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                    ),
                    fit: FlexFit.loose, // Set FlexFit.loose for flexibility
                  );
                }
                else if (state.status == FetchStatus.success) {
                  return state.timeLineData.isNotEmpty
                      ? Flexible(
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: false, // Set shrinkWrap to true
                            itemCount: state.timeLineData.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: const Offset(0, 3),
                                        ),
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        TravelHistoryCard(
                                          data: state.timeLineData[index],
                                          locationName: state
                                                  .timeLineData[index]
                                                  .locationNameIn ??
                                              "",
                                          time: state
                                                  .timeLineData[index].timeIn ??
                                              "",
                                          mainColor: const Color(0xff229A16),
                                          bgColor: const Color(
                                            0xffD8F2DC,
                                          ),
                                          isIn: true,
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        if (state.timeLineData[index]
                                                    .locationNameOut !=
                                                null &&
                                            state.timeLineData[index]
                                                    .locationNameIn !=
                                                null) ...[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "ML ${(state.timeLineData[index].mileIn! - state.timeLineData[index].mileOut!).abs()} Km., ${state.timeLineData[index].diff}",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: const Color(
                                                        0xff757575)),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                        if (state.timeLineData[index]
                                                    .locationNameOut ==
                                                null &&
                                            state.timeLineData[index].timeOut ==
                                                null) ...[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "ไม่มีข้อมูลจุดสิ้นสุด",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                ),
                                              )
                                            ],
                                          )
                                        ] else ...[
                                          TravelHistoryCard(
                                            data: state.timeLineData[index],
                                            locationName: state
                                                    .timeLineData[index]
                                                    .locationNameOut ??
                                                "",
                                            time: state.timeLineData[index]
                                                    .timeOut ??
                                                "",
                                            mainColor: const Color(0xffB72136),
                                            bgColor: const Color(0xffFFD7DB),
                                            isIn: false,
                                          ),
                                        ]
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : Expanded(
                          child: Center(
                          child: Text(
                            "${AppLocalizations.of(context)!.noinformation}",
                            style: TextStyle(fontSize: 18),
                          ),
                        ));
                }
                else if(state.status == FetchStatus.failed){
                  return ErrorWarning(errorMsg: state.error!.errMsgText!);
                }
                else {
                  return const SizedBox();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
