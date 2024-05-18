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

  get suCo => null;

  List<SuCo> getFilteredSuCoList() {
    if (_filterStatus.isEmpty) {
      return _suCoList;
    } else {
      return _suCoList.where((suCo) => suCo.trangThai == _filterStatus).toList();
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
                            _filterStatus = 'b';
                          } else if (result == 'Tùy chọn 3') {
                            _filterStatus = 'c';
                          } else if (result == 'Tùy chọn 4') {
                            _filterStatus = 'd';
                          } else {
                            _filterStatus = '';
                          }
                        });
                      },
                      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'Tùy chọn 0',
                          child: Text('Tất cả'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'Tùy chọn 1',
                          child: Text('Tiếp nhận'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'Tùy chọn 2',
                          child: Text('Đang xử lý'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'Tùy chọn 3',
                          child: Text('Hoàn thành'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'Tùy chọn 4',
                          child: Text('Xử lý lỗi'),
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
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: _suCoList.length,
                          itemBuilder: (context, index) {
                            // Kiểm tra xem có cần lọc danh sách hay không
                            if (_filterStatus.isNotEmpty &&
                                _suCoList[index].trangThai !=
                                    _filterStatus) {
                              // Bỏ qua nếu không khớp với trạng thái lọc
                              return SizedBox.shrink();
                            }
                            return Padding(
                              padding:
                              const EdgeInsets.only(bottom: 15.0),
                              child: GestureDetector(
                                onTap: () async {
                                  if (_suCoList[index].trangThai == 'a') {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => NVTiepnhanFormWidget(suCo: _suCoList[index]),
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
                                  suCo: _suCoList[index],
                                ),
                              ),

                            );
                          },
                        ),
                      ),
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
