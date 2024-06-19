import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:her_aid/viewmodels/dashboard/dashboard_viewmodel.dart';
import 'package:her_aid/viewmodels/view_model_provider.dart';
import 'package:her_aid/helpers/maps_helper.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  late DashboardViewModel vm;
  final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) => ViewModelProvider<DashboardViewModel>(
        viewModelBuilder: () => DashboardViewModel(),
        builder: (context, vm, child) {
          this.vm = vm;
          return _body(context);
        },
      );
  Scaffold _body(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: FutureBuilder<Widget>(
        future: MapHelper.buildMap(
          context,
          mapController: _mapController,
          userTrackingOption: const UserTrackingOption(
            enableTracking: true,
            unFollowUser: false,
          ),
        ),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!;
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
