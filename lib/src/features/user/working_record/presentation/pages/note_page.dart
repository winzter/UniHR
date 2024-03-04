import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../../../../core/features/profile/presentation/provider/profile_provider.dart';
import '../bloc/WorkRecord_bloc.dart';
import '../widgets/appBar.dart';
import 'end_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotePage extends StatefulWidget {
  final List<Placemark> address;

  final WorkRecordBloc bloc;

  const NotePage({super.key, required this.address, required this.bloc});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? note;

  @override
  Widget build(BuildContext context) {
    final ProfileProvider user = Provider.of<ProfileProvider>(context);
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            appBar: appBar(context),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        children: [
                          Text(
                            "${AppLocalizations.of(context)!.note}",
                            style: TextStyle(
                                fontSize: 27, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    Form(
                        key: formKey,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "${AppLocalizations.of(context)!.pleaseenteranote}";
                            }
                            return null;
                          },
                          onChanged: (message) {
                            setState(() {
                              note = message;
                            });
                          },
                          maxLines: 12,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              hintText:
                                  "${AppLocalizations.of(context)!.additionalNotes}",
                              hintStyle: TextStyle(fontSize: 18),
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              errorStyle: TextStyle()),
                        )),
                  ],
                ),
              ),
            ),
            floatingActionButton: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).devicePixelRatio * 5),
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      elevation: 5,
                      backgroundColor: const Color(0xffE793B8)),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      widget.bloc.add(SendWorkingRecordData(
                          idEmp: user.profileData.idEmployees!,
                          idCompany: user.profileData.idCompany!,
                          description: note,
                          context: context));
                      Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.leftToRight,
                            child: EndPage(
                              date: DateTime.now(),
                              address: widget.address,
                              isError: false,
                              isCheck: false,
                              note: note,
                            ),
                          ));
                    }
                  },
                  child: Text(
                    "${AppLocalizations.of(context)!.confirm}",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat));
  }
}
