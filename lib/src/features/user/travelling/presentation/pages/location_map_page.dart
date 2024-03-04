import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../../components/widgets/appbar.dart';
import '../../../../../core/error/token_expires.dart';
import '../../domain/entities/travelling_time_line_entity.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocationMapPage extends StatefulWidget {
  final TravellingTimeLineEntity data;

  final bool isIn;

  const LocationMapPage({Key? key, required this.data, required this.isIn})
      : super(key: key);

  @override
  _LocationMapPageState createState() => _LocationMapPageState();
}

class _LocationMapPageState extends State<LocationMapPage> {
  @override
  void initState() {
    super.initState();
    TokenExpires.checkTokenExpires(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "${AppLocalizations.of(context)!.travelhistory}"),
      body: Stack(
        children: [
          GoogleMap(
            compassEnabled: true,
            initialCameraPosition: CameraPosition(
                zoom: 18,
                target: widget.isIn
                    ? LatLng(widget.data.latitudeIn!, widget.data.longitudeIn!)
                    : LatLng(
                        widget.data.latitudeOut!, widget.data.longitudeOut!)),
            markers: {
              Marker(
                markerId: MarkerId('Sydney'),
                position: widget.isIn
                    ? LatLng(widget.data.latitudeIn!, widget.data.longitudeIn!)
                    : LatLng(
                        widget.data.latitudeOut!, widget.data.longitudeOut!),
              )
            },
          ),
          Container(
            padding: const EdgeInsets.all(15),
            width: MediaQuery.of(context).size.width,
            decoration:
                BoxDecoration(color: Color(0xFFFFFFFF).withOpacity(0.7)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "${AppLocalizations.of(context)!.location}: ",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    Flexible(
                        child: Text(
                            widget.isIn
                                ? widget.data.locationNameIn!
                                : widget.data.locationNameIn!,
                            style: TextStyle(fontSize: 17))),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "${AppLocalizations.of(context)!.date}: ",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    Flexible(
                        child: Text(
                            widget.data.attendanceDateTimeText!
                                .substring(0, 10),
                            style: TextStyle(fontSize: 17))),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "${AppLocalizations.of(context)!.date}: ",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    Flexible(
                        child: Text(
                            widget.isIn
                                ? widget.data.timeIn!
                                : widget.data.timeOut!,
                            style: TextStyle(fontSize: 17))),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
