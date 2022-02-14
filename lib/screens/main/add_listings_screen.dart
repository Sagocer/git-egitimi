import 'package:antalyacomtr_v2/controllers/MenuController.dart';
import 'package:antalyacomtr_v2/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:antalyacomtr_v2/constants.dart';
import 'components/header.dart';
import 'components/side_menu.dart';
import 'package:antalyacomtr_v2/routes.dart';
import '../../providers/categories.dart';
import '../../providers/listings.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:html';

import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';
import 'package:intl/intl.dart';

import 'package:http_parser/http_parser.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocode/geocode.dart';

import 'package:map/map.dart';
import 'package:latlng/latlng.dart';
import 'package:antalyacomtr_v2/models/locations.dart';
import 'package:flutter/foundation.dart';

class NewListingScreen extends StatefulWidget {
  final int count;

  final FormFieldSetter<List<bool>>? onSaved;

  final FormFieldSetter<List<TimeOfDay>>? onSavedStart;
  final FormFieldSetter<List<TimeOfDay>>? onSavedClose;

  const NewListingScreen({
    Key? key,
    this.count = 7,
    this.onSaved,
    this.onSavedStart,
    this.onSavedClose,
  }) : super(key: key);

  static const routeName = 'new-listings';
  @override
  _NewListingScreenState createState() => _NewListingScreenState();
}

