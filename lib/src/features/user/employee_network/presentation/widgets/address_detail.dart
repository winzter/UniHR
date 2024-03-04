import 'package:flutter/material.dart';

class AddressDetail extends StatelessWidget {

  final String address;
  const AddressDetail({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.location_on,color: Colors.redAccent,),
          Flexible(
              child: Text(
                address,
                style: TextStyle(
                    fontSize: 18),
              )),
        ],
      ),
    );
  }
}
