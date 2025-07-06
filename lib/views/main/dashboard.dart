import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../../viewmodels/main/dashboard_viewmodel.dart';
import '../../viewmodels/view_model_provider.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<DashboardViewModel>(
      viewModelBuilder: () => DashboardViewModel(),
      builder: (context, viewModel, child) {
        return Consumer<DashboardViewModel>(
          builder: (context, viewModel, child) {
            return Scaffold(
              body: viewModel.currentPage,
              bottomNavigationBar: SalomonBottomBar(
                currentIndex: viewModel.selectedIndex,
                selectedItemColor: const Color(0xFF81C784),
                unselectedItemColor: const Color(0xFF757575),
                onTap: viewModel.onBottomNavTap,
                items: viewModel.navBarItems,
                backgroundColor: Colors.white,
              ),
            );
          },
        );
      },
    );
  }
}
