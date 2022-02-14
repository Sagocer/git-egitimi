import 'dart:math';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:antalyacomtr_v2/controllers/MenuController.dart';
import 'package:antalyacomtr_v2/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:antalyacomtr_v2/constants.dart';
import '../../providers/categories.dart';
import '../../providers/listings.dart';
import '../../routes.dart';
import 'components/header.dart';
import 'components/side_menu.dart';
import 'package:antalyacomtr_v2/models/locations.dart';

bool checkbosvalue = false;

class ListingsScreen extends StatefulWidget {
  const ListingsScreen({Key? key}) : super(key: key);

  @override
  State<ListingsScreen> createState() => _ListingsScreenState();
}

class _ListingsScreenState extends State<ListingsScreen> {
  Engine? _engine;
  var _isInit = true;
  var _isLoading = false;
  var categoryIndexTemp = 1;
  var categoryChoiceIndex;
  final breadcrumbarray = [0];
  final breadcrumbarrayNames = ["Ana kategoriler"];
  @override
  void initState() {
    _engine = Engine();
    categoryChoiceIndex = 0;
    super.initState();
  }

  void _categoryForListing(int id) {
    //_counter++;
    setState(() {
      categoryIndexTemp = id;
    });
  }

  void _categoryChoiceIndex(int id) {
    //_counter++;
    setState(() {
      categoryChoiceIndex = id;
    });
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      try {
        Provider.of<Categories>(context).fetchAndSetCategoriesByParents(categoryChoiceIndex).then((_) {
          setState(() {
            _isLoading = false;
          });
        });

        Provider.of<Listings>(context).fetchByListingsCategory(categoryIndexTemp).then((_) {
          setState(() {
            _isLoading = false;
          });
        });
      } catch (error) {
        print(error);
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final listingData = Provider.of<Listings>(context);
    final categoriesData = Provider.of<Categories>(context);
    return Scaffold(
      key: context.read<MenuController>().scaffoldKeyListings,
      drawer: const SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              const Expanded(
                child: SideMenu(),
              ),
            Expanded(
              flex: 5,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: SingleChildScrollView(
                    child: Wrap(
                      children: [
                        const Header(
                          title: "Listings",
                        ),
                        const SizedBox(height: defaultPadding),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(context).pushNamed(Routes.addCategories, arguments: categoryChoiceIndex);
                          },
                          icon: Icon(Icons.add, size: 18),
                          label: Text("Kategori Ekle"),
                          style: ElevatedButton.styleFrom(primary: Color(0xFFF38F1D), textStyle: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500)),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Center(
                                child: Wrap(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        color: Colors.yellow,
                                        width: double.infinity,
                                        height: 50,
                                        child: Center(
                                            child: ValueListenableBuilder<String>(
                                                valueListenable: _engine!.parentCategoryNameValue,
                                                builder: (context, value, _) {
                                                  return Text('$value', style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0, color: Colors.black));
                                                })),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8),
                                      child: BreadCrumb.builder(
                                          itemCount: breadcrumbarray.length,
                                          builder: (index) {
                                            return BreadCrumbItem(
                                                onTap: () async {
                                                  // await Provider.of<Categories>(context, listen: false).fetchAndSetCategoriesByParents(breadcrumbarray[index]);

                                                  print(index);

                                                  //await Provider.of<Listings>(context, listen: false).fetchByListingsCategory(breadcrumbarray[index]);

                                                  //_engine!.decrement(breadcrumbarrayNames[index]);

                                                  // await Future.delayed(Duration(milliseconds: 800));

                                                  //_engine!.statusCodeVerify(listingData.responseMap!);
                                                },
                                                content: Text('${breadcrumbarrayNames[index]} > '));
                                          }),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        color: Colors.white,
                                        elevation: 20,
                                        child: SizedBox(
                                            height: 400,
                                            width: double.infinity,
                                            child: ValueListenableBuilder<bool>(
                                                valueListenable: _engine!.statusCategoryValue,
                                                builder: (context, value, _) {
                                                  return value
                                                      ? const Padding(
                                                          padding: EdgeInsets.all(8),
                                                          child: Text(
                                                            'BOŞ kategori',
                                                            textAlign: TextAlign.center,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                                                          ),
                                                        )
                                                      : Padding(
                                                          padding: const EdgeInsets.all(8),
                                                          child: ListView.builder(
                                                            itemCount: categoriesData.categories.length,
                                                            itemBuilder: (_, i) => Column(
                                                              children: [
                                                                Theme(
                                                                  data: ThemeData(unselectedWidgetColor: Colors.black),
                                                                  child: ListTile(
                                                                    onTap: () async {
                                                                      try {
                                                                        setState(() {
                                                                          _categoryChoiceIndex(categoriesData.categories[i].categoryID!);
                                                                        });
                                                                        ///////breadddd
                                                                        breadcrumbarray.add(categoriesData.categories[i].categoryID!);

                                                                        breadcrumbarrayNames.add(categoriesData.categories[i].title!);

                                                                        print(breadcrumbarrayNames);

                                                                        /////////////
                                                                        _engine!.parentname(categoriesData.categories[i].title!);

                                                                        await Provider.of<Categories>(context, listen: false).fetchAndSetCategoriesByParents(categoriesData.categories[i].categoryID!);

                                                                        await Future.delayed(Duration(milliseconds: 800));
                                                                      } catch (error) {}

                                                                      setState(() {
                                                                        Provider.of<Listings>(context, listen: false).fetchByListingsCategory(categoriesData.categories[i].categoryID!);

                                                                        _engine!.statusCodeCatVerify(categoriesData.responseMap!);

                                                                        // todo : look at categoryChoiceIndex again and delete print(debugs);
                                                                        //    categoryChoiceIndex = categoriesData.categories[i].categoryID!;
                                                                      });

                                                                      _categoryForListing(categoriesData.categories[i].categoryID!);

                                                                      _engine!.decrement(categoriesData.categories[i].title!);

                                                                      Provider.of<Listings>(context, listen: false).fetchByListingsCategory(categoriesData.categories[i].categoryID!);

                                                                      await Future.delayed(Duration(milliseconds: 800));

                                                                      _engine!.statusCodeVerify(listingData.responseMap!);

                                                                      /*categoryIndexTemp = categoriesData
                                                                                                                  .categories[i].categoryID!; */
                                                                    },
                                                                    title: Text(
                                                                      categoriesData.categories[i].title!,
                                                                      style: TextStyle(color: Colors.black),
                                                                    ),
                                                                    trailing: Container(
                                                                      width: 100,
                                                                      child: Row(
                                                                        children: <Widget>[
                                                                          IconButton(
                                                                            icon: Icon(Icons.edit),
                                                                            onPressed: () {
                                                                              Navigator.of(context).pushNamed(Routes.editCategories, arguments: categoriesData.categories[i].categoryID!);
                                                                            },
                                                                            color: Theme.of(context).primaryColor,
                                                                          ),
                                                                          IconButton(
                                                                            icon: Icon(Icons.delete),
                                                                            onPressed: () async {
                                                                              try {
                                                                                await Provider.of<Categories>(context, listen: false).deleteCategories(categoriesData.categories[i].categoryID!);
                                                                              } catch (error) {}
                                                                            },
                                                                            color: Theme.of(context).errorColor,
                                                                          ),
                                                                          /*
                                                                          IconButton(
                                                                            icon:
                                                                                const Icon(Icons.search),
                                                                            onPressed:
                                                                                () async {
                                                                              try {
                                                                                setState(() {
                                                                                  _categoryChoiceIndex(categoriesData.categories[i].categoryID!);
                                                                                });

                                                                                _engine!.parentname(categoriesData.categories[i].title!);

                                                                                await Provider.of<Categories>(context, listen: false).fetchAndSetCategoriesByParents(categoriesData.categories[i].categoryID!);

                                                                                await Future.delayed(Duration(milliseconds: 800));
                                                                              } catch (error) {}

                                                                              setState(() {
                                                                                Provider.of<Listings>(context, listen: false).fetchByListingsCategory(categoriesData.categories[i].categoryID!);

                                                                                _engine!.statusCodeCatVerify(categoriesData.responseMap!);

                                                                                // todo : look at categoryChoiceIndex again and delete print(debugs);
                                                                                //    categoryChoiceIndex = categoriesData.categories[i].categoryID!;
                                                                              });
                                                                            },
                                                                            color:
                                                                                Theme.of(context).errorColor,
                                                                          ),
                                                                          IconButton(
                                                                            icon:
                                                                                Icon(Icons.arrow_right_alt),
                                                                            onPressed:
                                                                                () async {
                                                                              try {
                                                                                setState(() {
                                                                                  _categoryChoiceIndex(categoriesData.categories[i].categoryID!);
                                                                                });

                                                                                _engine!.parentname(categoriesData.categories[i].title!);

                                                                                await Provider.of<Categories>(context, listen: false).fetchAndSetCategoriesByParents(categoriesData.categories[i].categoryID!);

                                                                                await Future.delayed(Duration(milliseconds: 800));
                                                                              } catch (error) {}

                                                                              setState(() {
                                                                                Provider.of<Listings>(context, listen: false).fetchByListingsCategory(categoriesData.categories[i].categoryID!);

                                                                                _engine!.statusCodeCatVerify(categoriesData.responseMap!);

                                                                                // todo : look at categoryChoiceIndex again and delete print(debugs);
                                                                                //    categoryChoiceIndex = categoriesData.categories[i].categoryID!;
                                                                              });

                                                                              _categoryForListing(categoriesData.categories[i].categoryID!);

                                                                              _engine!.decrement(categoriesData.categories[i].title!);

                                                                              Provider.of<Listings>(context, listen: false).fetchByListingsCategory(categoriesData.categories[i].categoryID!);

                                                                              await Future.delayed(Duration(milliseconds: 800));

                                                                              _engine!.statusCodeVerify(listingData.responseMap!);

                                                                              /*categoryIndexTemp = categoriesData
                                                                                                                  .categories[i].categoryID!; */
                                                                            },
                                                                            color:
                                                                                Theme.of(context).primaryColor,
                                                                          ),
                                                                          */
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Divider(
                                                                  color: Colors.black.withOpacity(0.2),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                })),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 50,
                                        color: Color(0xFF2697FF),
                                        child: Center(
                                            child: ValueListenableBuilder<String>(
                                                valueListenable: _engine!.categoryNameValue,
                                                builder: (context, value, _) {
                                                  return Text(' $value' + ' liste öğeleri', style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0, color: Colors.black));
                                                })),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                          color: Colors.white,
                                          elevation: 20,
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  ElevatedButton.icon(
                                                    onPressed: () {
                                                      Navigator.of(context).pushNamed(Routes.addListings, arguments: categoryIndexTemp);
                                                    },
                                                    icon: const Icon(Icons.add, size: 18),
                                                    label: const Text(
                                                      "Listing Ekle",
                                                    ),
                                                    style: ElevatedButton.styleFrom(primary: Color(0xFFF38F1D), textStyle: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500)),
                                                  ),
                                                  SizedBox(
                                                      width: 200,
                                                      child: InputDecorator(
                                                        decoration: InputDecoration(hintText: 'location', labelText: 'location', border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                                                        child: DropdownButtonHideUnderline(
                                                            child: DropdownButton<String>(
                                                          value: getLocations[dropdownLocation!].name,
                                                          isDense: true,
                                                          icon: const Icon(Icons.arrow_downward),
                                                          elevation: 10,
                                                          onChanged: (val) async {
                                                            setState(() {
                                                              dropdownLocation = getLocations.indexWhere((element) => element.name == val);
                                                            });
                                                            int location = dropdownLocation! + 1;
                                                            print(location);
                                                            if (location == 1) {
                                                              print("categoryChoiceIndex");
                                                              print(categoryChoiceIndex);
                                                              Provider.of<Listings>(context, listen: false).fetchByListingsCategory(categoryIndexTemp);

                                                              await Future.delayed(Duration(milliseconds: 800));

                                                              _engine!.statusCodeVerify(listingData.responseMap!);

                                                              _engine!.statusCodeVerify(listingData.responseMap!);
                                                            } else {
                                                              Provider.of<Listings>(context, listen: false).fetchByListingsCategoryAndLocation(categoryIndexTemp, location);

                                                              await Future.delayed(Duration(milliseconds: 800));

                                                              _engine!.statusCodeVerify(listingData.responseMap!);

                                                              _engine!.statusCodeVerify(listingData.responseMap!);
                                                            }
                                                          },
                                                          items: getLocations.map((Locations loc) {
                                                            return DropdownMenuItem<String>(
                                                              value: loc.name,
                                                              child: Text(loc.name),
                                                            );
                                                          }).toList(),
                                                        )),
                                                      )),
                                                ],
                                              ),
                                              SizedBox(
                                                  height: 400,
                                                  width: double.infinity,
                                                  child: ValueListenableBuilder<bool>(
                                                      valueListenable: _engine!.statusCodeValue,
                                                      builder: (context, value, _) {
                                                        return value
                                                            ? const Padding(
                                                                padding: EdgeInsets.all(8),
                                                                child: Text(
                                                                  'Boş Liste',
                                                                  textAlign: TextAlign.center,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                                                                ),
                                                              )
                                                            : Padding(
                                                                padding: const EdgeInsets.all(8),
                                                                child: ListView.builder(
                                                                  itemCount: listingData.listings.length,
                                                                  itemBuilder: (_, i) => Column(
                                                                    children: [
                                                                      ListTile(
                                                                        title: Text(
                                                                          listingData.listings[i].title!,
                                                                          style: TextStyle(color: Colors.black),
                                                                        ),
                                                                        leading: const CircleAvatar(
                                                                          backgroundColor: Colors.amber,
                                                                          // backgroundImage: NetworkImage(imageUrl),
                                                                        ),
                                                                        trailing: Container(
                                                                          width: 100,
                                                                          child: Row(
                                                                            children: <Widget>[
                                                                              IconButton(
                                                                                icon: Icon(Icons.edit),
                                                                                onPressed: () {
                                                                                  Navigator.of(context).pushNamed(Routes.editListings, arguments: listingData.listings[i].listingID!);
                                                                                },
                                                                                color: Theme.of(context).primaryColor,
                                                                              ),
                                                                              IconButton(
                                                                                icon: Icon(Icons.delete),
                                                                                onPressed: () async {
                                                                                  try {
                                                                                    await Provider.of<Listings>(context, listen: false).deleteListing(listingData.listings[i].listingID!);
                                                                                  } catch (error) {}
                                                                                },
                                                                                color: Theme.of(context).errorColor,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Divider(
                                                                        color: Colors.black.withOpacity(0.2),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                      })),
                                            ],
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
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

class Engine {
  //ValueNotifier<int> parentChangingValue = ValueNotifier(0);
  ValueNotifier<String> parentCategoryNameValue = ValueNotifier("Ana kategoriler");
  ValueNotifier<String> categoryNameValue = ValueNotifier("Ana kategori 1");
  ValueNotifier<bool> statusCodeValue = ValueNotifier(false);
  ValueNotifier<bool> statusCategoryValue = ValueNotifier(false);
  ValueNotifier<bool> statusCategoryEventValue = ValueNotifier(false);
  ValueNotifier<Color> color = ValueNotifier(Colors.black);

  void statusCodeVerify(int status) {
    statusCodeValue.value = (404 == status);
  }

  void statusCodeCatVerify(int status) {
    statusCategoryValue.value = (404 == status);
  }

  void statusCodeEventVerify(int status) {
    statusCategoryEventValue.value = (404 == status);
  }

/*   void increment(int id) {
    parentChangingValue.value = id;
  } */

  void parentname(String parentname) {
    parentCategoryNameValue.value = parentname + "'ın alt kategorileri";
  }

  void decrement(String categoryName) {
    categoryNameValue.value = categoryName;
  }

  void randomColor() {
    color.value = Colors.primaries[Random().nextInt(Colors.primaries.length)];
  }

  void dispose() {
    //parentChangingValue.dispose();
    categoryNameValue.dispose();
    parentCategoryNameValue.dispose();
    color.dispose();
    statusCodeValue.dispose();
  }
}
