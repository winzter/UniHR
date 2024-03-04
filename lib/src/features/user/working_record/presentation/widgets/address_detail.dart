import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../../../../core/features/profile/presentation/provider/profile_provider.dart';
import '../bloc/WorkRecord_bloc.dart';
import '../pages/note_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddressDetail extends StatelessWidget {
  final List<Placemark> address;
  final bool isCheck;

  final WorkRecordBloc bloc;

  const AddressDetail(
      {super.key,
      required this.address,
      required this.isCheck,
      required this.bloc});

  @override
  Widget build(BuildContext context) {
    final ProfileProvider user = Provider.of<ProfileProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).devicePixelRatio * 3),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: Colors.white),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on,
                  color: Color(0xffFF6575),
                  size: 30,
                ),
                const SizedBox(
                  width: 5,
                ),
                Flexible(
                  child: Text(
                    "${address.reversed.last.name ?? ''} ${address.reversed.last.street ?? ''} ${address.reversed.last.subLocality ?? ''} "
                    "${address.reversed.last.locality ?? ''} ${address.reversed.last.postalCode ?? ''} ${address.reversed.last.country ?? ''}",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).devicePixelRatio * 10,
                  horizontal: MediaQuery.of(context).devicePixelRatio * 10),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 10, backgroundColor: Color(0xff6FC9E4)),
                  onPressed: () {
                    if (isCheck) {
                      bloc.add(SendWorkingRecordData(
                          idEmp: user.profileData.idEmployees!,
                          idCompany: user.profileData.idCompany!,
                          description: "",
                          context: context));
                    } else {
                      Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.leftToRight,
                            child: NotePage(
                              address: address,
                              bloc: bloc,
                            ),
                          ));
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${AppLocalizations.of(context)!.confirm}",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
