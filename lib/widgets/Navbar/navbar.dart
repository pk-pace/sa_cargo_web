import 'package:flutter/material.dart';
import 'package:sa_cargo_web/screens/home/home_screen.dart';
import 'package:sa_cargo_web/screens/new_manifest/new_manifest_screen.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              height: 80,
              width: 80,
              child: Image.asset('assets/images/sa_cargo_logo.png'),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        new MaterialPageRoute(
                          builder: (context) => new HomeScreen(),
                        ),
                      );
                    },
                    child: _NavbarItem(title: "Dashboard")),
                SizedBox(
                  width: 60,
                ),
                InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        new MaterialPageRoute(
                          builder: (context) => new NewManifestScreen(),
                        ),
                      );
                    },
                    child: _NavbarItem(title: "New Manifest")),
              ],
            )
          ]),
    );
  }
}

class _NavbarItem extends StatelessWidget {
  final String title;
  const _NavbarItem({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
      ),
    );
  }
}
