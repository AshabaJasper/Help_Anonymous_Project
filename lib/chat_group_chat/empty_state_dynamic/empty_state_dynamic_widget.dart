import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'empty_state_dynamic_model.dart';
export 'empty_state_dynamic_model.dart';

class EmptyStateDynamicWidget extends StatefulWidget {
  const EmptyStateDynamicWidget({
    Key? key,
    this.icon,
    String? title,
    String? body,
    this.buttonAction,
    String? buttonText,
  })  : this.title = title ?? 'No Friends',
        this.body = body ??
            'It seems that you dont\' have  any friends, find friends from searching users below.',
        this.buttonText = buttonText ?? 'Find Friends',
        super(key: key);

  final Widget? icon;
  final String title;
  final String body;
  final Future<dynamic> Function()? buttonAction;
  final String buttonText;

  @override
  _EmptyStateDynamicWidgetState createState() =>
      _EmptyStateDynamicWidgetState();
}

class _EmptyStateDynamicWidgetState extends State<EmptyStateDynamicWidget> {
  late EmptyStateDynamicModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EmptyStateDynamicModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.00, -1.00),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.icon!,
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
            child: Text(
              widget.title,
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).headlineSmall.override(
                    fontFamily: 'Outfit',
                    color: FlutterFlowTheme.of(context).primaryText,
                  ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 0.0),
            child: Text(
              widget.body,
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).labelMedium,
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
            child: FFButtonWidget(
              onPressed: () async {
                await widget.buttonAction?.call();
              },
              text: widget.buttonText,
              options: FFButtonOptions(
                height: 44.0,
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: FlutterFlowTheme.of(context).primary,
                textStyle: FlutterFlowTheme.of(context).titleSmall,
                elevation: 3.0,
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(12.0),
                hoverColor: FlutterFlowTheme.of(context).accent1,
                hoverBorderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).primary,
                  width: 1.0,
                ),
                hoverTextColor: FlutterFlowTheme.of(context).primaryText,
                hoverElevation: 0.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
