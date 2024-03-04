import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class AddressDetail extends StatelessWidget {

  final List<Placemark> address;
  const AddressDetail({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
