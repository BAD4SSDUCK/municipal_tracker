import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:municipal_track/code/Chat/chat_screen.dart';
import 'package:municipal_track/code/ImageUploading/image_upload_page.dart';
import 'package:municipal_track/code/PDFViewer/pdf_api.dart';
import 'package:municipal_track/code/Reusable/main_menu_reusable_button.dart';
import 'package:municipal_track/code/Reusable/nav_drawer.dart';
import 'package:municipal_track/code/SQLApp/faultPages/fault_report_screen.dart';
import 'package:municipal_track/code/SQLApp/fragments/profile_fragment_screen.dart';
import 'package:municipal_track/code/SQLApp/fragments/statement_download.dart';
import 'package:municipal_track/main.dart';
import 'package:http/http.dart' as http;

import 'package:municipal_track/code/DisplayPages/add_details.dart';
import 'package:municipal_track/code/DisplayPages/display_info.dart';
import 'package:municipal_track/code/DisplayPages/display_info_all_users.dart';
import 'package:municipal_track/code/Chat/chat_list.dart';
import 'package:municipal_track/code/MapTools/location_controller.dart';
import 'package:municipal_track/code/MapTools/map_screen.dart';
import 'package:municipal_track/code/PDFViewer/view_pdf.dart';
import 'package:municipal_track/code/Reusable/menu_reusable_elevated_button.dart';
import 'package:municipal_track/code/ApiConnection/api_connection.dart';

import 'package:municipal_track/code/Reusable/icon_elevated_button.dart';
import 'dashboard_of_fragments_sql.dart';


class HomeAdminScreen extends StatefulWidget {
  const HomeAdminScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>_HomeAdminScreenState();
}

class _HomeAdminScreenState extends State<HomeAdminScreen>{

  bool loading = true;
  late List pdfList;

  Future fetchAllPdf() async{
    final response = await http.get(Uri.parse(API.pdfDBList));
    if (response.statusCode==200){
      setState((){
        pdfList = jsonDecode(response.body);
        loading = false;
      });
    }
  }

  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fetchAllPdf();
    fToast =FToast();
    fToast.init(context);
    Fluttertoast.showToast(msg: "Navigate The App From The Bottom Tabs.", gravity: ToastGravity.CENTER);

  }

  bool visShow = true;
  bool visHide = false;

  final CollectionReference _propList =
  FirebaseFirestore.instance.collection('properties');

  final CollectionReference _userList =
  FirebaseFirestore.instance.collection('users');


  @override
  Widget build(BuildContext context) {
    Get.put(LocationController());
    const double fontSize = 28.0;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Container(
      ///When a background image is created this section will display it on the dashboard instead of just a grey colour with no background
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/greyscale.jpg"),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,//Colors.grey,
        ///App bar removed for aesthetic
        appBar: AppBar(
          title:
          Text(''),
          backgroundColor: Colors.black87,
        ),
        drawer: const NavDrawer(),
        body: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    const SizedBox(height: 50),
                    Image.asset('assets/images/logo.png', height: 180, width: 180,),
                    const SizedBox(height: 50),

                    Column(
                      children: [
                        Visibility(
                          visible: visShow,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ElevatedIconButton(
                                  onPress: () async {
                                    Fluttertoast.showToast(msg: "Now downloading your statements!\nPlease wait a few seconds!",
                                      gravity: ToastGravity.CENTER,);

                                    ///SQL pdf list that shows the users statements if it contains their account number
                                    // Navigator.push(context,
                                    //     MaterialPageRoute(builder: (context) => const pdfSelectionPage()));

                                  },
                                  labelText: 'Maps',
                                  fSize: 24,
                                  faIcon: const FaIcon(FontAwesomeIcons.map),
                                  fgColor: Colors.green,
                                  btSize: const Size(300, 80),
                                ),

                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 5,),
                        Visibility(
                          visible: visShow,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ElevatedIconButton(
                                  onPress: () async {
                                    // Fluttertoast.showToast(msg: "Now downloading your statements!\nPlease wait a few seconds!",
                                    //   gravity: ToastGravity.CENTER,);

                                    // Navigator.push(context,
                                    //     MaterialPageRoute(builder: (context) => ReportPropertyMenu()));

                                  },
                                  labelText: 'Report List',
                                  fSize: 24,
                                  faIcon: const FaIcon(Icons.report_problem),
                                  fgColor: Colors.orange,
                                  btSize: const Size(300, 80),
                                ),

                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 5,),
                        Visibility(
                          visible: visShow,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ElevatedIconButton(
                                  onPress: (){
                                    ProfileFragmentScreen().signOutUser();

                                  },
                                  labelText: 'Logout',
                                  fSize: 24,
                                  faIcon: const FaIcon(Icons.logout),
                                  fgColor: Colors.red,
                                  btSize: const Size(300, 80),
                                ),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),


                    const SizedBox(height: 50),
                    const Text('Copyright Cyberfox ',
                      style: TextStyle(
                        color: Colors.white,
                        backgroundColor: Colors.white10,
                        fontStyle: FontStyle.italic,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ///pdf view loader getting file name onPress/onTap that passes filename to this class
  void openPDF(BuildContext context, File file) => Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => PDFViewerPage(file: file)),
  );

}