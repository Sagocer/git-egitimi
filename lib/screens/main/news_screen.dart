import 'package:antalyacomtr_v2/controllers/MenuController.dart';
import 'package:antalyacomtr_v2/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:antalyacomtr_v2/constants.dart';
import 'components/header.dart';
import 'components/side_menu.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuController>().scaffoldKeyNews,
      drawer: const SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              const Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Column(
                    children: [
                      const Header(
                        title: "News",
                      ),
                      const SizedBox(height: defaultPadding),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Column(
                              children: [
                                if (Responsive.isMobile(context)) const SizedBox(height: defaultPadding),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
