import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import '../../../../../../injection_container.dart';
import '../../../../../core/features/profile/presentation/provider/profile_provider.dart';
import '../bloc/LocationBloc_bloc.dart';
import '../widgets/mileage/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MileagePage extends StatefulWidget {
  final bool isCheckIn;

  final double lat;
  final double lng;

  final String locationName;

  const MileagePage(
      {super.key,
      required this.isCheckIn,
      required this.lat,
      required this.lng,
      required this.locationName});

  @override
  State<MileagePage> createState() => _MileagePageState();
}

class _MileagePageState extends State<MileagePage> {
  final LocationBloc bloc = sl<LocationBloc>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String pin = '';

  @override
  Widget build(BuildContext context) {
    final ProfileProvider user = Provider.of<ProfileProvider>(context);
    return BlocProvider(
      create: (context) => bloc,
      child: Scaffold(
        appBar: MileageAppBar(context),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).devicePixelRatio * 5,
                horizontal: MediaQuery.of(context).devicePixelRatio * 5),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).devicePixelRatio * 10),
                    decoration: BoxDecoration(
                      color: widget.isCheckIn
                          ? const Color(0xff87DC45)
                          : const Color(0xffDC4545),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.1,
                              ),
                              child: Text(
                                widget.isCheckIn
                                    ? "${AppLocalizations.of(context)!.startyourjourney}"
                                    : "${AppLocalizations.of(context)!.endofjourney}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Divider(
                            color: Colors.white,
                            indent: 30,
                            endIndent: 30,
                            thickness: 1,
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width * 0.1,
                                  bottom: MediaQuery.of(context).size.height *
                                      0.02),
                              child: Text(
                                widget.isCheckIn
                                    ? "${AppLocalizations.of(context)!.enteramileageabeforetravelling}"
                                    : "${AppLocalizations.of(context)!.enterthemileagewhenyoureach}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Pinput(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "กรุณากรอกรเลขไมล์";
                                } else if (value.length != 6) {
                                  return "กรุณากรอกเลขไมล์ให้ครบ";
                                }
                                return null;
                              },
                              onTapOutside: (event) {
                                FocusScope.of(context).unfocus();
                              },
                              onChanged: (value) {
                                setState(() {
                                  pin = value;
                                });
                              },
                              defaultPinTheme: PinTheme(
                                  width:
                                      MediaQuery.of(context).size.width * 0.115,
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  textStyle: TextStyle(fontSize: 20),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Colors.white,
                                  )),
                              length: 6,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).devicePixelRatio * 65),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            elevation: 5,
                            backgroundColor: const Color(0xffE793B8)),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            bloc.add(SendRouteRecordData(
                              idEmp: user.profileData.idEmployees!,
                              date: DateTime.now(),
                              isCheckIn: widget.isCheckIn,
                              mile: pin,
                              type: 'area',
                              context: context,
                              idCompany: user.profileData.idCompany!,
                              location: widget.locationName,
                              lat: widget.lat,
                              lng: widget.lng,
                            ));
                          }
                        },
                        child: Text(
                          "${AppLocalizations.of(context)!.confirm}",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
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
