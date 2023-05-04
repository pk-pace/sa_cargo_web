import 'package:flutter/material.dart';
import 'package:sa_cargo_web/widgets/Navbar/navbar.dart';
import 'package:sa_cargo_web/widgets/centered_view/centered_view.dart';
import 'package:sa_cargo_web/widgets/dashboard_details/dashboard_details.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: CenteredView(
        child: Column(
          children: [
            Navbar(),
            Expanded(
              child: Row(
                children: [DashboardDetails()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
