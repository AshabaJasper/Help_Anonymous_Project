import '/account_profile_creation/edit_profile_auth_2/edit_profile_auth2_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'auth2_edit_profile_model.dart';
export 'auth2_edit_profile_model.dart';

class Auth2EditProfileWidget extends StatefulWidget {
  const Auth2EditProfileWidget({Key? key}) : super(key: key);

  @override
  _Auth2EditProfileWidgetState createState() => _Auth2EditProfileWidgetState();
}

class _Auth2EditProfileWidgetState extends State<Auth2EditProfileWidget>
    with TickerProviderStateMixin {
  late Auth2EditProfileModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'containerOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        VisibilityEffect(duration: 1.ms),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 400.ms,
          begin: 0.0,
          end: 1.0,
        ),
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 400.ms,
          begin: Offset(3.0, 3.0),
          end: Offset(1.0, 1.0),
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Auth2EditProfileModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
              child: Container(
                width: double.infinity,
                height: 130.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      FlutterFlowTheme.of(context).primary,
                      FlutterFlowTheme.of(context).error,
                      FlutterFlowTheme.of(context).tertiary
                    ],
                    stops: [0.0, 0.5, 1.0],
                    begin: AlignmentDirectional(-1.0, -1.0),
                    end: AlignmentDirectional(1.0, 1.0),
                  ),
                ),
                child: Container(
                  width: 100.0,
                  height: 200.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: Image.asset(
                        'assets/images/DALLE_2023-10-27_18.04.26_-_Illustration_of_a_Black_woman_seated_in_a_room_bathed_in_green_light,_surrounded_by_wavy_green_lines_symbolizing_her_thoughts._She_holds_her_head_in_h.png',
                      ).image,
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Color(0x00FFFFFF),
                        FlutterFlowTheme.of(context).secondaryBackground
                      ],
                      stops: [0.0, 1.0],
                      begin: AlignmentDirectional(0.0, -1.0),
                      end: AlignmentDirectional(0, 1.0),
                    ),
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(-1.00, 1.00),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 24.0),
                      child: FlutterFlowIconButton(
                        borderColor: FlutterFlowTheme.of(context).accent4,
                        borderRadius: 12.0,
                        borderWidth: 1.0,
                        buttonSize: 40.0,
                        fillColor: FlutterFlowTheme.of(context).accent4,
                        icon: Icon(
                          Icons.arrow_back_rounded,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 24.0,
                        ),
                        onPressed: () async {
                          context.safePop();
                        },
                      ),
                    ),
                  ),
                ),
              ).animateOnPageLoad(
                  animationsMap['containerOnPageLoadAnimation']!),
            ),
            Align(
              alignment: AlignmentDirectional(0.00, -1.00),
              child: Container(
                width: double.infinity,
                constraints: BoxConstraints(
                  maxWidth: 770.0,
                ),
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: wrapWithModel(
                  model: _model.editProfileAuth2Model,
                  updateCallback: () => setState(() {}),
                  child: EditProfileAuth2Widget(
                    title: 'Edit Profile',
                    confirmButtonText: 'Save Changes',
                    navigateAction: () async {
                      context.safePop();
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
