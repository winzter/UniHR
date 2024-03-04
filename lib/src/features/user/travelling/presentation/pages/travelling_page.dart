import 'package:flutter/material.dart';
import '../widgets/map.dart';
import '../widgets/travelling_appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TravellingPage extends StatefulWidget {
  const TravellingPage({super.key});

  @override
  State<TravellingPage> createState() => _TravellingPageState();
}

class _TravellingPageState extends State<TravellingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TravellingAppBar(
            context, "${AppLocalizations.of(context)!.travelling}"),
        body: MapPage());
  }
}
