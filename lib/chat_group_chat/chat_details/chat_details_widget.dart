import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/chat_group_chat/chat_messages/chat_messages_widget.dart';
import '/chat_group_chat/delete_dialog/delete_dialog_widget.dart';
import '/chat_group_chat/empty_state_simple/empty_state_simple_widget.dart';
import '/chat_group_chat/user_list_small/user_list_small_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'chat_details_model.dart';
export 'chat_details_model.dart';

class ChatDetailsWidget extends StatefulWidget {
  const ChatDetailsWidget({
    Key? key,
    required this.chatRef,
  }) : super(key: key);

  final ChatsRecord? chatRef;

  @override
  _ChatDetailsWidgetState createState() => _ChatDetailsWidgetState();
}

class _ChatDetailsWidgetState extends State<ChatDetailsWidget> {
  late ChatDetailsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatDetailsModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await widget.chatRef!.reference.update({
        ...mapToFirestore(
          {
            'last_message_seen_by':
                FieldValue.arrayUnion([currentUserReference]),
          },
        ),
      });
    });

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

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
        endDrawer: Drawer(
          elevation: 16.0,
          child: Container(
            width: double.infinity,
            height: 100.0,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 64.0, 0.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(12.0, 4.0, 0.0, 4.0),
                    child: RichText(
                      textScaleFactor: MediaQuery.of(context).textScaleFactor,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Group Chat ID: ',
                            style: TextStyle(),
                          ),
                          TextSpan(
                            text: valueOrDefault<String>(
                              widget.chatRef?.groupChatId?.toString(),
                              '--',
                            ),
                            style: TextStyle(
                              color: FlutterFlowTheme.of(context).primary,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                        style: FlutterFlowTheme.of(context).labelMedium,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                    child: Text(
                      'In this chat',
                      style: FlutterFlowTheme.of(context).headlineSmall,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                    child: Builder(
                      builder: (context) {
                        final chatUsers = widget.chatRef?.users?.toList() ?? [];
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: chatUsers.length,
                          itemBuilder: (context, chatUsersIndex) {
                            final chatUsersItem = chatUsers[chatUsersIndex];
                            return FutureBuilder<UsersRecord>(
                              future:
                                  UsersRecord.getDocumentOnce(chatUsersItem),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: SizedBox(
                                      width: 50.0,
                                      height: 50.0,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          Color(0xFF008037),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                final userListSmallUsersRecord = snapshot.data!;
                                return wrapWithModel(
                                  model: _model.userListSmallModels.getModel(
                                    chatUsersItem.id,
                                    chatUsersIndex,
                                  ),
                                  updateCallback: () => setState(() {}),
                                  updateOnChange: true,
                                  child: UserListSmallWidget(
                                    key: Key(
                                      'Keyz0f_${chatUsersItem.id}',
                                    ),
                                    userRef: userListSmallUsersRecord,
                                    action: () async {},
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Divider(
                    thickness: 1.0,
                    color: FlutterFlowTheme.of(context).alternate,
                  ),
                  wrapWithModel(
                    model: _model.deleteDialogModel,
                    updateCallback: () => setState(() {}),
                    updateOnChange: true,
                    child: DeleteDialogWidget(
                      chatList: widget.chatRef,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 30.0,
            ),
            onPressed: () async {
              context.pushNamed(
                'chat_Main',
                extra: <String, dynamic>{
                  kTransitionInfoKey: TransitionInfo(
                    hasTransition: true,
                    transitionType: PageTransitionType.leftToRight,
                    duration: Duration(milliseconds: 250),
                  ),
                },
              );
            },
          ),
          title: FutureBuilder<UsersRecord>(
            future: UsersRecord.getDocumentOnce(widget.chatRef!.users
                .where((e) => e != currentUserReference)
                .toList()
                .first),
            builder: (context, snapshot) {
              // Customize what your widget looks like when it's loading.
              if (!snapshot.hasData) {
                return Center(
                  child: SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFF008037),
                      ),
                    ),
                  ),
                );
              }
              final conditionalBuilderUsersRecord = snapshot.data!;
              return Builder(
                builder: (context) {
                  if (widget.chatRef!.users.length <= 2) {
                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        if (conditionalBuilderUsersRecord.photoUrl != null &&
                            conditionalBuilderUsersRecord.photoUrl != '')
                          Align(
                            alignment: AlignmentDirectional(-1.00, -1.00),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 12.0, 0.0),
                              child: Container(
                                width: 44.0,
                                height: 44.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).accent1,
                                  borderRadius: BorderRadius.circular(10.0),
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                    color: FlutterFlowTheme.of(context).primary,
                                    width: 2.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      2.0, 2.0, 2.0, 2.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      conditionalBuilderUsersRecord.photoUrl,
                                      width: 44.0,
                                      height: 44.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              valueOrDefault<String>(
                                conditionalBuilderUsersRecord.displayName,
                                'Ghost User',
                              ),
                              style: FlutterFlowTheme.of(context).bodyLarge,
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 4.0, 0.0, 0.0),
                              child: Text(
                                valueOrDefault<String>(
                                  conditionalBuilderUsersRecord.email,
                                  'casper@ghost.io',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .labelSmall
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  } else {
                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 4.0, 12.0, 4.0),
                          child: Container(
                            width: 54.0,
                            height: 44.0,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(1.00, 1.00),
                                  child: FutureBuilder<UsersRecord>(
                                    future: UsersRecord.getDocumentOnce(widget
                                        .chatRef!.users
                                        .where((e) => e != currentUserReference)
                                        .toList()
                                        .last),
                                    builder: (context, snapshot) {
                                      // Customize what your widget looks like when it's loading.
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: SizedBox(
                                            width: 50.0,
                                            height: 50.0,
                                            child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                Color(0xFF008037),
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      final secondUserUsersRecord =
                                          snapshot.data!;
                                      return Container(
                                        width: 32.0,
                                        height: 32.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .accent1,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            width: 2.0,
                                          ),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  2.0, 2.0, 2.0, 2.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.asset(
                                              'assets/images/Help_Anonymous_NEW.jpg',
                                              width: 44.0,
                                              height: 44.0,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(-1.00, -1.00),
                                  child: Container(
                                    width: 32.0,
                                    height: 32.0,
                                    decoration: BoxDecoration(
                                      color:
                                          FlutterFlowTheme.of(context).accent1,
                                      borderRadius: BorderRadius.circular(10.0),
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        width: 2.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          2.0, 2.0, 2.0, 2.0),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.asset(
                                          'assets/images/Help_Anonymous_NEW.jpg',
                                          width: 44.0,
                                          height: 44.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Group Chat',
                              style: FlutterFlowTheme.of(context).bodyLarge,
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 4.0, 0.0, 0.0),
                              child: Text(
                                '${valueOrDefault<String>(
                                  widget.chatRef?.users?.length.toString(),
                                  '2',
                                )} members',
                                style: FlutterFlowTheme.of(context)
                                    .labelSmall
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                },
              );
            },
          ),
          actions: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 16.0, 8.0),
              child: FlutterFlowIconButton(
                borderColor: FlutterFlowTheme.of(context).alternate,
                borderRadius: 12.0,
                borderWidth: 2.0,
                buttonSize: 40.0,
                fillColor: FlutterFlowTheme.of(context).primaryBackground,
                icon: Icon(
                  Icons.more_vert,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 24.0,
                ),
                onPressed: () async {
                  scaffoldKey.currentState!.openEndDrawer();
                },
              ),
            ),
          ],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).primaryBackground,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: StreamBuilder<List<ChatMessagesRecord>>(
                    stream: queryChatMessagesRecord(
                      queryBuilder: (chatMessagesRecord) => chatMessagesRecord
                          .where(
                            'chat',
                            isEqualTo: widget.chatRef?.reference,
                          )
                          .orderBy('timestamp', descending: true),
                      limit: 200,
                    )..listen((snapshot) async {
                        List<ChatMessagesRecord>
                            listViewChatMessagesRecordList = snapshot;
                        if (_model.listViewPreviousSnapshot != null &&
                            !const ListEquality(
                                    ChatMessagesRecordDocumentEquality())
                                .equals(listViewChatMessagesRecordList,
                                    _model.listViewPreviousSnapshot)) {
                          if (!widget.chatRef!.lastMessageSeenBy
                              .contains(currentUserReference)) {
                            await widget.chatRef!.reference.update({
                              ...mapToFirestore(
                                {
                                  'last_message_seen_by': FieldValue.arrayUnion(
                                      [currentUserReference]),
                                },
                              ),
                            });
                          }

                          setState(() {});
                        }
                        _model.listViewPreviousSnapshot = snapshot;
                      }),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return Center(
                          child: SizedBox(
                            width: 50.0,
                            height: 50.0,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFF008037),
                              ),
                            ),
                          ),
                        );
                      }
                      List<ChatMessagesRecord> listViewChatMessagesRecordList =
                          snapshot.data!;
                      if (listViewChatMessagesRecordList.isEmpty) {
                        return EmptyStateSimpleWidget(
                          icon: Icon(
                            Icons.forum_outlined,
                            color: FlutterFlowTheme.of(context).primary,
                            size: 90.0,
                          ),
                          title: 'No Messages',
                          body:
                              'You have not sent any messages in this chat yet.',
                        );
                      }
                      return ListView.separated(
                        padding: EdgeInsets.fromLTRB(
                          0,
                          12.0,
                          0,
                          24.0,
                        ),
                        reverse: true,
                        scrollDirection: Axis.vertical,
                        itemCount: listViewChatMessagesRecordList.length,
                        separatorBuilder: (_, __) => SizedBox(height: 8.0),
                        itemBuilder: (context, listViewIndex) {
                          final listViewChatMessagesRecord =
                              listViewChatMessagesRecordList[listViewIndex];
                          return wrapWithModel(
                            model: _model.chatMessagesModels.getModel(
                              listViewChatMessagesRecord.reference.id,
                              listViewIndex,
                            ),
                            updateCallback: () => setState(() {}),
                            updateOnChange: true,
                            child: ChatMessagesWidget(
                              key: Key(
                                'Key05h_${listViewChatMessagesRecord.reference.id}',
                              ),
                              chatMessagesRef: listViewChatMessagesRecord,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 3.0,
                        color: Color(0x33000000),
                        offset: Offset(0.0, -2.0),
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      if (_model.uploadedFileUrl != null &&
                          _model.uploadedFileUrl != '')
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 12.0, 0.0, 0.0),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: CachedNetworkImage(
                                          fadeInDuration:
                                              Duration(milliseconds: 200),
                                          fadeOutDuration:
                                              Duration(milliseconds: 200),
                                          imageUrl: _model.uploadedFileUrl,
                                          width: 120.0,
                                          height: 100.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(-1.00, -1.00),
                                        child: FlutterFlowIconButton(
                                          borderColor:
                                              FlutterFlowTheme.of(context)
                                                  .error,
                                          borderRadius: 20.0,
                                          borderWidth: 2.0,
                                          buttonSize: 40.0,
                                          fillColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryBackground,
                                          icon: Icon(
                                            Icons.delete_outline_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            size: 24.0,
                                          ),
                                          onPressed: () async {
                                            setState(() {
                                              _model.isDataUploading = false;
                                              _model.uploadedLocalFile =
                                                  FFUploadedFile(
                                                      bytes: Uint8List.fromList(
                                                          []));
                                              _model.uploadedFileUrl = '';
                                            });
                                          },
                                        ),
                                      ),
                                    ]
                                        .divide(SizedBox(width: 8.0))
                                        .addToStart(SizedBox(width: 16.0))
                                        .addToEnd(SizedBox(width: 16.0)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      Form(
                        key: _model.formKey,
                        autovalidateMode: AutovalidateMode.disabled,
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              12.0, 12.0, 12.0, 12.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FlutterFlowIconButton(
                                borderColor:
                                    FlutterFlowTheme.of(context).alternate,
                                borderRadius: 60.0,
                                borderWidth: 1.0,
                                buttonSize: 40.0,
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                icon: Icon(
                                  Icons.add_rounded,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 24.0,
                                ),
                                onPressed: () async {
                                  final selectedMedia =
                                      await selectMediaWithSourceBottomSheet(
                                    context: context,
                                    maxWidth: 1200.00,
                                    allowPhoto: true,
                                    backgroundColor:
                                        FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                    textColor: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    pickerFontFamily: 'Outfit',
                                  );
                                  if (selectedMedia != null &&
                                      selectedMedia.every((m) =>
                                          validateFileFormat(
                                              m.storagePath, context))) {
                                    setState(
                                        () => _model.isDataUploading = true);
                                    var selectedUploadedFiles =
                                        <FFUploadedFile>[];

                                    var downloadUrls = <String>[];
                                    try {
                                      showUploadMessage(
                                        context,
                                        'Uploading file...',
                                        showLoading: true,
                                      );
                                      selectedUploadedFiles = selectedMedia
                                          .map((m) => FFUploadedFile(
                                                name: m.storagePath
                                                    .split('/')
                                                    .last,
                                                bytes: m.bytes,
                                                height: m.dimensions?.height,
                                                width: m.dimensions?.width,
                                                blurHash: m.blurHash,
                                              ))
                                          .toList();

                                      downloadUrls = (await Future.wait(
                                        selectedMedia.map(
                                          (m) async => await uploadData(
                                              m.storagePath, m.bytes),
                                        ),
                                      ))
                                          .where((u) => u != null)
                                          .map((u) => u!)
                                          .toList();
                                    } finally {
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                      _model.isDataUploading = false;
                                    }
                                    if (selectedUploadedFiles.length ==
                                            selectedMedia.length &&
                                        downloadUrls.length ==
                                            selectedMedia.length) {
                                      setState(() {
                                        _model.uploadedLocalFile =
                                            selectedUploadedFiles.first;
                                        _model.uploadedFileUrl =
                                            downloadUrls.first;
                                      });
                                      showUploadMessage(context, 'Success!');
                                    } else {
                                      setState(() {});
                                      showUploadMessage(
                                          context, 'Failed to upload data');
                                      return;
                                    }
                                  }

                                  if (_model.uploadedFileUrl != null &&
                                      _model.uploadedFileUrl != '') {
                                    setState(() {
                                      _model.addToUploadedImages(
                                          _model.uploadedFileUrl);
                                    });
                                  }
                                },
                              ),
                              Expanded(
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8.0, 0.0, 0.0, 0.0),
                                      child: Container(
                                        width: double.infinity,
                                        child: TextFormField(
                                          controller: _model.textController,
                                          focusNode: _model.textFieldFocusNode,
                                          onFieldSubmitted: (_) async {
                                            if (_model.formKey.currentState ==
                                                    null ||
                                                !_model.formKey.currentState!
                                                    .validate()) {
                                              return;
                                            }
                                            // newChatMessage

                                            var chatMessagesRecordReference =
                                                ChatMessagesRecord.collection
                                                    .doc();
                                            await chatMessagesRecordReference
                                                .set(
                                                    createChatMessagesRecordData(
                                              user: currentUserReference,
                                              chat: widget.chatRef?.reference,
                                              text: _model.textController.text,
                                              timestamp: getCurrentTimestamp,
                                              image: _model.uploadedFileUrl,
                                            ));
                                            _model.newChatMessage = ChatMessagesRecord
                                                .getDocumentFromData(
                                                    createChatMessagesRecordData(
                                                      user:
                                                          currentUserReference,
                                                      chat: widget
                                                          .chatRef?.reference,
                                                      text: _model
                                                          .textController.text,
                                                      timestamp:
                                                          getCurrentTimestamp,
                                                      image: _model
                                                          .uploadedFileUrl,
                                                    ),
                                                    chatMessagesRecordReference);
                                            // clearUsers
                                            _model.lastMessageSeenBy = [];
                                            // In order to add a single user reference to a list of user references we are adding our current user reference to a page state.
                                            //
                                            // We will then set the value of the user reference list from this page state.
                                            // addMyUserToList
                                            _model.addToLastMessageSeenBy(
                                                currentUserReference!);
                                            // updateChatDocument

                                            await widget.chatRef!.reference
                                                .update({
                                              ...createChatsRecordData(
                                                lastMessageTime:
                                                    getCurrentTimestamp,
                                                lastMessageSentBy:
                                                    currentUserReference,
                                                lastMessage:
                                                    _model.textController.text,
                                              ),
                                              ...mapToFirestore(
                                                {
                                                  'last_message_seen_by':
                                                      _model.lastMessageSeenBy,
                                                },
                                              ),
                                            });
                                            setState(() {
                                              _model.textController?.clear();
                                            });
                                            setState(() {
                                              _model.isDataUploading = false;
                                              _model.uploadedLocalFile =
                                                  FFUploadedFile(
                                                      bytes: Uint8List.fromList(
                                                          []));
                                              _model.uploadedFileUrl = '';
                                            });

                                            setState(() {
                                              _model.uploadedImages = [];
                                            });

                                            setState(() {});
                                          },
                                          autofocus: true,
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          textInputAction: TextInputAction.send,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium,
                                            hintText: 'Start typing here...',
                                            hintStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmall,
                                            errorStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Readex Pro',
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .error,
                                                      fontSize: 12.0,
                                                    ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .alternate,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(24.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(24.0),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(24.0),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(24.0),
                                            ),
                                            contentPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 16.0, 56.0, 16.0),
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium,
                                          maxLines: 12,
                                          minLines: 1,
                                          cursorColor:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                          validator: _model
                                              .textControllerValidator
                                              .asValidator(context),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                          AlignmentDirectional(1.00, 0.00),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 4.0, 6.0, 4.0),
                                        child: FlutterFlowIconButton(
                                          borderColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                          borderRadius: 20.0,
                                          borderWidth: 1.0,
                                          buttonSize: 40.0,
                                          fillColor:
                                              FlutterFlowTheme.of(context)
                                                  .accent1,
                                          icon: Icon(
                                            Icons.send_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            size: 20.0,
                                          ),
                                          onPressed: () async {
                                            final firestoreBatch =
                                                FirebaseFirestore.instance
                                                    .batch();
                                            try {
                                              if (_model.formKey.currentState ==
                                                      null ||
                                                  !_model.formKey.currentState!
                                                      .validate()) {
                                                return;
                                              }
                                              // newChatMessage

                                              var chatMessagesRecordReference =
                                                  ChatMessagesRecord.collection
                                                      .doc();
                                              firestoreBatch.set(
                                                  chatMessagesRecordReference,
                                                  createChatMessagesRecordData(
                                                    user: currentUserReference,
                                                    chat: widget
                                                        .chatRef?.reference,
                                                    text: _model
                                                        .textController.text,
                                                    timestamp:
                                                        getCurrentTimestamp,
                                                    image:
                                                        _model.uploadedFileUrl,
                                                  ));
                                              _model.newChat = ChatMessagesRecord
                                                  .getDocumentFromData(
                                                      createChatMessagesRecordData(
                                                        user:
                                                            currentUserReference,
                                                        chat: widget
                                                            .chatRef?.reference,
                                                        text: _model
                                                            .textController
                                                            .text,
                                                        timestamp:
                                                            getCurrentTimestamp,
                                                        image: _model
                                                            .uploadedFileUrl,
                                                      ),
                                                      chatMessagesRecordReference);
                                              // clearUsers
                                              _model.lastMessageSeenBy = [];
                                              // In order to add a single user reference to a list of user references we are adding our current user reference to a page state.
                                              //
                                              // We will then set the value of the user reference list from this page state.
                                              // addMyUserToList
                                              _model.addToLastMessageSeenBy(
                                                  currentUserReference!);
                                              // updateChatDocument

                                              firestoreBatch.update(
                                                  widget.chatRef!.reference, {
                                                ...createChatsRecordData(
                                                  lastMessageTime:
                                                      getCurrentTimestamp,
                                                  lastMessageSentBy:
                                                      currentUserReference,
                                                  lastMessage: _model
                                                      .textController.text,
                                                ),
                                                ...mapToFirestore(
                                                  {
                                                    'last_message_seen_by':
                                                        _model
                                                            .lastMessageSeenBy,
                                                  },
                                                ),
                                              });
                                              setState(() {
                                                _model.textController?.clear();
                                              });
                                              setState(() {
                                                _model.isDataUploading = false;
                                                _model.uploadedLocalFile =
                                                    FFUploadedFile(
                                                        bytes:
                                                            Uint8List.fromList(
                                                                []));
                                                _model.uploadedFileUrl = '';
                                              });

                                              setState(() {
                                                _model.uploadedImages = [];
                                              });
                                            } finally {
                                              await firestoreBatch.commit();
                                            }

                                            setState(() {});
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