class _NewListingScreenState extends State<NewListingScreen> {
  final List<String> days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];

  TimeOfDay? StartingTime = const TimeOfDay(hour: 01, minute: 30);
  TimeOfDay? FinishingTime = const TimeOfDay(hour: 12, minute: 12);

  final bool _isSelected = true;

  Future<void> _selectStartingTime(BuildContext context) async {
    final TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        // initialDate: _editedNews.publishDate!,
        initialTime: StartingTime!);
    var tempTime = StartingTime;

    print(selectedTime);
    if (selectedTime != null) {
      setState(() {
        StartingTime = selectedTime;
      });
    } else {
      setState(() {
        StartingTime = tempTime!;
      });
    }
  }

  Future<void> _selectFinishingTime(BuildContext context) async {
    final TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        // initialDate: _editedNews.publishDate!,
        initialTime: FinishingTime!);
    var tempTime = FinishingTime;

    print(selectedTime);
    if (selectedTime != null) {
      setState(() {
        FinishingTime = selectedTime;
      });
    } else {
      setState(() {
        FinishingTime = tempTime!;
      });
    }
  }

  final HtmlEditorController htmlController = HtmlEditorController();
  var categoryId;

  List<String> imglang = [];
  List<bool> imgSortOrder = [];
  List<bool> imgMainImage = [];

  final _locationIDFocusNode = FocusNode();
  final _categoryIDsNode = FocusNode();
  final _displayFocusNode = FocusNode();
  final _viewCountFocusNode = FocusNode();
  final _isPaidFocusNode = FocusNode();
  final _contactIDFocusNode = FocusNode();

  final _coordinateFocusNode = FocusNode();

  //final _imageUrlFocusNode = FocusNode();
  //final _imageUrlController = TextEditingController();

  final _addressFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _websiteFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _facebookFocusNode = FocusNode();
  final _instagramFocusNode = FocusNode();
  final _youtubeFocusNode = FocusNode();
  final _pinterestFocusNode = FocusNode();
  final _twitterFocusNode = FocusNode();
  final _whatsappFocusNode = FocusNode();

  final _langFocusNode = FocusNode();
  final _showAllFocusNode = FocusNode();
  final _titleFocusNode = FocusNode();
  final _sefFocusNode = FocusNode();
  final _contentFocusNode = FocusNode();
  final _imagelangFocusNode = FocusNode();
  final _imagesortOrderFocusNode = FocusNode();
  final _imageMainImageFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  var _editedListing = ListingsItem(locationID: 1, categoryIDs: "", display: true, viewCount: 3214, isPaid: true, contactID: 1, moduleID: 1, relationID: 3, coordinate: "", address: "", phone: "", website: "", email: "", facebook: "", instagram: "", youtube: "", pinterest: "", twitter: "", whatsapp: "", contentID: 1, lang: "", showAll: 1, title: "", sef: "", summary: "", content: "", trueFalseArray: [], startingTimeArray: [], finishingTimearray: []);

  var _isInit = true;
  var _isLoading = false;

  bool? dropdownIsPaid;
  bool? dropdownDisplay;

  bool? showAll;

  var _initValues = {
    "locationID": 1,
    "categoryIDs": "",
    "display": true,
    "viewCount": 3214,
    "isPaid": true,
    "contactID": 1,
    "moduleID": 1,
    "coordinate": "",
    "address": "",
    "phone": "",
    "website": "",
    "email": "",
    "facebook": "",
    "instagram": "",
    "youtube": "",
    "pinterest": "",
    "twitter": "",
    "whatsapp": "",
    "contentID": 1,
    "lang": "TR",
    "showAll": 1,
    "title": "",
    "sef": "",
    "summary": "",
    "content": "",
  };

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _locationIDFocusNode.dispose();
    _categoryIDsNode.dispose();
    _displayFocusNode.dispose();
    _viewCountFocusNode.dispose();
    _isPaidFocusNode.dispose();
    _contactIDFocusNode.dispose();

    _coordinateFocusNode.dispose();

    _addressFocusNode.dispose();
    _phoneFocusNode.dispose();
    _websiteFocusNode.dispose();
    _emailFocusNode.dispose();
    _facebookFocusNode.dispose();
    _instagramFocusNode.dispose();
    _youtubeFocusNode.dispose();
    _pinterestFocusNode.dispose();
    _twitterFocusNode.dispose();
    _whatsappFocusNode.dispose();

    _langFocusNode.dispose();
    _showAllFocusNode.dispose();
    _titleFocusNode.dispose();
    _sefFocusNode.dispose();
    _contentFocusNode.dispose();

    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Listings>(context, listen: false).addListings(_editedListing).then((int id) => uploadFile(id, 0).then((value) => {Navigator.of(context).pushNamed(Routes.home)}));
    } catch (error) {
      print(error);
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An error occurred!'),
          content: Text('Something went wrong.'),
          actions: <Widget>[
            FlatButton(
              child: Text('Okay'),
              onPressed: () {},
            )
          ],
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  final controller = MapController(location: LatLng(36.84372534219725, 30.606108206101506));

  Offset? _dragStart;
  double _scaleStart = 1.0;
  double lat = 36.84372534219725, long = 30.606108206101506;
  String address = "";
  bool loading = false;
  void _onScaleStart(ScaleStartDetails details) {
    _dragStart = details.focalPoint;
    _scaleStart = 1.0;
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    final scaleDiff = details.scale - _scaleStart;
    _scaleStart = details.scale;

    if (scaleDiff > 0)
      controller.zoom += 0.02;
    else if (scaleDiff < 0)
      controller.zoom -= 0.02;
    else {
      final now = details.focalPoint;
      final diff = now - _dragStart!;
      _dragStart = now;
      controller.drag(diff.dx, diff.dy);
    }
  }

  void _onScaleEnd(ScaleEndDetails details) async {
    try {
      setState(() {
        loading = true;
      });
      lat = controller.center.latitude;
      long = controller.center.longitude;

      var categoryId = 12;

      _editedListing =
          ListingsItem(locationID: _editedListing.locationID, categoryIDs: _editedListing.categoryIDs, display: _editedListing.display, viewCount: _editedListing.viewCount, isPaid: _editedListing.isPaid, contactID: _editedListing.contactID, moduleID: _editedListing.moduleID, coordinate: '$lat, $long', address: _editedListing.address, phone: _editedListing.phone, website: _editedListing.website, email: _editedListing.email, facebook: _editedListing.facebook, instagram: _editedListing.instagram, youtube: _editedListing.youtube, pinterest: _editedListing.pinterest, twitter: _editedListing.twitter, whatsapp: _editedListing.whatsapp, categoryID: categoryId, contentID: 2, lang: _editedListing.lang, showAll: 1, title: _editedListing.title, sef: _editedListing.sef, summary: _editedListing.summary, content: _editedListing.content, trueFalseArray: _editedListing.trueFalseArray, startingTimeArray: _editedListing.startingTimeArray, finishingTimearray: _editedListing.finishingTimearray);

      GeoCode geocode = GeoCode();
      Address add = await geocode.reverseGeocoding(latitude: lat, longitude: long);
      address = (add.countryName ?? '') + ' - ' + (add.region ?? '') + ' - ' + (add.city ?? '') + ' - ' + (add.streetAddress ?? '');
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  int? selectedfilessize; //secilen dosyalarin total boyutu
  List<int>? selectedfileslistasint; //secilen dosyalarin int formatinda tutuldugu liste
  List<File>? selectedfiles; //secilen dosyalarin tutuldugu liste
  List<Uint8List>? selectedfilesasUint8; //secilen dosyalarin Uint8 formatina donusturulmus halini tutar
  List<Uint8List>? imageshow;
  bool imageloading = false;

  /// IMAGE PİCKİNG FUNCTIONS
  startFilePicker() {
    setState(() {
      imageloading = true;
    });
    selectedfilessize = 0;
    selectedfilesasUint8 = [];
    imageshow = [];
    selectedfileslistasint = [];
    FileUploadInputElement uploadInput = FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.draggable = true;
    uploadInput.accept = '.png,.jpg'; //Hangi turlerde dosya secilebeilecekse uzantisi yazilir. tum dosya tiplerine izin vermek icin bu satırı yoruma al.
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      setState(() {
        selectedfiles = uploadInput.files; //secilen dosyalar selectedfiles degiskenine atılır.
      });

      //secilen dosyalarin toplam boyutu hesaplanir
      for (var i = 0; i < selectedfiles!.length; i++) {
        selectedfilessize = selectedfilessize! + selectedfiles![i].size;
      }

      //secilen dosyalar Uint8List formatinda yeni bir listeye aktarilir
      for (var i = 0; i < selectedfiles!.length; i++) {
        final reader = FileReader();
        reader.onLoadEnd.listen((e) {
          setState(() {
            selectedfilesasUint8!.add(reader.result as Uint8List);
            imglang.add("ml");
            imgSortOrder.add(false);
            imgMainImage.add(false);
          });
        });

        reader.readAsArrayBuffer(selectedfiles![i]);
      }
      imageloading = false;
    });
  }

  Future<http.Response?> uploadFile(int? listingID, int? countlastimages) async {
    try {
      var request = new http.MultipartRequest("POST", Uri.parse("https://agestmet.com/yigit/v2/controller/imageuploader.php"));
      print("AMK");
      //reguestte dosyalar ile birlikte gonderilecek bilgiler (request.fields) ile eklenir
      request.fields['listingID'] = listingID.toString();
      request.fields['imglang'] = imglang.toString();
      request.fields['imgSortOrder'] = imgSortOrder.toString();
      request.fields['imgMainImage'] = imgMainImage.toString();
      //gonderilecek dosyalar requeste eklenir
      for (var i = 0; i < selectedfilesasUint8!.length; i++) {
        selectedfileslistasint = List.from(selectedfilesasUint8![i]); //Uint8List formatındaki yuklenecek olan dosyaları int formatında listeye cevirir
        request.files.add(http.MultipartFile.fromBytes('file[]', selectedfileslistasint!, contentType: MediaType('application', 'octet-stream'), filename: selectedfiles![i].name));
      }

      //gerekli bilgiler eklenmis request gonderilir
      var streamedResponse = await request.send();

      return await http.Response.fromStream(streamedResponse);
    } catch (e) {
      Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    String htmlResult = '';
    var componentsData = Provider.of<Listings>(context);
    final categoriesData = Provider.of<Categories>(context);
    List<String> categoriesNameArray = <String>[];
    List<Object?> _selectedCategories = <String?>[];
    // todo: we can add initially using category ıd

    for (var i = 0; i < categoriesData.categories.length; i++) {
      categoriesNameArray.add(categoriesData.categories[i].title!);
    }
    print(categoriesNameArray);

    categoryId = ModalRoute.of(context)!.settings.arguments as int;
    if (categoryId == null) {
      Navigator.of(context).pushNamed(Routes.home);
    }

    return Scaffold(
      key: context.read<MenuController>().scaffoldKeyAddlistings,
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
                  child: Wrap(
                    children: [
                      const Header(
                        title: "Add Listing",
                      ),
                      const SizedBox(height: defaultPadding),
                      ElevatedButton.icon(
                        onPressed: _saveForm,
                        icon: Icon(Icons.save, size: 18),
                        label: Text("Save"),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Wrap(
                              children: [
                                SingleChildScrollView(
                                  child: Center(
                                    child: Column(children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Form(
                                            key: _form,
                                            child: SizedBox(
                                              height: 900,
                                              child: ListView(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: SizedBox(
                                                      width: double.infinity,
                                                      height: 400,

                                                      //map start
                                                      child: Stack(
                                                        children: [
                                                          Align(
                                                            alignment: Alignment.center,
                                                            child: GestureDetector(
                                                              onScaleStart: _onScaleStart,
                                                              onScaleUpdate: _onScaleUpdate,
                                                              onScaleEnd: _onScaleEnd,
                                                              child: Map(
                                                                controller: controller,
                                                                builder: (context, x, y, z) {
                                                                  final url = 'https://www.google.com/maps/vt/pb=!1m4!1m3!1i$z!2i$x!3i$y!2m3!1e0!2sm!3i420120488!3m7!2sen!5e1105!12m4!1e68!2m2!1sset!2sRoadmap!4e0!5m1!1e0!23i4111425';
                                                                  return CachedNetworkImage(
                                                                    imageUrl: url,
                                                                    fit: BoxFit.cover,
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment: Alignment.bottomRight,
                                                            child: Container(
                                                              margin: EdgeInsets.all(12),
                                                              child: Column(
                                                                mainAxisSize: MainAxisSize.min,
                                                                children: [MaterialButton(height: 50, minWidth: 50, color: Colors.blue, child: Icon(Icons.zoom_in, color: Colors.white), onPressed: () => controller.zoom += 0.2), SizedBox(height: 3), MaterialButton(height: 50, minWidth: 50, color: Colors.blue, child: Icon(Icons.zoom_out, color: Colors.white), onPressed: () => controller.zoom -= 0.2)],
                                                              ),
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment: Alignment.center,
                                                            child: Icon(
                                                              Icons.location_on_outlined,
                                                              size: 38,
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                          Positioned(
                                                            bottom: 10,
                                                            left: (MediaQuery.of(context).size.width * 0.5) - (MediaQuery.of(context).size.width * 0.37),
                                                            child: Card(
                                                              elevation: 12,
                                                              child: Container(
                                                                width: MediaQuery.of(context).size.width * 0.50,
                                                                height: 100,
                                                                padding: EdgeInsets.all(6),
                                                                child: Column(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  children: [
                                                                    Text("Coordinate",
                                                                        style: TextStyle(
                                                                          color: Colors.black,
                                                                        )),
                                                                    SelectableText('$lat ,$long',
                                                                        style: TextStyle(
                                                                          color: Colors.black,
                                                                        )),

                                                                    /*   loading
                                                ? CupertinoActivityIndicator()
                                                : Text('$address',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                    )) */
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),

                                                      // map ends
                                                    ),
                                                  ),
                                                  Wrap(children: <Widget>[
                                                    MultiSelectDialogField(
                                                      searchTextStyle: const TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                      title: const Text("Please choose corresponding categories",
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                          )),
                                                      items: categoriesNameArray.map((e) => MultiSelectItem(e, e)).toList(),
                                                      listType: MultiSelectListType.CHIP,
                                                      initialValue: _selectedCategories,
                                                      onConfirm: (values) {
                                                        _selectedCategories = values;
                                                        print(_selectedCategories);

                                                        _editedListing = ListingsItem(
                                                          locationID: _editedListing.locationID,
                                                          categoryIDs: _selectedCategories.toString(),
                                                          display: _editedListing.display,
                                                          viewCount: _editedListing.viewCount,
                                                          isPaid: _editedListing.isPaid,
                                                          contactID: _editedListing.contactID,
                                                          moduleID: _editedListing.moduleID,
                                                          coordinate: '$lat, $long',
                                                          address: _editedListing.address,
                                                          phone: _editedListing.phone,
                                                          website: _editedListing.website,
                                                          email: _editedListing.email,
                                                          facebook: _editedListing.facebook,
                                                          instagram: _editedListing.instagram,
                                                          youtube: _editedListing.youtube,
                                                          pinterest: _editedListing.pinterest,
                                                          twitter: _editedListing.twitter,
                                                          whatsapp: _editedListing.whatsapp,
                                                          categoryID: categoryId,
                                                          contentID: 2,
                                                          lang: _editedListing.lang,
                                                          showAll: 1,
                                                          title: _editedListing.title,
                                                          sef: _editedListing.sef,
                                                          summary: _editedListing.summary,
                                                          content: _editedListing.content,
                                                          trueFalseArray: _editedListing.trueFalseArray,
                                                          startingTimeArray: _editedListing.startingTimeArray,
                                                          finishingTimearray: _editedListing.finishingTimearray,
                                                        );
                                                      },
                                                    ),
                                                    Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: <Widget>[
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: ConstrainedBox(
                                                          constraints: BoxConstraints.tight(const Size(400, 50)),
                                                          child: TextFormField(
                                                            validator: (value) {
                                                              if (value!.isEmpty) {
                                                                return 'Please provide a value.';
                                                              }
                                                              return null;
                                                            },
                                                            initialValue: _initValues['address'].toString(),
                                                            decoration: InputDecoration(labelText: 'Address'),
                                                            // readOnly: listingId != 0 ? true : false,
                                                            onSaved: (value) {
                                                              _editedListing = ListingsItem(
                                                                locationID: _editedListing.locationID,
                                                                categoryIDs: _editedListing.categoryIDs,
                                                                display: _editedListing.display,
                                                                viewCount: _editedListing.viewCount,
                                                                isPaid: _editedListing.isPaid,
                                                                contactID: _editedListing.contactID,
                                                                moduleID: _editedListing.moduleID,
                                                                coordinate: _editedListing.coordinate,
                                                                address: value,
                                                                phone: _editedListing.phone,
                                                                website: _editedListing.website,
                                                                email: _editedListing.email,
                                                                facebook: _editedListing.facebook,
                                                                instagram: _editedListing.instagram,
                                                                youtube: _editedListing.youtube,
                                                                pinterest: _editedListing.pinterest,
                                                                twitter: _editedListing.twitter,
                                                                whatsapp: _editedListing.whatsapp,
                                                                contentID: 2,
                                                                categoryID: categoryId,
                                                                lang: _editedListing.lang,
                                                                showAll: 1,
                                                                title: _editedListing.title,
                                                                sef: _editedListing.sef,
                                                                summary: _editedListing.summary,
                                                                content: _editedListing.content,
                                                                trueFalseArray: _editedListing.trueFalseArray,
                                                                startingTimeArray: _editedListing.startingTimeArray,
                                                                finishingTimearray: _editedListing.finishingTimearray,
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(20.0),
                                                        child: ConstrainedBox(
                                                          constraints: BoxConstraints.tight(const Size(400, 50)),
                                                          child: TextFormField(
                                                            validator: (value) {
                                                              if (value!.isEmpty) {
                                                                return 'Please provide a value.';
                                                              }
                                                              return null;
                                                            },
                                                            initialValue: _initValues['phone'].toString(),
                                                            inputFormatters: <TextInputFormatter>[
                                                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                                            ],
                                                            decoration: InputDecoration(labelText: 'Phone'),
                                                            // readOnly: listingId != 0 ? true : false,
                                                            onSaved: (value) {
                                                              _editedListing = ListingsItem(
                                                                locationID: _editedListing.locationID,
                                                                categoryIDs: _editedListing.categoryIDs,
                                                                display: _editedListing.display,
                                                                viewCount: _editedListing.viewCount,
                                                                isPaid: _editedListing.isPaid,
                                                                contactID: _editedListing.contactID,
                                                                moduleID: _editedListing.moduleID,
                                                                coordinate: _editedListing.coordinate,
                                                                address: _editedListing.address,
                                                                phone: value,
                                                                website: _editedListing.website,
                                                                email: _editedListing.email,
                                                                facebook: _editedListing.facebook,
                                                                instagram: _editedListing.instagram,
                                                                youtube: _editedListing.youtube,
                                                                pinterest: _editedListing.pinterest,
                                                                twitter: _editedListing.twitter,
                                                                whatsapp: _editedListing.whatsapp,
                                                                contentID: 2,
                                                                categoryID: categoryId,
                                                                lang: _editedListing.lang,
                                                                showAll: 1,
                                                                title: _editedListing.title,
                                                                sef: _editedListing.sef,
                                                                summary: _editedListing.summary,
                                                                content: _editedListing.content,
                                                                trueFalseArray: _editedListing.trueFalseArray,
                                                                startingTimeArray: _editedListing.startingTimeArray,
                                                                finishingTimearray: _editedListing.finishingTimearray,
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      )
                                                    ]),
                                                    Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: <Widget>[
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: ConstrainedBox(
                                                          constraints: BoxConstraints.tight(const Size(400, 50)),
                                                          child: TextFormField(
                                                            validator: (value) {
                                                              if (value!.isEmpty) {
                                                                return 'Please provide a value.';
                                                              }
                                                              return null;
                                                            },
                                                            //     readOnly: listingId != 0 ? true : false,
                                                            initialValue: _initValues['website'].toString(),
                                                            decoration: InputDecoration(labelText: 'Website'),
                                                            onSaved: (value) {
                                                              _editedListing = ListingsItem(
                                                                  locationID: _editedListing.locationID,
                                                                  categoryIDs: _editedListing.categoryIDs,
                                                                  display: _editedListing.display,
                                                                  viewCount: _editedListing.viewCount,
                                                                  isPaid: _editedListing.isPaid,
                                                                  contactID: _editedListing.contactID,
                                                                  moduleID: _editedListing.moduleID,
                                                                  coordinate: _editedListing.coordinate,
                                                                  address: _editedListing.address,
                                                                  phone: _editedListing.phone,
                                                                  website: value,
                                                                  email: _editedListing.email,
                                                                  facebook: _editedListing.facebook,
                                                                  instagram: _editedListing.instagram,
                                                                  youtube: _editedListing.youtube,
                                                                  pinterest: _editedListing.pinterest,
                                                                  twitter: _editedListing.twitter,
                                                                  whatsapp: _editedListing.whatsapp,
                                                                  contentID: 2,
                                                                  categoryID: categoryId,
                                                                  lang: _editedListing.lang,
                                                                  showAll: 1,
                                                                  title: _editedListing.title,
                                                                  sef: _editedListing.sef,
                                                                  summary: _editedListing.summary,
                                                                  content: _editedListing.content,
                                                                  trueFalseArray: _editedListing.trueFalseArray,
                                                                  startingTimeArray: _editedListing.startingTimeArray,
                                                                  finishingTimearray: _editedListing.finishingTimearray);
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(20.0),
                                                        child: ConstrainedBox(
                                                          constraints: BoxConstraints.tight(const Size(400, 50)),
                                                          child: TextFormField(
                                                            validator: (value) {
                                                              if (value!.isEmpty) {
                                                                return 'Please provide a value.';
                                                              }
                                                              return null;
                                                            },
                                                            initialValue: _initValues['email'].toString(),
                                                            decoration: InputDecoration(labelText: 'Email'),
                                                            //  readOnly: listingId != 0 ? true : false,
                                                            onSaved: (value) {
                                                              _editedListing = ListingsItem(
                                                                  locationID: _editedListing.locationID,
                                                                  categoryIDs: _editedListing.categoryIDs,
                                                                  display: _editedListing.display,
                                                                  viewCount: _editedListing.viewCount,
                                                                  isPaid: _editedListing.isPaid,
                                                                  contactID: _editedListing.contactID,
                                                                  moduleID: _editedListing.moduleID,
                                                                  coordinate: _editedListing.coordinate,
                                                                  address: _editedListing.address,
                                                                  phone: _editedListing.phone,
                                                                  website: _editedListing.website,
                                                                  email: value,
                                                                  facebook: _editedListing.facebook,
                                                                  instagram: _editedListing.instagram,
                                                                  youtube: _editedListing.youtube,
                                                                  pinterest: _editedListing.pinterest,
                                                                  twitter: _editedListing.twitter,
                                                                  whatsapp: _editedListing.whatsapp,
                                                                  contentID: 2,
                                                                  categoryID: categoryId,
                                                                  lang: _editedListing.lang,
                                                                  showAll: 1,
                                                                  title: _editedListing.title,
                                                                  sef: _editedListing.sef,
                                                                  summary: _editedListing.summary,
                                                                  content: _editedListing.content,
                                                                  trueFalseArray: _editedListing.trueFalseArray,
                                                                  startingTimeArray: _editedListing.startingTimeArray,
                                                                  finishingTimearray: _editedListing.finishingTimearray);
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(20.0),
                                                        child: ConstrainedBox(
                                                          constraints: BoxConstraints.tight(const Size(400, 50)),
                                                          child: TextFormField(
                                                            validator: (value) {
                                                              if (value!.isEmpty) {
                                                                return 'Please provide a value.';
                                                              }
                                                              return null;
                                                            },
                                                            initialValue: _initValues['facebook'].toString(),
                                                            decoration: InputDecoration(labelText: 'Facebook'),
                                                            //    readOnly: listingId != 0 ? true : false,
                                                            onSaved: (value) {
                                                              _editedListing = ListingsItem(
                                                                  locationID: _editedListing.locationID,
                                                                  categoryIDs: _editedListing.categoryIDs,
                                                                  display: _editedListing.display,
                                                                  viewCount: _editedListing.viewCount,
                                                                  isPaid: _editedListing.isPaid,
                                                                  contactID: _editedListing.contactID,
                                                                  moduleID: _editedListing.moduleID,
                                                                  coordinate: _editedListing.coordinate,
                                                                  address: _editedListing.address,
                                                                  phone: _editedListing.phone,
                                                                  website: _editedListing.website,
                                                                  email: _editedListing.email,
                                                                  facebook: value,
                                                                  instagram: _editedListing.instagram,
                                                                  youtube: _editedListing.youtube,
                                                                  pinterest: _editedListing.pinterest,
                                                                  twitter: _editedListing.twitter,
                                                                  whatsapp: _editedListing.whatsapp,
                                                                  contentID: 2,
                                                                  categoryID: categoryId,
                                                                  lang: _editedListing.lang,
                                                                  showAll: 1,
                                                                  title: _editedListing.title,
                                                                  sef: _editedListing.sef,
                                                                  summary: _editedListing.summary,
                                                                  content: _editedListing.content,
                                                                  trueFalseArray: _editedListing.trueFalseArray,
                                                                  startingTimeArray: _editedListing.startingTimeArray,
                                                                  finishingTimearray: _editedListing.finishingTimearray);
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(20.0),
                                                        child: ConstrainedBox(
                                                          constraints: BoxConstraints.tight(const Size(400, 50)),
                                                          child: TextFormField(
                                                            validator: (value) {
                                                              if (value!.isEmpty) {
                                                                return 'Please provide a value.';
                                                              }
                                                              return null;
                                                            },
                                                            initialValue: _initValues['instagram'].toString(),
                                                            decoration: InputDecoration(labelText: 'Instagram'),
                                                            //        readOnly: listingId != 0 ? true : false,
                                                            onSaved: (value) {
                                                              _editedListing = ListingsItem(
                                                                  locationID: _editedListing.locationID,
                                                                  categoryIDs: _editedListing.categoryIDs,
                                                                  display: _editedListing.display,
                                                                  viewCount: _editedListing.viewCount,
                                                                  isPaid: _editedListing.isPaid,
                                                                  contactID: _editedListing.contactID,
                                                                  moduleID: _editedListing.moduleID,
                                                                  coordinate: _editedListing.coordinate,
                                                                  address: _editedListing.address,
                                                                  phone: _editedListing.phone,
                                                                  website: _editedListing.website,
                                                                  email: _editedListing.email,
                                                                  facebook: _editedListing.facebook,
                                                                  instagram: value,
                                                                  youtube: _editedListing.youtube,
                                                                  pinterest: _editedListing.pinterest,
                                                                  twitter: _editedListing.twitter,
                                                                  whatsapp: _editedListing.whatsapp,
                                                                  contentID: 2,
                                                                  categoryID: categoryId,
                                                                  lang: _editedListing.lang,
                                                                  showAll: 1,
                                                                  title: _editedListing.title,
                                                                  sef: _editedListing.sef,
                                                                  summary: _editedListing.summary,
                                                                  content: _editedListing.content,
                                                                  trueFalseArray: _editedListing.trueFalseArray,
                                                                  startingTimeArray: _editedListing.startingTimeArray,
                                                                  finishingTimearray: _editedListing.finishingTimearray);
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(20.0),
                                                        child: ConstrainedBox(
                                                          constraints: BoxConstraints.tight(const Size(400, 50)),
                                                          child: TextFormField(
                                                            validator: (value) {
                                                              if (value!.isEmpty) {
                                                                return 'Please provide a value.';
                                                              }
                                                              return null;
                                                            },
                                                            initialValue: _initValues['youtube'].toString(),
                                                            decoration: InputDecoration(labelText: 'Youtube'),
                                                            //      readOnly: listingId != 0 ? true : false,
                                                            onSaved: (value) {
                                                              _editedListing = ListingsItem(
                                                                  locationID: _editedListing.locationID,
                                                                  categoryIDs: _editedListing.categoryIDs,
                                                                  display: _editedListing.display,
                                                                  viewCount: _editedListing.viewCount,
                                                                  isPaid: _editedListing.isPaid,
                                                                  contactID: _editedListing.contactID,
                                                                  moduleID: _editedListing.moduleID,
                                                                  coordinate: _editedListing.coordinate,
                                                                  address: _editedListing.address,
                                                                  phone: _editedListing.phone,
                                                                  website: _editedListing.website,
                                                                  email: _editedListing.email,
                                                                  facebook: _editedListing.facebook,
                                                                  instagram: _editedListing.instagram,
                                                                  youtube: value,
                                                                  pinterest: _editedListing.pinterest,
                                                                  twitter: _editedListing.twitter,
                                                                  whatsapp: _editedListing.whatsapp,
                                                                  contentID: 2,
                                                                  categoryID: categoryId,
                                                                  lang: _editedListing.lang,
                                                                  showAll: 1,
                                                                  title: _editedListing.title,
                                                                  sef: _editedListing.sef,
                                                                  summary: _editedListing.summary,
                                                                  content: _editedListing.content,
                                                                  trueFalseArray: _editedListing.trueFalseArray,
                                                                  startingTimeArray: _editedListing.startingTimeArray,
                                                                  finishingTimearray: _editedListing.finishingTimearray);
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(20.0),
                                                        child: ConstrainedBox(
                                                          constraints: BoxConstraints.tight(const Size(400, 50)),
                                                          child: TextFormField(
                                                            validator: (value) {
                                                              if (value!.isEmpty) {
                                                                return 'Please provide a value.';
                                                              }
                                                              return null;
                                                            },
                                                            initialValue: _initValues['pinterest'].toString(),
                                                            //   readOnly: listingId != 0 ? true : false,
                                                            decoration: InputDecoration(labelText: 'Pinterest'),
                                                            onSaved: (value) {
                                                              _editedListing = ListingsItem(
                                                                  locationID: _editedListing.locationID,
                                                                  categoryIDs: _editedListing.categoryIDs,
                                                                  display: _editedListing.display,
                                                                  viewCount: _editedListing.viewCount,
                                                                  isPaid: _editedListing.isPaid,
                                                                  contactID: _editedListing.contactID,
                                                                  moduleID: _editedListing.moduleID,
                                                                  coordinate: _editedListing.coordinate,
                                                                  address: _editedListing.address,
                                                                  phone: _editedListing.phone,
                                                                  website: _editedListing.website,
                                                                  email: _editedListing.email,
                                                                  facebook: _editedListing.facebook,
                                                                  instagram: _editedListing.instagram,
                                                                  youtube: _editedListing.youtube,
                                                                  pinterest: value,
                                                                  twitter: _editedListing.twitter,
                                                                  whatsapp: _editedListing.whatsapp,
                                                                  contentID: 2,
                                                                  categoryID: categoryId,
                                                                  lang: _editedListing.lang,
                                                                  showAll: 1,
                                                                  title: _editedListing.title,
                                                                  sef: _editedListing.sef,
                                                                  summary: _editedListing.summary,
                                                                  content: _editedListing.content,
                                                                  trueFalseArray: _editedListing.trueFalseArray,
                                                                  startingTimeArray: _editedListing.startingTimeArray,
                                                                  finishingTimearray: _editedListing.finishingTimearray);
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(20.0),
                                                        child: ConstrainedBox(
                                                          constraints: BoxConstraints.tight(const Size(400, 50)),
                                                          child: TextFormField(
                                                            validator: (value) {
                                                              if (value!.isEmpty) {
                                                                return 'Please provide a value.';
                                                              }
                                                              return null;
                                                            },
                                                            initialValue: _initValues['twitter'].toString(),
                                                            //       readOnly: listingId != 0 ? true : false,
                                                            decoration: InputDecoration(labelText: 'Twitter'),
                                                            onSaved: (value) {
                                                              _editedListing = ListingsItem(
                                                                  locationID: _editedListing.locationID,
                                                                  categoryIDs: _editedListing.categoryIDs,
                                                                  display: _editedListing.display,
                                                                  viewCount: _editedListing.viewCount,
                                                                  isPaid: _editedListing.isPaid,
                                                                  contactID: _editedListing.contactID,
                                                                  moduleID: _editedListing.moduleID,
                                                                  coordinate: _editedListing.coordinate,
                                                                  address: _editedListing.address,
                                                                  phone: _editedListing.phone,
                                                                  website: _editedListing.website,
                                                                  email: _editedListing.email,
                                                                  facebook: _editedListing.facebook,
                                                                  instagram: _editedListing.instagram,
                                                                  youtube: _editedListing.youtube,
                                                                  pinterest: _editedListing.pinterest,
                                                                  twitter: value,
                                                                  whatsapp: _editedListing.whatsapp,
                                                                  contentID: 2,
                                                                  categoryID: categoryId,
                                                                  lang: _editedListing.lang,
                                                                  showAll: 1,
                                                                  title: _editedListing.title,
                                                                  sef: _editedListing.sef,
                                                                  summary: _editedListing.summary,
                                                                  content: _editedListing.content,
                                                                  trueFalseArray: _editedListing.trueFalseArray,
                                                                  startingTimeArray: _editedListing.startingTimeArray,
                                                                  finishingTimearray: _editedListing.finishingTimearray);
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(20.0),
                                                        child: ConstrainedBox(
                                                          constraints: BoxConstraints.tight(const Size(400, 50)),
                                                          child: TextFormField(
                                                            validator: (value) {
                                                              if (value!.isEmpty) {
                                                                return 'Please provide a value.';
                                                              }
                                                              return null;
                                                            },
                                                            initialValue: _initValues['whatsapp'].toString(),
                                                            decoration: InputDecoration(labelText: 'Whatsapp'),
                                                            //       readOnly: listingId != 0 ? true : false,
                                                            onSaved: (value) {
                                                              _editedListing = ListingsItem(
                                                                  locationID: _editedListing.locationID,
                                                                  categoryIDs: _editedListing.categoryIDs,
                                                                  display: _editedListing.display,
                                                                  viewCount: _editedListing.viewCount,
                                                                  isPaid: _editedListing.isPaid,
                                                                  contactID: _editedListing.contactID,
                                                                  moduleID: _editedListing.moduleID,
                                                                  coordinate: _editedListing.coordinate,
                                                                  address: _editedListing.address,
                                                                  phone: _editedListing.phone,
                                                                  website: _editedListing.website,
                                                                  email: _editedListing.email,
                                                                  facebook: _editedListing.facebook,
                                                                  instagram: _editedListing.instagram,
                                                                  youtube: _editedListing.youtube,
                                                                  pinterest: _editedListing.pinterest,
                                                                  twitter: _editedListing.twitter,
                                                                  whatsapp: value,
                                                                  contentID: 2,
                                                                  categoryID: categoryId,
                                                                  lang: _editedListing.lang,
                                                                  showAll: 1,
                                                                  title: _editedListing.title,
                                                                  sef: _editedListing.sef,
                                                                  summary: _editedListing.summary,
                                                                  content: _editedListing.content,
                                                                  trueFalseArray: _editedListing.trueFalseArray,
                                                                  startingTimeArray: _editedListing.startingTimeArray,
                                                                  finishingTimearray: _editedListing.finishingTimearray);
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(20.0),
                                                        child: ConstrainedBox(
                                                          constraints: BoxConstraints.tight(const Size(400, 50)),
                                                          child: TextFormField(
                                                            validator: (value) {
                                                              if (value!.isEmpty) {
                                                                return 'Please provide a value.';
                                                              }
                                                              return null;
                                                            },
                                                            initialValue: _initValues['lang'].toString(),
                                                            decoration: InputDecoration(labelText: 'Language'),
                                                            //      readOnly: listingId != 0 ? true : false,
                                                            onSaved: (value) {
                                                              _editedListing = ListingsItem(
                                                                  locationID: _editedListing.locationID,
                                                                  categoryIDs: _editedListing.categoryIDs,
                                                                  display: _editedListing.display,
                                                                  viewCount: _editedListing.viewCount,
                                                                  isPaid: _editedListing.isPaid,
                                                                  contactID: _editedListing.contactID,
                                                                  moduleID: _editedListing.moduleID,
                                                                  coordinate: _editedListing.coordinate,
                                                                  address: _editedListing.address,
                                                                  phone: _editedListing.phone,
                                                                  website: _editedListing.website,
                                                                  email: _editedListing.email,
                                                                  facebook: _editedListing.facebook,
                                                                  instagram: _editedListing.instagram,
                                                                  youtube: _editedListing.youtube,
                                                                  pinterest: _editedListing.pinterest,
                                                                  twitter: _editedListing.twitter,
                                                                  whatsapp: _editedListing.whatsapp,
                                                                  contentID: 2,
                                                                  categoryID: categoryId,
                                                                  lang: value,
                                                                  showAll: 1,
                                                                  title: _editedListing.title,
                                                                  sef: _editedListing.sef,
                                                                  summary: _editedListing.summary,
                                                                  content: _editedListing.content,
                                                                  trueFalseArray: _editedListing.trueFalseArray,
                                                                  startingTimeArray: _editedListing.startingTimeArray,
                                                                  finishingTimearray: _editedListing.finishingTimearray);
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(20.0),
                                                        child: ConstrainedBox(
                                                          constraints: BoxConstraints.tight(const Size(400, 50)),
                                                          child: TextFormField(
                                                            validator: (value) {
                                                              if (value!.isEmpty) {
                                                                return 'Please provide a value.';
                                                              }
                                                              return null;
                                                            },
                                                            initialValue: _initValues['title'].toString(),
                                                            decoration: InputDecoration(labelText: 'Title'),
                                                            //     readOnly: listingId != 0 ? true : false,
                                                            onSaved: (value) {
                                                              _editedListing = ListingsItem(
                                                                  locationID: _editedListing.locationID,
                                                                  categoryIDs: _editedListing.categoryIDs,
                                                                  display: _editedListing.display,
                                                                  viewCount: _editedListing.viewCount,
                                                                  isPaid: _editedListing.isPaid,
                                                                  contactID: _editedListing.contactID,
                                                                  moduleID: _editedListing.moduleID,
                                                                  coordinate: _editedListing.coordinate,
                                                                  address: _editedListing.address,
                                                                  phone: _editedListing.phone,
                                                                  website: _editedListing.website,
                                                                  email: _editedListing.email,
                                                                  facebook: _editedListing.facebook,
                                                                  instagram: _editedListing.instagram,
                                                                  youtube: _editedListing.youtube,
                                                                  pinterest: _editedListing.pinterest,
                                                                  twitter: _editedListing.twitter,
                                                                  whatsapp: _editedListing.whatsapp,
                                                                  contentID: 2,
                                                                  categoryID: categoryId,
                                                                  lang: _editedListing.lang,
                                                                  showAll: 1,
                                                                  title: value,
                                                                  sef: _editedListing.sef,
                                                                  summary: _editedListing.summary,
                                                                  content: _editedListing.content,
                                                                  trueFalseArray: _editedListing.trueFalseArray,
                                                                  startingTimeArray: _editedListing.startingTimeArray,
                                                                  finishingTimearray: _editedListing.finishingTimearray);
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(20.0),
                                                        child: ConstrainedBox(
                                                          constraints: BoxConstraints.tight(const Size(400, 50)),
                                                          child: TextFormField(
                                                            validator: (value) {
                                                              if (value!.isEmpty) {
                                                                return 'Please provide a value.';
                                                              }
                                                              return null;
                                                            },
                                                            initialValue: _initValues['sef'].toString(),
                                                            decoration: InputDecoration(labelText: 'Sef'),
                                                            //      readOnly: listingId != 0 ? true : false,
                                                            onSaved: (value) {
                                                              _editedListing = ListingsItem(
                                                                  locationID: _editedListing.locationID,
                                                                  categoryIDs: _editedListing.categoryIDs,
                                                                  display: _editedListing.display,
                                                                  viewCount: _editedListing.viewCount,
                                                                  isPaid: _editedListing.isPaid,
                                                                  contactID: _editedListing.contactID,
                                                                  moduleID: _editedListing.moduleID,
                                                                  coordinate: _editedListing.coordinate,
                                                                  address: _editedListing.address,
                                                                  phone: _editedListing.phone,
                                                                  website: _editedListing.website,
                                                                  email: _editedListing.email,
                                                                  facebook: _editedListing.facebook,
                                                                  instagram: _editedListing.instagram,
                                                                  youtube: _editedListing.youtube,
                                                                  pinterest: _editedListing.pinterest,
                                                                  twitter: _editedListing.twitter,
                                                                  whatsapp: _editedListing.whatsapp,
                                                                  contentID: 2,
                                                                  categoryID: categoryId,
                                                                  lang: _editedListing.lang,
                                                                  showAll: 1,
                                                                  title: _editedListing.title,
                                                                  sef: value,
                                                                  summary: _editedListing.summary,
                                                                  content: _editedListing.content,
                                                                  trueFalseArray: _editedListing.trueFalseArray,
                                                                  startingTimeArray: _editedListing.startingTimeArray,
                                                                  finishingTimearray: _editedListing.finishingTimearray);
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 100,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: ConstrainedBox(
                                                            constraints: BoxConstraints.tight(const Size(200, 100)),
                                                            child: InputDecorator(
                                                              decoration: InputDecoration(hintText: 'isPaid', labelText: 'isPaid', border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                                                              child: DropdownButtonHideUnderline(
                                                                  child: DropdownButton<bool>(
                                                                value: _editedListing.isPaid,
                                                                isDense: true,
                                                                icon: const Icon(Icons.arrow_downward),
                                                                elevation: 16,
                                                                style: const TextStyle(color: Colors.deepPurple),
                                                                underline: Container(
                                                                  height: 2,
                                                                  color: Colors.deepPurpleAccent,
                                                                ),
                                                                onChanged: (bool? newValue) {
                                                                  FocusScope.of(context).requestFocus(_isPaidFocusNode);
                                                                  _editedListing = ListingsItem(
                                                                      locationID: _editedListing.locationID,
                                                                      categoryIDs: _editedListing.categoryIDs,
                                                                      display: _editedListing.display,
                                                                      viewCount: _editedListing.viewCount,
                                                                      isPaid: newValue,
                                                                      contactID: _editedListing.contactID,
                                                                      moduleID: _editedListing.moduleID,
                                                                      coordinate: _editedListing.coordinate,
                                                                      address: _editedListing.address,
                                                                      phone: _editedListing.phone,
                                                                      website: _editedListing.website,
                                                                      email: _editedListing.email,
                                                                      facebook: _editedListing.facebook,
                                                                      instagram: _editedListing.instagram,
                                                                      youtube: _editedListing.youtube,
                                                                      pinterest: _editedListing.pinterest,
                                                                      twitter: _editedListing.twitter,
                                                                      whatsapp: _editedListing.whatsapp,
                                                                      contentID: 2,
                                                                      categoryID: categoryId,
                                                                      lang: _editedListing.lang,
                                                                      showAll: 1,
                                                                      title: _editedListing.title,
                                                                      sef: _editedListing.sef,
                                                                      summary: _editedListing.summary,
                                                                      content: _editedListing.content,
                                                                      trueFalseArray: _editedListing.trueFalseArray,
                                                                      startingTimeArray: _editedListing.startingTimeArray,
                                                                      finishingTimearray: _editedListing.finishingTimearray);

                                                                  print(_editedListing.isPaid);
                                                                },
                                                                items: <bool>[true, false].map<DropdownMenuItem<bool>>((bool value) {
                                                                  return DropdownMenuItem<bool>(
                                                                    value: value,
                                                                    child: Text(value.toString()),
                                                                  );
                                                                }).toList(),
                                                              )),
                                                            )),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
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

                                                                  int location = dropdownLocation! + 1;
                                                                  print("////////////////////");
                                                                  print(location);
                                                                  FocusScope.of(context).requestFocus(_locationIDFocusNode);
                                                                  _editedListing = ListingsItem(
                                                                      locationID: location,
                                                                      categoryIDs: _editedListing.categoryIDs,
                                                                      display: _editedListing.display,
                                                                      viewCount: _editedListing.viewCount,
                                                                      isPaid: _editedListing.isPaid,
                                                                      contactID: _editedListing.contactID,
                                                                      moduleID: _editedListing.moduleID,
                                                                      coordinate: _editedListing.coordinate,
                                                                      address: _editedListing.address,
                                                                      phone: _editedListing.phone,
                                                                      website: _editedListing.website,
                                                                      email: _editedListing.email,
                                                                      facebook: _editedListing.facebook,
                                                                      instagram: _editedListing.instagram,
                                                                      youtube: _editedListing.youtube,
                                                                      pinterest: _editedListing.pinterest,
                                                                      twitter: _editedListing.twitter,
                                                                      whatsapp: _editedListing.whatsapp,
                                                                      contentID: 2,
                                                                      categoryID: categoryId,
                                                                      lang: _editedListing.lang,
                                                                      showAll: 1,
                                                                      title: _editedListing.title,
                                                                      sef: _editedListing.sef,
                                                                      summary: _editedListing.summary,
                                                                      content: _editedListing.content,
                                                                      trueFalseArray: _editedListing.trueFalseArray,
                                                                      startingTimeArray: _editedListing.startingTimeArray,
                                                                      finishingTimearray: _editedListing.finishingTimearray);
                                                                });
                                                                print("**************");
                                                                print(_editedListing.locationID);

                                                                print("**************");
                                                              },
                                                              items: getLocations.map((Locations loc) {
                                                                return DropdownMenuItem<String>(
                                                                  value: loc.name,
                                                                  child: Text(loc.name),
                                                                );
                                                              }).toList(),
                                                            )),
                                                          )),
                                                      const SizedBox(
                                                        width: 100,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: ConstrainedBox(
                                                            constraints: BoxConstraints.tight(const Size(200, 100)),
                                                            child: InputDecorator(
                                                              decoration: InputDecoration(hintText: 'display', labelText: 'display', border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                                                              child: DropdownButtonHideUnderline(
                                                                  child: DropdownButton<bool>(
                                                                value: _editedListing.display,
                                                                isDense: true,
                                                                icon: const Icon(Icons.arrow_downward),
                                                                elevation: 16,
                                                                style: const TextStyle(color: Colors.deepPurple),
                                                                underline: Container(
                                                                  height: 2,
                                                                  color: Colors.deepPurpleAccent,
                                                                ),
                                                                onChanged: (bool? newValue) {
                                                                  FocusScope.of(context).requestFocus(_displayFocusNode);
                                                                  _editedListing = ListingsItem(
                                                                      locationID: _editedListing.locationID,
                                                                      categoryIDs: _editedListing.categoryIDs,
                                                                      display: newValue,
                                                                      viewCount: _editedListing.viewCount,
                                                                      isPaid: _editedListing.isPaid,
                                                                      contactID: _editedListing.contactID,
                                                                      moduleID: _editedListing.moduleID,
                                                                      coordinate: _editedListing.coordinate,
                                                                      address: _editedListing.address,
                                                                      phone: _editedListing.phone,
                                                                      website: _editedListing.website,
                                                                      email: _editedListing.email,
                                                                      facebook: _editedListing.facebook,
                                                                      instagram: _editedListing.instagram,
                                                                      youtube: _editedListing.youtube,
                                                                      pinterest: _editedListing.pinterest,
                                                                      twitter: _editedListing.twitter,
                                                                      whatsapp: _editedListing.whatsapp,
                                                                      contentID: 2,
                                                                      categoryID: categoryId,
                                                                      lang: _editedListing.lang,
                                                                      showAll: 1,
                                                                      title: _editedListing.title,
                                                                      sef: _editedListing.sef,
                                                                      summary: _editedListing.summary,
                                                                      content: _editedListing.content,
                                                                      trueFalseArray: _editedListing.trueFalseArray,
                                                                      startingTimeArray: _editedListing.startingTimeArray,
                                                                      finishingTimearray: _editedListing.finishingTimearray);

                                                                  print(_editedListing.display);
                                                                  print("**************");
                                                                  print(_editedListing.locationID);

                                                                  print("**************");
                                                                },
                                                                items: <bool>[true, false].map<DropdownMenuItem<bool>>((bool value) {
                                                                  return DropdownMenuItem<bool>(
                                                                    value: value,
                                                                    child: Text(value.toString()),
                                                                  );
                                                                }).toList(),
                                                              )),
                                                            )),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(20.0),
                                                        child: ConstrainedBox(
                                                          constraints: BoxConstraints.tight(const Size(400, 50)),
                                                          child: TextFormField(
                                                            validator: (value) {
                                                              if (value!.isEmpty) {
                                                                return 'Please provide a value.';
                                                              }
                                                              return null;
                                                            },
                                                            initialValue: _initValues['summary'].toString(),
                                                            //  readOnly: listingId != 0 ? true : false,
                                                            decoration: InputDecoration(labelText: 'Summary'),
                                                            onSaved: (value) {
                                                              _editedListing = ListingsItem(
                                                                  locationID: _editedListing.locationID,
                                                                  categoryIDs: _editedListing.categoryIDs,
                                                                  display: _editedListing.display,
                                                                  viewCount: _editedListing.viewCount,
                                                                  isPaid: _editedListing.isPaid,
                                                                  contactID: _editedListing.contactID,
                                                                  moduleID: _editedListing.moduleID,
                                                                  coordinate: _editedListing.coordinate,
                                                                  address: _editedListing.address,
                                                                  phone: _editedListing.phone,
                                                                  website: _editedListing.website,
                                                                  email: _editedListing.email,
                                                                  facebook: _editedListing.facebook,
                                                                  instagram: _editedListing.instagram,
                                                                  youtube: _editedListing.youtube,
                                                                  pinterest: _editedListing.pinterest,
                                                                  twitter: _editedListing.twitter,
                                                                  whatsapp: _editedListing.whatsapp,
                                                                  contentID: 2,
                                                                  categoryID: categoryId,
                                                                  lang: _editedListing.lang,
                                                                  showAll: 1,
                                                                  title: _editedListing.title,
                                                                  sef: _editedListing.sef,
                                                                  summary: value,
                                                                  content: _editedListing.content,
                                                                  trueFalseArray: _editedListing.trueFalseArray,
                                                                  startingTimeArray: _editedListing.startingTimeArray,
                                                                  finishingTimearray: _editedListing.finishingTimearray);
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      Card(
                                                        elevation: 10,
                                                        child: Wrap(
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.all(20.0),
                                                              child: ConstrainedBox(
                                                                constraints: BoxConstraints.tight(const Size(1000, 50)),
                                                                child: Wrap(direction: Axis.horizontal, children: [
                                                                  TextButton(
                                                                      child: Wrap(children: [
                                                                        Text("HTML Editor Refresh"),
                                                                        Icon(Icons.refresh),
                                                                      ]),
                                                                      onPressed: () {
                                                                        if (kIsWeb) {
                                                                          htmlController.reloadWeb();
                                                                        } else {
                                                                          htmlController.editorController!.reload();
                                                                        }
                                                                      }),
                                                                  TextButton(
                                                                      child: Wrap(children: [
                                                                        Text("Undo"),
                                                                        Icon(Icons.undo),
                                                                      ]),
                                                                      onPressed: () {
                                                                        htmlController.undo();
                                                                      }),
                                                                  TextButton(
                                                                    onPressed: () async {
                                                                      var txt = await htmlController.getText();
                                                                      if (txt.contains('src=\"data:')) {
                                                                        txt = '<text removed due to base-64 data, displaying the text could cause the app to crash>';
                                                                      }
                                                                      setState(() {
                                                                        htmlResult = txt;

                                                                        _editedListing = ListingsItem(
                                                                          locationID: _editedListing.locationID,
                                                                          categoryIDs: _editedListing.categoryIDs,
                                                                          display: _editedListing.display,
                                                                          viewCount: _editedListing.viewCount,
                                                                          isPaid: _editedListing.isPaid,
                                                                          contactID: _editedListing.contactID,
                                                                          moduleID: _editedListing.moduleID,
                                                                          coordinate: _editedListing.coordinate,
                                                                          address: _editedListing.address,
                                                                          phone: _editedListing.phone,
                                                                          website: _editedListing.website,
                                                                          email: _editedListing.email,
                                                                          facebook: _editedListing.facebook,
                                                                          instagram: _editedListing.instagram,
                                                                          youtube: _editedListing.youtube,
                                                                          pinterest: _editedListing.pinterest,
                                                                          twitter: _editedListing.twitter,
                                                                          whatsapp: _editedListing.whatsapp,
                                                                          contentID: 2,
                                                                          categoryID: categoryId,
                                                                          lang: _editedListing.lang,
                                                                          showAll: 1,
                                                                          title: _editedListing.title,
                                                                          sef: _editedListing.sef,
                                                                          summary: _editedListing.summary,
                                                                          content: htmlResult,
                                                                          trueFalseArray: _editedListing.trueFalseArray,
                                                                          startingTimeArray: _editedListing.startingTimeArray,
                                                                          finishingTimearray: _editedListing.finishingTimearray,
                                                                        );
                                                                      });

                                                                      htmlController.disable();
                                                                    },
                                                                    child: Wrap(children: [
                                                                      Text("Save HTML"),
                                                                      Icon(Icons.save),
                                                                    ]),
                                                                  ),
                                                                  TextButton(
                                                                    onPressed: () async {
                                                                      htmlController.enable();
                                                                    },
                                                                    child: Wrap(children: [
                                                                      Text("Continue Editing"),
                                                                      Icon(Icons.edit),
                                                                    ]),
                                                                  ),
                                                                ]),
                                                              ),
                                                            ),
                                                            Padding(
                                                                padding: const EdgeInsets.all(20.0),
                                                                child: ConstrainedBox(
                                                                  constraints: BoxConstraints.tight(const Size(1000, 1000)),
                                                                  child: HtmlEditor(
                                                                    controller: htmlController,
                                                                    htmlEditorOptions: HtmlEditorOptions(
                                                                      hint: 'Your content here...',
                                                                      shouldEnsureVisible: true,
                                                                      //initialText: "<p>text content initial, if any</p>",
                                                                    ),
                                                                    htmlToolbarOptions: HtmlToolbarOptions(
                                                                      toolbarPosition: ToolbarPosition.aboveEditor, //by default
                                                                      toolbarType: ToolbarType.nativeScrollable, //by default

                                                                      onButtonPressed: (ButtonType type, bool? status, Function? updateStatus) {
                                                                        print("button '${describeEnum(type)}' pressed, the current selected status is $status");
                                                                        return true;
                                                                      },

                                                                      onDropdownChanged: (DropdownType type, dynamic changed, Function(dynamic)? updateSelectedItem) {
                                                                        print("dropdown '${describeEnum(type)}' changed to $changed");
                                                                        return true;
                                                                      },

                                                                      mediaLinkInsertInterceptor: (String url, InsertFileType type) {
                                                                        print(url);
                                                                        return true;
                                                                      },

                                                                      mediaUploadInterceptor: (PlatformFile file, InsertFileType type) async {
                                                                        print(file.name); //filename
                                                                        print(file.size); //size in bytes
                                                                        print(file.extension); //file extension (eg jpeg or mp4)
                                                                        return true;
                                                                      },
                                                                    ),
                                                                    otherOptions: OtherOptions(height: 550),
                                                                    plugins: [
                                                                      SummernoteAtMention(
                                                                          getSuggestionsMobile: (String value) {
                                                                            var mentions = <String>['test1', 'test2', 'test3'];
                                                                            return mentions.where((element) => element.contains(value)).toList();
                                                                          },
                                                                          mentionsWeb: ['test1', 'test2', 'test3'],
                                                                          onSelect: (String value) {
                                                                            print(value);
                                                                          }),
                                                                    ],
                                                                  ),
                                                                )),
                                                          ],
                                                        ),
                                                      ),
                                                      /*Padding(
                                                        padding: const EdgeInsets.all(20.0),
                                                        child: ConstrainedBox(
                                                          constraints: BoxConstraints.tight(const Size(1000, 100)),
                                                          child: TextFormField(
                                                            minLines: 3,
                                                            maxLines: 5,
                                                            validator: (value) {
                                                              if (value!.isEmpty) {
                                                                return 'Please provide a value.';
                                                              }
                                                              return null;
                                                            },
                                                            initialValue: _initValues['content'].toString(),
                                                            decoration: InputDecoration(labelText: 'Content'),
                                                            //     readOnly: listingId != 0 ? true : false,
                                                            onSaved: (value) {
                                                              _editedListing = ListingsItem(
                                                                  locationID: _editedListing.locationID,
                                                                  categoryIDs: _editedListing.categoryIDs,
                                                                  display: _editedListing.display,
                                                                  viewCount: _editedListing.viewCount,
                                                                  isPaid: _editedListing.isPaid,
                                                                  contactID: _editedListing.contactID,
                                                                  moduleID: _editedListing.moduleID,
                                                                  coordinate: _editedListing.coordinate,
                                                                  address: _editedListing.address,
                                                                  phone: _editedListing.phone,
                                                                  website: _editedListing.website,
                                                                  email: _editedListing.email,
                                                                  facebook: _editedListing.facebook,
                                                                  instagram: _editedListing.instagram,
                                                                  youtube: _editedListing.youtube,
                                                                  pinterest: _editedListing.pinterest,
                                                                  twitter: _editedListing.twitter,
                                                                  whatsapp: _editedListing.whatsapp,
                                                                  contentID: 2,
                                                                  categoryID: categoryId,
                                                                  lang: _editedListing.lang,
                                                                  showAll: 1,
                                                                  title: _editedListing.title,
                                                                  sef: _editedListing.sef,
                                                                  summary: _editedListing.summary,
                                                                  content: value,
                                                                  trueFalseArray: _editedListing.trueFalseArray,
                                                                  startingTimeArray: _editedListing.startingTimeArray,
                                                                  finishingTimearray: _editedListing.finishingTimearray);
                                                            },
                                                          ),
                                                        ),
                                                      ),*/
                                                      Wrap(children: [
                                                        Padding(
                                                          padding: EdgeInsets.all(8.0),
                                                          child: FormField<List<bool>>(
                                                            initialValue: List.filled(widget.count, false),
                                                            onSaved: widget.onSaved,
                                                            builder: (FormFieldState field) {
                                                              return SizedBox(
                                                                height: 500,
                                                                width: 200,
                                                                child: Column(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  mainAxisSize: MainAxisSize.min,
                                                                  children: List.generate(
                                                                    widget.count,
                                                                    (int index) {
                                                                      return Wrap(children: [
                                                                        CheckboxListTile(
                                                                          title: Text(
                                                                            "Is ${days[index]} open?",
                                                                            textScaleFactor: 0.75,
                                                                          ),
                                                                          controlAffinity: ListTileControlAffinity.leading,
                                                                          onChanged: (bool? value) {
                                                                            field.value[index] = value;
                                                                            field.didChange(field.value);

                                                                            List<bool> timeofbools = [];
                                                                            for (int i = 0; i <= 6; i++) {
                                                                              timeofbools.add(field.value[i]);
                                                                            }
                                                                            print("JSON ARRAY FOR bool");
                                                                            print(timeofbools);

                                                                            //  print(field.value);

                                                                            _editedListing = ListingsItem(
                                                                              locationID: _editedListing.locationID,
                                                                              categoryIDs: _editedListing.categoryIDs,
                                                                              display: _editedListing.display,
                                                                              viewCount: _editedListing.viewCount,
                                                                              isPaid: _editedListing.isPaid,
                                                                              contactID: _editedListing.contactID,
                                                                              moduleID: _editedListing.moduleID,
                                                                              coordinate: _editedListing.coordinate,
                                                                              address: _editedListing.address,
                                                                              phone: _editedListing.phone,
                                                                              website: _editedListing.website,
                                                                              email: _editedListing.email,
                                                                              facebook: _editedListing.facebook,
                                                                              instagram: _editedListing.instagram,
                                                                              youtube: _editedListing.youtube,
                                                                              pinterest: _editedListing.pinterest,
                                                                              twitter: _editedListing.twitter,
                                                                              whatsapp: _editedListing.whatsapp,
                                                                              contentID: 2,
                                                                              categoryID: categoryId,
                                                                              lang: _editedListing.lang,
                                                                              showAll: 1,
                                                                              title: _editedListing.title,
                                                                              sef: _editedListing.sef,
                                                                              summary: _editedListing.summary,
                                                                              content: _editedListing.content,
                                                                              trueFalseArray: timeofbools,
                                                                              startingTimeArray: _editedListing.startingTimeArray,
                                                                              finishingTimearray: _editedListing.finishingTimearray,
                                                                            );
                                                                          },
                                                                          value: field.value[index],

                                                                          /* secondary: field.value[index]
                                                                                          ? Wrap(
                                                                                              //WorkTime List
                                                                                              children: [
                                                                                                ElevatedButton(
                                                                                                  onPressed: () {
                                                                                                    _selectStartingTime(context);
                                                                                                  },
                                                                                                  child: Text("${days[index]} Start Time"),
                                                                                                ),
                                                                                                ElevatedButton(
                                                                                                  onPressed: () async {
                                                                                                    final TimeOfDay? selectedTime = await showTimePicker(
                                                                                                        context: context,
                                                                                                        // initialDate: _editedNews.publishDate!,
                                                                                                        initialTime: FinishingTime!);
                                                                                                    var tempTime = FinishingTime;
                                                          
                                                                                                    print(selectedTime);
                                                                                                    if (selectedTime != null) {
                                                                                                      setState(() {
                                                                                                        FinishingTime = selectedTime;
                                                                                                      });
                                                                                                    } else {
                                                                                                      setState(() {
                                                                                                        FinishingTime = tempTime!;
                                                                                                      });
                                                                                                    }
                                                                                                  },
                                                                                                  child: Text("${days[index]} Close Time"),
                                                                                                ),
                                                                                              ],
                                                                                            )
                                                                                          : Text("NO TİME REQUERED")
                                                                                           */
                                                                        ),
                                                                      ]);
                                                                    },
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                        FormField<List<TimeOfDay>>(
                                                          initialValue: List.filled(widget.count, StartingTime!),
                                                          onSaved: widget.onSavedStart,
                                                          builder: (FormFieldState field) {
                                                            return SizedBox(
                                                              height: 500,
                                                              width: 400,
                                                              child: Column(
                                                                mainAxisSize: MainAxisSize.min,
                                                                children: List.generate(
                                                                  widget.count,
                                                                  (int index) {
                                                                    return Padding(
                                                                      padding: EdgeInsets.all(10),
                                                                      child: ElevatedButton(
                                                                        onPressed: () async {
                                                                          field.value[index] = await showTimePicker(context: context, initialTime: StartingTime!);

                                                                          field.didChange(field.value);

                                                                          print(field.value);

                                                                          List<String> timeofdays = [];
                                                                          for (int i = 0; i <= 6; i++) {
                                                                            timeofdays.add('${field.value[i].hour}:' + '${field.value[i].minute}');
                                                                          }
                                                                          print("JSON ARRAY FOR STARTİME");
                                                                          print(timeofdays);

                                                                          _editedListing = ListingsItem(
                                                                            locationID: _editedListing.locationID,
                                                                            categoryIDs: _editedListing.categoryIDs,
                                                                            display: _editedListing.display,
                                                                            viewCount: _editedListing.viewCount,
                                                                            isPaid: _editedListing.isPaid,
                                                                            contactID: _editedListing.contactID,
                                                                            moduleID: _editedListing.moduleID,
                                                                            coordinate: _editedListing.coordinate,
                                                                            address: _editedListing.address,
                                                                            phone: _editedListing.phone,
                                                                            website: _editedListing.website,
                                                                            email: _editedListing.email,
                                                                            facebook: _editedListing.facebook,
                                                                            instagram: _editedListing.instagram,
                                                                            youtube: _editedListing.youtube,
                                                                            pinterest: _editedListing.pinterest,
                                                                            twitter: _editedListing.twitter,
                                                                            whatsapp: _editedListing.whatsapp,
                                                                            contentID: 2,
                                                                            categoryID: categoryId,
                                                                            lang: _editedListing.lang,
                                                                            showAll: 1,
                                                                            title: _editedListing.title,
                                                                            sef: _editedListing.sef,
                                                                            summary: _editedListing.summary,
                                                                            content: _editedListing.content,
                                                                            trueFalseArray: _editedListing.trueFalseArray,
                                                                            startingTimeArray: timeofdays,
                                                                            finishingTimearray: _editedListing.finishingTimearray,
                                                                          );
                                                                        },
                                                                        child: Text("${days[index]} Start Time is ${field.value[index].hour}:${field.value[index].minute}"),
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                        FormField<List<TimeOfDay>>(
                                                          initialValue: List.filled(widget.count, FinishingTime!),
                                                          onSaved: widget.onSavedClose,
                                                          builder: (FormFieldState field) {
                                                            return SizedBox(
                                                              height: 500,
                                                              width: 400,
                                                              child: Column(
                                                                mainAxisSize: MainAxisSize.min,
                                                                children: List.generate(
                                                                  widget.count,
                                                                  (int index) {
                                                                    return Padding(
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: ElevatedButton(
                                                                        onPressed: () async {
                                                                          field.value[index] = await showTimePicker(context: context, initialTime: FinishingTime!);

                                                                          field.didChange(field.value);

                                                                          List<String> timeofdays = [];
                                                                          for (int i = 0; i <= 6; i++) {
                                                                            timeofdays.add('${field.value[i].hour}:' + '${field.value[i].minute}');
                                                                          }
                                                                          print("JSON ARRAY FOR FİNİSHTİME");
                                                                          print(timeofdays);

                                                                          _editedListing = ListingsItem(
                                                                            locationID: _editedListing.locationID,
                                                                            categoryIDs: _editedListing.categoryIDs,
                                                                            display: _editedListing.display,
                                                                            viewCount: _editedListing.viewCount,
                                                                            isPaid: _editedListing.isPaid,
                                                                            contactID: _editedListing.contactID,
                                                                            moduleID: _editedListing.moduleID,
                                                                            coordinate: _editedListing.coordinate,
                                                                            address: _editedListing.address,
                                                                            phone: _editedListing.phone,
                                                                            website: _editedListing.website,
                                                                            email: _editedListing.email,
                                                                            facebook: _editedListing.facebook,
                                                                            instagram: _editedListing.instagram,
                                                                            youtube: _editedListing.youtube,
                                                                            pinterest: _editedListing.pinterest,
                                                                            twitter: _editedListing.twitter,
                                                                            whatsapp: _editedListing.whatsapp,
                                                                            contentID: 2,
                                                                            categoryID: categoryId,
                                                                            lang: _editedListing.lang,
                                                                            showAll: 1,
                                                                            title: _editedListing.title,
                                                                            sef: _editedListing.sef,
                                                                            summary: _editedListing.summary,
                                                                            content: _editedListing.content,
                                                                            trueFalseArray: _editedListing.trueFalseArray,
                                                                            startingTimeArray: _editedListing.startingTimeArray,
                                                                            finishingTimearray: timeofdays,
                                                                          );

                                                                          print((field.value[index].hour.toString().contains("99")));
                                                                          print(field.value[index].hour.toString());
                                                                          print(field.value);
                                                                        },
                                                                        child: Text(" ${days[index]} Close Time is  ${field.value[index].hour} : ${field.value[index].minute}"),
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ]),
                                                      Wrap(
                                                        children: [
                                                          if (selectedfilesasUint8 != null && selectedfilesasUint8!.length != 0)
                                                            for (var i = 0; i < selectedfiles!.length; i++)
                                                              Card(
                                                                  elevation: 8,
                                                                  child: Column(
                                                                    children: [
                                                                      Image.memory(
                                                                        selectedfilesasUint8![i],
                                                                        width: 100,
                                                                        height: 100,
                                                                      ),
                                                                      ConstrainedBox(
                                                                          constraints: BoxConstraints.tight(const Size(200, 50)),
                                                                          child: InputDecorator(
                                                                            decoration: InputDecoration(hintText: 'lang', labelText: 'lang', border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                                                                            child: DropdownButtonHideUnderline(
                                                                                child: DropdownButton<String>(
                                                                              value: imglang[i],
                                                                              isDense: true,
                                                                              icon: const Icon(Icons.arrow_downward),
                                                                              elevation: 16,
                                                                              style: const TextStyle(color: Colors.deepPurple),
                                                                              underline: Container(
                                                                                height: 2,
                                                                                color: Colors.deepPurpleAccent,
                                                                              ),
                                                                              onChanged: (String? newValue) {
                                                                                FocusScope.of(context).requestFocus(_imagelangFocusNode);
                                                                                imglang[i] = newValue!;
                                                                              },
                                                                              items: <String>["ml", "tr", "en", "de", "py"].map<DropdownMenuItem<String>>((String value) {
                                                                                return DropdownMenuItem<String>(
                                                                                  value: value,
                                                                                  child: Text(value.toString()),
                                                                                );
                                                                              }).toList(),
                                                                            )),
                                                                          )),
                                                                      SizedBox(
                                                                        height: 10,
                                                                      ),
                                                                      ConstrainedBox(
                                                                          constraints: BoxConstraints.tight(const Size(200, 50)),
                                                                          child: InputDecorator(
                                                                            decoration: InputDecoration(hintText: 'sortOrder', labelText: 'sortOrder', border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                                                                            child: DropdownButtonHideUnderline(
                                                                                child: DropdownButton<bool>(
                                                                              value: imgSortOrder[i],
                                                                              isDense: true,
                                                                              icon: const Icon(Icons.arrow_downward),
                                                                              elevation: 16,
                                                                              style: const TextStyle(color: Colors.deepPurple),
                                                                              underline: Container(
                                                                                height: 2,
                                                                                color: Colors.deepPurpleAccent,
                                                                              ),
                                                                              onChanged: (bool? newValue) {
                                                                                FocusScope.of(context).requestFocus(_imagesortOrderFocusNode);
                                                                                imgSortOrder[i] = newValue!;
                                                                              },
                                                                              items: <bool>[true, false].map<DropdownMenuItem<bool>>((bool value) {
                                                                                return DropdownMenuItem<bool>(
                                                                                  value: value,
                                                                                  child: Text(value.toString()),
                                                                                );
                                                                              }).toList(),
                                                                            )),
                                                                          )),
                                                                      SizedBox(
                                                                        height: 10,
                                                                      ),
                                                                      ConstrainedBox(
                                                                          constraints: BoxConstraints.tight(const Size(200, 50)),
                                                                          child: InputDecorator(
                                                                            decoration: InputDecoration(hintText: 'mainImage', labelText: 'mainImage', border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                                                                            child: DropdownButtonHideUnderline(
                                                                                child: DropdownButton<bool>(
                                                                              value: imgMainImage[i],
                                                                              isDense: true,
                                                                              icon: const Icon(Icons.arrow_downward),
                                                                              elevation: 16,
                                                                              style: const TextStyle(color: Colors.deepPurple),
                                                                              underline: Container(
                                                                                height: 2,
                                                                                color: Colors.deepPurpleAccent,
                                                                              ),
                                                                              onChanged: (bool? newValue) {
                                                                                FocusScope.of(context).requestFocus(_imageMainImageFocusNode);
                                                                                imgMainImage[i] = newValue!;
                                                                              },
                                                                              items: <bool>[true, false].map<DropdownMenuItem<bool>>((bool value) {
                                                                                return DropdownMenuItem<bool>(
                                                                                  value: value,
                                                                                  child: Text(value.toString()),
                                                                                );
                                                                              }).toList(),
                                                                            )),
                                                                          )),
                                                                    ],
                                                                  )),
                                                          Card(
                                                              elevation: 8,
                                                              child: Column(
                                                                children: [
                                                                  ElevatedButton.icon(
                                                                      onPressed: () {
                                                                        startFilePicker();
                                                                      },
                                                                      icon: const Icon(Icons.add),
                                                                      label: Text("Add Image")),
                                                                ],
                                                              ))
                                                        ],
                                                      ),
                                                    ]),
                                                  ]),
                                                ],
                                              ),
                                            )),
                                      )
                                    ]),
                                  ),
                                ),
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
