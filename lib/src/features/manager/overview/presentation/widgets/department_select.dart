import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:unihr/src/features/manager/overview/presentation/bloc/overview_bloc.dart';
import 'package:unihr/src/features/manager/overview/presentation/widgets/department_dropdown.dart';
import '../../../../../core/features/profile/presentation/provider/profile_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DepartmentSelect extends StatefulWidget {
  final OverviewBloc bloc;
  final bool isExpanded;

  const DepartmentSelect(
      {super.key, required this.bloc, required this.isExpanded});

  @override
  State<DepartmentSelect> createState() => _DepartmentSelectState();
}

class _DepartmentSelectState extends State<DepartmentSelect>
    with SingleTickerProviderStateMixin {
  late AnimationController expandController;
  late Animation<double> animation;

  String? selectedValue;

  List<String> companyName = [];

  @override
  void initState() {
    super.initState();
    final ProfileProvider managerData = Provider.of<ProfileProvider>(context, listen: false);
    setState(() {
      selectedValue =
      AppLocalizations.supportedLocales == "th"
          ? managerData.profileData.companyName?.toString() ?? ''
          :managerData.profileData.companyName_EN?.toString()
          ?? managerData.profileData.companyName.toString();
      companyName.add(AppLocalizations.supportedLocales == "th"
          ? managerData.profileData.companyName?.toString() ?? ''
          :managerData.profileData.companyName_EN?.toString()
          ?? managerData.profileData.companyName.toString());
    });
    prepareAnimations();
    _runExpandCheck();
  }

  void prepareAnimations() {
    expandController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
  }

  void _runExpandCheck() {
    if (widget.isExpanded) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void didUpdateWidget(DepartmentSelect oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runExpandCheck();
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      axisAlignment: 1.0,
      sizeFactor: animation,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 20,
                    child: Text(
                      "${AppLocalizations.of(context)!.company} :",
                      style: AppLocalizations.supportedLocales == "th"
                          ? TextStyle(fontSize: 17)
                          : TextStyle(fontSize: 13),
                    )),
                Expanded(
                  flex: 80,
                  child: DropdownButton2(
                    alignment: Alignment.center,
                    underline: Container(),
                    buttonStyleData: ButtonStyleData(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black26,
                          ),
                          color: Colors.white),
                      elevation: 2,
                    ),
                    dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    )),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                      padding: EdgeInsets.only(left: 14, right: 14),
                    ),
                    items: companyName.map((String item) => DropdownMenuItem<String>(
                              value: item,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ))
                        .toList(),
                    value: selectedValue,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            BlocBuilder<OverviewBloc, OverviewState>(
              builder: (context, state) {
                return DepartmentDropdown(
                  bloc: widget.bloc,
                  title: AppLocalizations.of(context)!.division,
                  data: state.divisionName,
                  selectedValue: state.selectedDivisionName,
                );
              },
            ),
            const SizedBox(
              height: 15,
            ),
            BlocBuilder<OverviewBloc, OverviewState>(
              builder: (context, state) {
                return DepartmentDropdown(
                  bloc: widget.bloc,
                  title: AppLocalizations.of(context)!.section,
                  data: state.departmentName,
                  selectedValue: state.selectedDepartmentName,
                );
              },
            ),
            const SizedBox(
              height: 15,
            ),
            BlocBuilder<OverviewBloc, OverviewState>(
              builder: (context, state) {
                return DepartmentDropdown(
                  bloc: widget.bloc,
                  title: AppLocalizations.of(context)!.department,
                  data: state.sectionName,
                  selectedValue: state.selectedSectionName,
                );
              },
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.5,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff6FC9E4)),
                    onPressed: () {
                      widget.bloc.add(SearchOverviewData());
                    },
                    child: Text(
                      AppLocalizations.of(context)!.search,
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )))
          ],
        ),
      ),
    );
  }
}
