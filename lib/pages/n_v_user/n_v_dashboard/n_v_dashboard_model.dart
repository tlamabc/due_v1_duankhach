import '/components/account_profile/account_profile_widget.dart';
import '/components/list_report_done/list_report_done_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'n_v_dashboard_widget.dart' show NVDashboardWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NVDashboardModel extends FlutterFlowModel<NVDashboardWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for listReport_Done component.
  // late ListReportDoneModel listReportDoneModel1;
  // // Model for listReport_Done component.
  // late ListReportDoneModel listReportDoneModel2;
  // // Model for listReport_Done component.
  // late ListReportDoneModel listReportDoneModel3;
  // // Model for listReport_Done component.
  // late ListReportDoneModel listReportDoneModel4;
  // Model for accountProfile component.
  late AccountProfileModel accountProfileModel;

  @override
  void initState(BuildContext context) {
    // listReportDoneModel1 = createModel(context, () => ListReportDoneModel());
    // listReportDoneModel2 = createModel(context, () => ListReportDoneModel());
    // listReportDoneModel3 = createModel(context, () => ListReportDoneModel());
    // listReportDoneModel4 = createModel(context, () => ListReportDoneModel());
    accountProfileModel = createModel(context, () => AccountProfileModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    // listReportDoneModel1.dispose();
    // listReportDoneModel2.dispose();
    // listReportDoneModel3.dispose();
    // listReportDoneModel4.dispose();
    accountProfileModel.dispose();
  }
}
