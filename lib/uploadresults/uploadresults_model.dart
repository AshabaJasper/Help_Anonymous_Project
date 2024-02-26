import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'uploadresults_widget.dart' show UploadresultsWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UploadresultsModel extends FlutterFlowModel<UploadresultsWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  List<String>? get choiceChipsValues => choiceChipsValueController?.value;
  set choiceChipsValues(List<String>? val) =>
      choiceChipsValueController?.value = val;
  // State field(s) for workEmail widget.
  FocusNode? workEmailFocusNode1;
  TextEditingController? workEmailController1;
  String? Function(BuildContext, String?)? workEmailController1Validator;
  // State field(s) for workEmail widget.
  FocusNode? workEmailFocusNode2;
  TextEditingController? workEmailController2;
  String? Function(BuildContext, String?)? workEmailController2Validator;
  // State field(s) for jobTitle widget.
  FocusNode? jobTitleFocusNode;
  TextEditingController? jobTitleController;
  String? Function(BuildContext, String?)? jobTitleControllerValidator;
  // State field(s) for workEmail widget.
  FocusNode? workEmailFocusNode3;
  TextEditingController? workEmailController3;
  String? Function(BuildContext, String?)? workEmailController3Validator;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    workEmailFocusNode1?.dispose();
    workEmailController1?.dispose();

    workEmailFocusNode2?.dispose();
    workEmailController2?.dispose();

    jobTitleFocusNode?.dispose();
    jobTitleController?.dispose();

    workEmailFocusNode3?.dispose();
    workEmailController3?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
