import 'package:due_v1/components/list_report_progress/list_report_progress_widget.dart';
import 'package:due_v1/flutter_flow/flutter_flow_util.dart';
import 'package:due_v1/index.dart';
import 'package:due_v1/pages/n_v_user/n_v_tiepnhan_form/n_v_tiepnhan_form_widget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../../components/account_profile/account_profile_widget.dart';
import '../../../components/list_report_done/list_report_done_widget.dart';
import '../../../flutter_flow/flutter_flow_icon_button.dart';
import '../../../flutter_flow/flutter_flow_model.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';
import '../../../suco.dart';
import 'n_v_dashboard_model.dart';

class NVDashboardWidget extends StatefulWidget {
  const NVDashboardWidget({Key? key}) : super(key: key);

  @override
  State<NVDashboardWidget> createState() => _NVDashboardWidgetState();
}

class _NVDashboardWidgetState extends State<NVDashboardWidget> {
  late NVDashboardModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<SuCo> _suCoList = [];
  bool _isLoading = true;
  String _filterStatus = '';

  List<SuCo> getFilteredSuCoList() {
    if (_filterStatus.isEmpty) {
      return _suCoList;
    } else if (_filterStatus == 'multiple') {
      return _suCoList.where((suCo) =>
      suCo.trangThai == 'c' || suCo.trangThai == 'd' || suCo.trangThai == 'b').toList();
    } else if (_filterStatus == 'a') {
      return _suCoList.where((suCo) => suCo.trangThai == 'a').toList();
    } else {
      return _suCoList;
    }
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NVDashboardModel());
    WidgetsBinding.instance!.addPostFrameCallback((_) => setState(() {}));
    _fetchReports();
  }

  Future<void> _fetchReports() async {
    final databaseReference = FirebaseDatabase.instance.ref().child('baocao');

    databaseReference.onValue.listen((event) {
      final snapshot = event.snapshot;

      if (snapshot.value != null) {
        final Map<dynamic, dynamic> reports =
        snapshot.value as Map<dynamic, dynamic>;
        _suCoList.clear();
        reports.forEach((key, value) {
          _suCoList.add(SuCo.fromJson(Map<String, dynamic>.from(value)));
        });
      }

      setState(() {
        _isLoading = false;
      });
    });
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
            borderRadius: 30.0,
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
            Container(
              padding: const EdgeInsets.all(8.0),
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
                      'Danh sách nhiệm vụ',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Readex Pro',
                        color: FlutterFlowTheme.of(context)
                            .secondaryBackground,
                        letterSpacing: 0.0,
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                  Center(
                    child: PopupMenuButton<String>(
                      onSelected: (String result) {
                        setState(() {
                          if (result == 'Tùy chọn 1') {
                            _filterStatus = 'a';
                          } else if (result == 'Tùy chọn 2') {
                            _filterStatus = 'multiple';
                          }
                        });
                      },
                      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'Tùy chọn 1',
                          child: Text('Chưa tiếp nhận'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'Tùy chọn 2',
                          child: Text('Nhiệm vụ của tôi'),
                        ),
                      ],
                      icon: Icon(Icons.filter_list, size: 30),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Padding(
                  padding: EdgeInsets.all(18.0),
                  child: ListView.builder(
                    itemCount: getFilteredSuCoList().length,
                    itemBuilder: (context, index) {
                      SuCo suCo = getFilteredSuCoList()[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: GestureDetector(
                          onTap: () async {
                            if (suCo.trangThai == 'a') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NVTiepnhanFormWidget(suCo: suCo),
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NVLogFormWidget(suCo: suCo),
                                ),
                              );
                            }
                          },
                          child: ListReportProgressWidget(
                            suCo: suCo,
                          ),
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
