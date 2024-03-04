import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class TypeDropdown extends StatelessWidget {
  final List<String> data;
  const TypeDropdown({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).devicePixelRatio * 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "ประเภท",
            style: TextStyle(fontSize: 17),
          ),
          SizedBox(
            height: 35,
            width: 250,
            child: DropdownButtonFormField2(
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  errorStyle: TextStyle(fontSize: 14),
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20),
                  border: const OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(5))),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "เลือกประเภทการลา";
                  }
                  return null;
                },
                style: TextStyle(
                    color: Colors.black, fontSize: 15),
                hint: Text(
                  "เลือกประเภทการลา",
                  style: TextStyle(
                      fontSize: 18, color: Colors.grey),
                ),
                isExpanded: true,
                dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                items: data
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(fontSize: 18),
                      ));
                }).toList(),
                onChanged: (String? value) {
                  // widget.bloc.add(ChangeLocation(selectedLocation: value!));
                }),
          ),
        ],
      ),
    );
  }
}
