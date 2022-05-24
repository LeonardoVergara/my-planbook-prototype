import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:my_planbook/providers/json_provider.dart';
import 'package:my_planbook/providers/theme_provider.dart';
import './event_preview.dart';
import 'package:page_transition/page_transition.dart';
import 'package:google_fonts/google_fonts.dart';

class Search extends StatefulWidget {
  final dynamic consumer;
  const Search(this.consumer, {Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState(consumer);
}

class _SearchState extends State<Search> {
  late String dropDownValue1;
  late String dropDownValue2;
  late TextEditingController textController;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  dynamic consumer;
  List<dynamic> events = [];
  List<dynamic> eventsFilt = [];

  void filterEvents(String f) {
    // print('*****************************************************');
    // print(f);
    setState(() {
      eventsFilt = events.where((e) {
        // print(e['title']);
        // print('*****************************************************');
        
        return e["title"].toString().toLowerCase().trim().contains(f.toLowerCase());
      }).toList();
    });
  }

  _SearchState(this.consumer) {
    JsonProvider.loadData(JsonProvider.EVENT, (data) {
      events = data as List<dynamic>;
      setState(() {
        eventsFilt = [...events];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFF874C9E),
        automaticallyImplyLeading: false,
        title: Text(
          'Búsqueda de Eventos',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 2,
      ),
      backgroundColor: Color.fromRGBO(241, 244, 248, 1),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 10, 0),
                                  child: TextFormField(
                                    controller: textController,
                                    onChanged: (_) {
                                      filterEvents(_);
                                      return EasyDebounce.debounce(
                                        'textController',
                                        Duration(milliseconds: 2000),
                                        () => setState(() {
                                          //print("ajsjhs");
                                        }),
                                      );
                                    },
                                    autofocus: true,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText: 'Introduzca su búsqueda',
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              20, 0, 20, 0),
                                      suffixIcon: textController.text.isNotEmpty
                                          ? InkWell(
                                              onTap: () => setState(
                                                () => textController.clear(),
                                                // () {},
                                              ),
                                              child: Icon(
                                                Icons.clear,
                                                color: Color(0xFF757575),
                                                size: 22,
                                              ),
                                            )
                                          : null,
                                    ),
                                    style: TextStyle(),
                                  ),
                                ),
                              ),
                              IconButton(
                                splashColor: Colors.transparent,
                                splashRadius: 30,
                                //borderWidth: 1,//aqui hay una vaina rara con los iconos revisar*********************************************************************************
                                iconSize: 40,
                                //fillColor: Color(0xFF874C9E),
                                icon: Icon(
                                  Icons.search,
                                  color: Color(0xFFEFEFEF),
                                  size: 20,
                                ),
                                onPressed: () {
                                  print('IconButton pressed ...');
                                },
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 10, 0),
                                    child: Text(
                                      'Lugar:',
                                      style: TextStyle(),
                                    ),
                                  ),
                                  // FlutterFlowDropDown(
                                  //   options: ['Option 1'].toList(),
                                  //   onChanged: (val) =>
                                  //       setState(() => dropDownValue1 = val),
                                  //   width: 110,
                                  //   height: 50,
                                  //   textStyle: TextStyle(
                                  //     fontFamily: 'Poppins',
                                  //     color: Colors.black,
                                  //   ),
                                  //   hintText: 'Please select...',
                                  //   fillColor: Colors.white,
                                  //   elevation: 2,
                                  //   borderColor: Colors.transparent,
                                  //   borderWidth: 0,
                                  //   borderRadius: 0,
                                  //   margin: EdgeInsetsDirectional.fromSTEB(
                                  //       12, 4, 12, 4),
                                  //   hidesUnderline: true,
                                  // ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 10, 0),
                                    child: Text(
                                      'Fecha:',
                                      style: TextStyle(),
                                    ),
                                  ),
                                  // FlutterFlowDropDown(
                                  //   options: ['Option 1'].toList(),
                                  //   onChanged: (val) =>
                                  //       setState(() => dropDownValue2 = val),
                                  //   width: 110,
                                  //   height: 50,
                                  //   textStyle: TextStyle(
                                  //     fontFamily: 'Poppins',
                                  //     color: Colors.black,
                                  //   ),
                                  //   hintText: 'Please select...',
                                  //   fillColor: Colors.white,
                                  //   elevation: 2,
                                  //   borderColor: Colors.transparent,
                                  //   borderWidth: 0,
                                  //   borderRadius: 0,
                                  //   margin: EdgeInsetsDirectional.fromSTEB(
                                  //       12, 4, 12, 4),
                                  //   hidesUnderline: true,
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 10, 0),
                                    child: Text(
                                      'Precio Min.:',
                                      style: TextStyle(),
                                    ),
                                  ),
                                  Text(
                                    '\$100.000',
                                    style: TextStyle(),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 10, 0),
                                    child: Text(
                                      'Precio Máx.:',
                                      style: TextStyle(),
                                    ),
                                  ),
                                  Text(
                                    '\$100.000',
                                    style: TextStyle(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      children: [...eventsFilt.map((e) => Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                          child: InkWell(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  duration: Duration(milliseconds: 500),
                                  reverseDuration: Duration(milliseconds: 500),
                                  child: EventPreview(),
                                ),
                              );
                            },
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Image.network(
                                      'https://picsum.photos/seed/799/600',
                                      width: 140,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(e['title'], style: GoogleFonts.poppins(color: AppColors.grey)),
                                        Text(
                                          e['details']['date'],
                                          style: GoogleFonts.poppins(color: AppColors.grey)
                                        ),
                                        Text(
                                          e['details']['location']['place'],
                                          style: GoogleFonts.poppins(color: AppColors.grey)
                                        ),
                                        // Text(
                                        //   (e['details']['options'] as List).where(),
                                        //   style: GoogleFonts.poppins(color: AppColors.grey)
                                        // ),
                                        Text('\$50.000 - \$100.000'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ))
                      ]
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
