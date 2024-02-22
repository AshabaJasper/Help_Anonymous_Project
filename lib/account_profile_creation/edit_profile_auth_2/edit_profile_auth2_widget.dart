import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'edit_profile_auth2_model.dart';
export 'edit_profile_auth2_model.dart';

class EditProfileAuth2Widget extends StatefulWidget {
  const EditProfileAuth2Widget({
    Key? key,
    String? title,
    String? confirmButtonText,
    required this.navigateAction,
  })  : this.title = title ?? 'Edit Profile',
        this.confirmButtonText = confirmButtonText ?? 'Save Changes',
        super(key: key);

  final String title;
  final String confirmButtonText;
  final Future<dynamic> Function()? navigateAction;

  @override
  _EditProfileAuth2WidgetState createState() => _EditProfileAuth2WidgetState();
}

class _EditProfileAuth2WidgetState extends State<EditProfileAuth2Widget> {
  late EditProfileAuth2Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditProfileAuth2Model());

    _model.yourNameController ??=
        TextEditingController(text: currentUserDisplayName);
    _model.yourNameFocusNode ??= FocusNode();

    _model.myBioController ??= TextEditingController(
        text: valueOrDefault(currentUserDocument?.shortDescription, ''));
    _model.myBioFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _model.formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 0.0, 0.0),
            child: Text(
              widget.title,
              style: FlutterFlowTheme.of(context).displaySmall,
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24.0, 8.0, 0.0, 20.0),
            child: Text(
              'Please fill in the content below:',
              style: FlutterFlowTheme.of(context).labelLarge,
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 12.0),
            child: AuthUserStreamWidget(
              builder: (context) => TextFormField(
                controller: _model.yourNameController,
                focusNode: _model.yourNameFocusNode,
                autofillHints: [AutofillHints.name],
                textCapitalization: TextCapitalization.words,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Enter Nickname',
                  labelStyle: FlutterFlowTheme.of(context).labelMedium,
                  hintText: 'Your full name...',
                  hintStyle: FlutterFlowTheme.of(context).labelMedium,
                  errorStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Readex Pro',
                        color: FlutterFlowTheme.of(context).error,
                      ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).alternate,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).primary,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).error,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).error,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: FlutterFlowTheme.of(context).primaryBackground,
                  contentPadding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 0.0, 12.0),
                ),
                style: FlutterFlowTheme.of(context).bodyMedium,
                cursorColor: FlutterFlowTheme.of(context).primary,
                validator:
                    _model.yourNameControllerValidator.asValidator(context),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 12.0),
            child: AuthUserStreamWidget(
              builder: (context) => TextFormField(
                controller: _model.myBioController,
                focusNode: _model.myBioFocusNode,
                textCapitalization: TextCapitalization.sentences,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Enter a short description ',
                  labelStyle: FlutterFlowTheme.of(context).labelMedium,
                  hintText: 'A little about you and your mental health state',
                  hintStyle: FlutterFlowTheme.of(context).labelMedium,
                  errorStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Readex Pro',
                        color: FlutterFlowTheme.of(context).error,
                      ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).alternate,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).primary,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).error,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).error,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: FlutterFlowTheme.of(context).primaryBackground,
                  contentPadding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 0.0, 12.0),
                ),
                style: FlutterFlowTheme.of(context).bodyMedium,
                textAlign: TextAlign.start,
                maxLines: 3,
                cursorColor: FlutterFlowTheme.of(context).primary,
                validator: _model.myBioControllerValidator.asValidator(context),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(0.00, 0.00),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20.0, 24.0, 20.0, 0.0),
              child: FFButtonWidget(
                onPressed: () async {
                  if (_model.formKey.currentState == null ||
                      !_model.formKey.currentState!.validate()) {
                    return;
                  }
                  // updateUserInfo

                  await currentUserReference!.update(createUsersRecordData(
                    displayName: _model.yourNameController.text,
                    shortDescription: _model.myBioController.text,
                    lastActiveTime: getCurrentTimestamp,
                  ));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Profile has been updated!',
                        style: FlutterFlowTheme.of(context).titleSmall.override(
                              fontFamily: 'Readex Pro',
                              color: FlutterFlowTheme.of(context).info,
                            ),
                      ),
                      duration: Duration(milliseconds: 4000),
                      backgroundColor: FlutterFlowTheme.of(context).primary,
                    ),
                  );
                  await widget.navigateAction?.call();

                  context.pushNamed('SelfAssesmentList');
                },
                text: widget.confirmButtonText,
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 44.0,
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: FlutterFlowTheme.of(context).primary,
                  textStyle: FlutterFlowTheme.of(context).titleSmall,
                  elevation: 3.0,
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
