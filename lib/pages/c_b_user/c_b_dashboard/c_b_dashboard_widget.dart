import 'package:firebase_database/firebase_database.dart';

import '../../../suco.dart';
import '/components/account_profile/account_profile_widget.dart';
import '/components/custom_menu/custom_menu_widget.dart';
import '/components/list_report_done/list_report_done_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'c_b_dashboard_model.dart';
export 'c_b_dashboard_model.dart';

class CBDashboardWidget extends StatefulWidget {
  const CBDashboardWidget({super.key});

  @override
  State<CBDashboardWidget> createState() => _CBDashboardWidgetState();
}

class _CBDashboardWidgetState extends State<CBDashboardWidget> {
  late CBDashboardModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<SuCo> _suCoList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CBDashboardModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
    _fetchReports();

    // Lắng nghe sự kiện thay đổi trên Firebase
    final databaseReference = FirebaseDatabase.instance.ref().child('baocao');
    databaseReference.onValue.listen((event) {
      if (event.snapshot.value != null) {
        final Map<dynamic, dynamic> reports = event.snapshot.value as Map<dynamic, dynamic>;
        List<SuCo> updatedList = [];
        reports.forEach((key, value) {
          updatedList.add(SuCo.fromJson(Map<String, dynamic>.from(value)));
        });
        setState(() {
          _suCoList = updatedList;
        });
      }
    });
  }

  Future<void> _fetchReports() async {
    final databaseReference = FirebaseDatabase.instance.ref().child('baocao');
    final snapshot = await databaseReference.once();

    if (snapshot.snapshot.value != null) {
      final Map<dynamic, dynamic> reports = snapshot.snapshot.value as Map<dynamic, dynamic>;
      reports.forEach((key, value) {
        _suCoList.add(SuCo.fromJson(Map<String, dynamic>.from(value)));
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        drawer: Drawer(
          elevation: 16.0,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 50.0, 0.0, 0.0),
            child: wrapWithModel(
              model: _model.accountProfileModel,
              updateCallback: () => setState(() {}),
              child: AccountProfileWidget(),
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderWidth: 1.0,
            buttonSize: 60.0,
            fillColor: FlutterFlowTheme.of(context).secondaryBackground,
            icon: Icon(
              Icons.dehaze,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 30.0,
            ),
            onPressed: () async {
              scaffoldKey.currentState!.openDrawer();
            },
          ),
          title: Align(
            alignment: AlignmentDirectional(1.0, 0.0),
            child: FFButtonWidget(
              onPressed: () {
                print('Button pressed ...');
              },
              text: '',
              icon: Icon(
                Icons.notifications_active_sharp,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 20.0,
              ),
              options: FFButtonOptions(
                height: 40.0,
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                iconPadding: EdgeInsets.all(0.0),
                color: FlutterFlowTheme.of(context).alternate,
                textStyle: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: 'Outfit',
                      color: Colors.white,
                      letterSpacing: 0.0,
                    ),
                elevation: 3.0,
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(100.0),
              ),
              showLoadingIndicator: false,
            ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 2.0,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Row(
                  children: [
                    Container(
                      width: 150.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: Color(0xFF5240F4),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Text(
                        'Danh sách sự cố',
                        style: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                          fontFamily: 'Readex Pro',
                          color: FlutterFlowTheme.of(context)
                              .secondaryBackground,
                          letterSpacing: 0.0,
                        ),
                      ),
                    ),
                    Expanded(
                      child: wrapWithModel(
                        model: _model.customMenuModel,
                        updateCallback: () => setState(() {}),
                        child: CustomMenuWidget(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Padding(
                  padding: EdgeInsets.all(18.0),
                  child: ListView.builder(
                    itemCount: _suCoList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: GestureDetector(
                          onTap: () async {
                            context.pushNamed('CB_DetailForm');
                          },
                          child: ListReportDoneWidget(suCo: _suCoList[index]),
                        ),
                      );
                    },
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
