import 'package:due_v1/components/list_report_progress/list_report_progress_widget.dart';
import 'package:due_v1/flutter_flow/flutter_flow_util.dart';
import 'package:due_v1/index.dart';
import 'package:due_v1/pages/n_v_user/n_v_tiepnhan_form/n_v_tiepnhan_form_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  late User? _currentUser; // Đối tượng để lưu trữ thông tin người dùng hiện tại
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<SuCo> _suCoList = [];
  bool _isLoading = true;
  String _filterStatus = '';
  String _selectedFilter = ''; // Biến để lưu trữ nội dung được chọn


  List<SuCo> getFilteredSuCoList() {
    String? currentUserEmail = _currentUser?.email;
    if (_filterStatus.isEmpty) {
      return _suCoList;
    } else if (_filterStatus == 'multiple') {
      return _suCoList.where((suCo) =>
      suCo.nguoiTiepNhan == currentUserEmail).toList();
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
    // Đặt giá trị ban đầu cho _filterStatus và _selectedFilter
    _filterStatus = 'a';
    _selectedFilter = 'Chưa tiếp nhận';

    // Lấy thông tin người dùng hiện tại
    _currentUser = FirebaseAuth.instance.currentUser;
    // Log thông tin người dùng hiện tại
    print('Current User: $_currentUser');
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
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Center(
                      child: PopupMenuButton<String>(
                        initialValue: _selectedFilter,
                        onSelected: (String result) {
                          setState(() {
                            if (result == 'Tùy chọn 1') {
                              _filterStatus = 'a';
                              _selectedFilter = 'Chưa tiếp nhận'; // Cập nhật giá trị được chọn
                            } else if (result == 'Tùy chọn 2') {
                              _filterStatus = 'multiple';
                              _selectedFilter = 'Nhiệm vụ của tôi'; // Cập nhật giá trị được chọn
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
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            children: [
                              Text(
                                _selectedFilter,
                                style: TextStyle(fontSize: 16),
                              ),
                              Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                      ),
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
                            } else if (suCo.trangThai == 'c' || suCo.trangThai == 'd') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CBDetailFormWidget(suCo: suCo),
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
