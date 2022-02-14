import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:antalyacomtr_v2/routes.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        width: 225,
        decoration: const BoxDecoration(color: Color(0xFF103667)),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(children: <Widget>[
                DrawerHeader(
                  child: InkWell(
                    child: Image.asset(
                      "assets/images/antalyacomtr_logo.png",
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(Routes.home, arguments: null);
                    },
                  ),
                ),
                DrawerListTile(
                  title: "Listing",
                  press: () {
                    Navigator.of(context).pushNamed(Routes.listings, arguments: null);
                  },
                ),
                DrawerListTile(
                  title: "Events",
                  press: () {},
                ),
                DrawerListTile(
                  title: "News",
                  press: () {
                    Navigator.of(context).pushNamed(Routes.newsScreen, arguments: null);
                  },
                ),
              ]),
            ),
            Align(
                alignment: FractionalOffset.bottomCenter,
                child: Column(
                  children: <Widget>[
                    DrawerListTile(
                      title: "Admin Panel",
                      press: () {},
                    ),
                    DrawerListTile(
                      title: "Çıkış",
                      press: () {},
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.press,
  }) : super(key: key);

  final String title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: press,
        horizontalTitleGap: 0.0,
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            title,
            style: GoogleFonts.poppins(color: Color.fromARGB(255, 17, 0, 0), fontWeight: FontWeight.w500),
          ),
        ));
  }
}
