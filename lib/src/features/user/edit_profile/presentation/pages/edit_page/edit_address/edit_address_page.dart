import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../../core/features/profile/presentation/provider/profile_provider.dart';
import '../../../provider/edit_profile_provider.dart';
import '../../../widgets/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditAddressPage extends StatefulWidget {
  final String title;
  final List<String> labels;
  final List<String> data;
  const EditAddressPage(
      {super.key,
      required this.title,
      required this.labels,
      required this.data});

  @override
  State<EditAddressPage> createState() => _EditAddressPageState();
}

class _EditAddressPageState extends State<EditAddressPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String houseNo = "";
  String village = "";
  String villageNo = "";
  String alley = "";
  String road = "";
  String subDistrict = "";
  String district = "";
  String province = "";
  String zipcode = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      houseNo = widget.data[0];
      village = widget.data[1];
      villageNo = widget.data[2];
      alley = widget.data[3];
      road = widget.data[4];
      subDistrict = widget.data[5];
      district = widget.data[6];
      province = widget.data[7];
      zipcode = widget.data[8];
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context, listen: true);
    final editProfileProvider =
        Provider.of<EditProfileProvider>(context, listen: false);
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xffEAEDF2),
      body: Consumer(builder: (context, EditProfileProvider data, child) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              EditAppbar(
                title: widget.title,
              ),
              const EditBackground(),
              const NameDetail(),
              Positioned(
                  top: 250,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).devicePixelRatio * 10,
                          vertical:
                              MediaQuery.of(context).devicePixelRatio * 3),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).devicePixelRatio * 10,
                            vertical:
                                MediaQuery.of(context).devicePixelRatio * 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              for (var i = 0; i < widget.data.length; i++) ...[
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: MediaQuery.of(context)
                                              .devicePixelRatio *
                                          3),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.labels[i],
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                                TextFormField(
                                  keyboardType:
                                      widget.labels[i] == "รหัสไปรษณีย์"
                                          ? TextInputType.phone
                                          : TextInputType.text,
                                  initialValue: widget.data[i],
                                  validator: (value) {
                                    RegExp regex =
                                        widget.labels[i] == "รหัสไปรษณีย์"
                                            ? RegExp(r'^\d{5}$')
                                            : RegExp(r"");
                                    if (value == null ||
                                        value.isEmpty ||
                                        value == "") {
                                      return "${AppLocalizations.of(context)!.pleaseFillRequiredInformation}";
                                    } else if (!regex.hasMatch(value)) {
                                      return "${AppLocalizations.of(context)!.pleaseFillInTheInformationAccurately}";
                                    }
                                    return null;
                                  },
                                  onChanged: (String value) {
                                    setState(() {
                                      if (i == 0) {
                                        houseNo = value;
                                      } else if (i == 1) {
                                        village = value;
                                      } else if (i == 2) {
                                        villageNo = value;
                                      } else if (i == 3) {
                                        district = value;
                                      } else if (i == 4) {
                                        road = value;
                                      } else if (i == 5) {
                                        subDistrict = value;
                                      } else if (i == 6) {
                                        district = value;
                                      } else if (i == 7) {
                                        province = value;
                                      } else if (i == 8) {
                                        zipcode = value;
                                      }
                                    });
                                  },
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 2.0),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    contentPadding: const EdgeInsets.all(10),
                                    labelStyle: TextStyle(
                                        fontSize: 18, color: Colors.grey),
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 2.0),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    errorStyle: TextStyle(fontSize: 15),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                )
                              ],
                              const SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 5,
                                  backgroundColor: const Color(0xffE793B8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    FocusScope.of(context).unfocus();
                                    editProfileProvider.sendEditAddressData(
                                        zipcode,
                                        district,
                                        province,
                                        alley,
                                        houseNo,
                                        road,
                                        subDistrict,
                                        village,
                                        villageNo);
                                    profileProvider.setAddress(
                                        zipcode,
                                        district,
                                        province,
                                        alley,
                                        houseNo,
                                        road,
                                        subDistrict,
                                        village,
                                        villageNo);
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                        "${AppLocalizations.of(context)!.datasavesuccessful}",
                                        style: TextStyle(fontSize: 17),
                                      ),
                                      backgroundColor: const Color(0xff6FC9E4),
                                      behavior: SnackBarBehavior.floating,
                                    ));
                                  } else {
                                    log("not success");
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    "${AppLocalizations.of(context)!.savedata}",
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        );
      }),
    ));
  }
}
