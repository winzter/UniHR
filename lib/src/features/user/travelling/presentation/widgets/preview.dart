import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:unihr/src/features/user/travelling/presentation/pages/mileage.dart';
import '../../../../../core/features/profile/presentation/provider/profile_provider.dart';
import '../bloc/LocationBloc_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PreviewWidget extends StatefulWidget {
  PreviewWidget({
    super.key,
    required this.bloc,
    required this.lat,
    required this.lng,
  });

  final LocationBloc bloc;
  final double lat;
  final double lng;

  @override
  State<PreviewWidget> createState() => _PreviewWidgetState();
}

class _PreviewWidgetState extends State<PreviewWidget> {
  final DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    // final ProfileProvider user =
    //     Provider.of<ProfileProvider>(context, listen: false);
    // widget.bloc.add(
    //   GetCurrentAddress(lat: widget.lat, lng: widget.lng, now: now, idEmp: user.profileData.idEmployees!),
    // );
    // widget.bloc.add(GetIsCheckIn(idEmp: user.profileData.idEmployees!, now: now));
  }

  @override
  Widget build(BuildContext context) {
    final ProfileProvider user =
        Provider.of<ProfileProvider>(context, listen: true);
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color(0xffFFB4D5),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          BlocConsumer<LocationBloc, LocationState>(
            listener: (context,state){
              if(state.status == FetchStatus.failed){

              }
            },
            builder: (context, state) {
              if (state.isSetLocation && state.isCheckInData != null) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Color(0xffFF6575),
                          size: 30,
                        ),
                        Flexible(
                          child: Text(
                            "${state.address?.reversed.last.name} ${state.address?.reversed.last.street} ${state.address?.reversed.last.subLocality} "
                            "\n${state.address?.reversed.last.locality} ${state.address?.reversed.last.postalCode} ${state.address?.reversed.last.country}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${AppLocalizations.of(context)!.date}" +
                              DateFormat(" dd/MM/yy").format(DateTime.now()),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          " ${AppLocalizations.of(context)!.time}" +
                              DateFormat(" HH:mm").format(DateTime.now()),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        state.isCheckInData!.checkIn! == 0
                            ? ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xff30B98F),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    )),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.leftToRight,
                                        child: MileagePage(
                                          isCheckIn: true,
                                          lat: widget.lat,
                                          lng: widget.lng,
                                          locationName:
                                              "${state.address?.reversed.last.name} ${state.address?.reversed.last.street} ${state.address?.reversed.last.subLocality} "
                                              "${state.address?.reversed.last.locality} ${state.address?.reversed.last.postalCode} ${state.address?.reversed.last.country}",
                                        ),
                                      )).then((value) {
                                    widget.bloc.add(
                                      GetCurrentAddress(lat: widget.lat, lng: widget.lng, now: now, idEmp: user.profileData.idEmployees!),
                                    );
                                    // widget.bloc.add(
                                    //   GetCurrentAddress(
                                    //       lat: widget.lat,
                                    //       lng: widget.lng,
                                    //       now: now),
                                    // );
                                    // widget.bloc.add(GetIsCheckIn(
                                    //     idEmp: user.profileData.idEmployees!,
                                    //     now: now));
                                  });
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Text(
                                    "${AppLocalizations.of(context)!.startyourjourney}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                              )
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xffE46A76),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    )),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.leftToRight,
                                        child: MileagePage(
                                          isCheckIn: false,
                                          lat: widget.lat,
                                          lng: widget.lng,
                                          locationName:
                                              "${state.address?.reversed.last.name} ${state.address?.reversed.last.street} ${state.address?.reversed.last.subLocality} "
                                              "${state.address?.reversed.last.locality} ${state.address?.reversed.last.postalCode} ${state.address?.reversed.last.country}",
                                        ),
                                      )).then((value) {
                                    widget.bloc.add(
                                      GetCurrentAddress(lat: widget.lat, lng: widget.lng, now: now, idEmp: user.profileData.idEmployees!),
                                    );
                                    // widget.bloc.add(
                                    //   GetCurrentAddress(
                                    //       lat: widget.lat,
                                    //       lng: widget.lng,
                                    //       now: now),
                                    // );
                                    // widget.bloc.add(GetIsCheckIn(
                                    //     idEmp: user.profileData.idEmployees!,
                                    //     now: now));
                                  });
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Text(
                                    "${AppLocalizations.of(context)!.endofjourney}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ],
                );
              }
              else if(state.status == FetchStatus.fetching){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LoadingAnimationWidget.inkDrop(
                            color: Colors.deepPurple,
                            size: 30
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text("กำลังดึงข้อมูล",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500,color: Colors.white),)
                      ],
                    ),
                  ],
                );
              }
              else {
                return Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.065,
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
