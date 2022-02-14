//bu bir github denemesidir
//bu bir githup denemesi 2 dir 
import 'package:antalyacomtr_v2/controllers/MenuController.dart';
import 'package:antalyacomtr_v2/providers/categories.dart';
import 'package:antalyacomtr_v2/providers/listings.dart';
import 'package:antalyacomtr_v2/screens/catagory_add.dart';
import 'package:antalyacomtr_v2/screens/main/add_category.dart';
import 'package:antalyacomtr_v2/screens/main/add_listings_screen.dart';
import 'package:antalyacomtr_v2/screens/main/edit_category_screen.dart';
import 'package:antalyacomtr_v2/screens/main/edit_listings_screens.dart';
import 'package:antalyacomtr_v2/screens/main/listings_screen.dart';
import 'package:antalyacomtr_v2/screens/main/main_screen.dart';
import 'package:antalyacomtr_v2/screens/main/news_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'routes.dart';
import 'providers/news.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  // Here we set the URL strategy for our web app.
  // It is safe to call this function when running on mobile or desktop as well.
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: News(),
        ),
        ChangeNotifierProvider.value(
          value: Listings(),
        ),
        ChangeNotifierProvider.value(
          value: Categories(),
        ),
        ChangeNotifierProvider(
          create: (context) => MenuController(),
        ),
      ],
      child: MaterialApp(
        title: 'Antalya-#sunandmore',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme).apply(bodyColor: Colors.black),
        ),
        initialRoute: Routes.home,
        onGenerateRoute: (RouteSettings settings) {
          return Routes.fadeThrough(settings, (context) {
            // print(settings.name);
            // print(Routes.listingDetail);
            // print(Routes.home);
            switch (settings.name) {
              case Routes.home:
                return const MainScreen();
              case Routes.listings:
                return const ListingsScreen();
              case Routes.addListings:
                return NewListingScreen();
              case Routes.editListings:
                return const EditListingScreen();
              case Routes.addCategories:
                return NewCategoryScreenn();
              case Routes.editCategories:
                return EditCategoryScreen();

              case Routes.newsScreen:
                return const NewsScreen();
              default:
                return const SizedBox.shrink();
            }
          });
        },
        /* onUnknownRoute: (settings) {
          return MaterialPageRoute(builder: (ctx) => EditListingScreen());
        },*/
      ),
    );
  }
}
