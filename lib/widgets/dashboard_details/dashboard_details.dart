import 'package:flutter/material.dart';

class DashboardDetails extends StatelessWidget {
  const DashboardDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'DASHBOARD \nSCREEN',
            style: TextStyle(
                fontWeight: FontWeight.w800, height: 0.9, fontSize: 80),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'This screen will serve as the dashboard. The purpose of this screen is to provide SA Cargo personnel with a high-level overview of the apps performance and key data.',
            style: TextStyle(
              fontSize: 21,
              height: 1.7,
            ),
          )
        ],
      ),
    );
  }
}
