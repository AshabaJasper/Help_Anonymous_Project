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
import 'chat_details_widget.dart' show ChatDetailsWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChatDetailsModel extends FlutterFlowModel<ChatDetailsWidget> {
  ///  Local state fields for this page.

  List<String> uploadedImages = [];
  void addToUploadedImages(String item) => uploadedImages.add(item);
  void removeFromUploadedImages(String item) => uploadedImages.remove(item);
  void removeAtIndexFromUploadedImages(int index) =>
      uploadedImages.removeAt(index);
  void insertAtIndexInUploadedImages(int index, String item) =>
      uploadedImages.insert(index, item);
  void updateUploadedImagesAtIndex(int index, Function(String) updateFn) =>
      uploadedImages[index] = updateFn(uploadedImages[index]);

  List<DocumentReference> lastMessageSeenBy = [];
  void addToLastMessageSeenBy(DocumentReference item) =>
      lastMessageSeenBy.add(item);
  void removeFromLastMessageSeenBy(DocumentReference item) =>
      lastMessageSeenBy.remove(item);
  void removeAtIndexFromLastMessageSeenBy(int index) =>
      lastMessageSeenBy.removeAt(index);
  void insertAtIndexInLastMessageSeenBy(int index, DocumentReference item) =>
      lastMessageSeenBy.insert(index, item);
  void updateLastMessageSeenByAtIndex(
          int index, Function(DocumentReference) updateFn) =>
      lastMessageSeenBy[index] = updateFn(lastMessageSeenBy[index]);

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  List<ChatMessagesRecord>? listViewPreviousSnapshot;
  // Models for chatMessages dynamic component.
  late FlutterFlowDynamicModels<ChatMessagesModel> chatMessagesModels;
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - Create Document] action in TextField widget.
  ChatMessagesRecord? newChatMessage;
  // Stores action output result for [Backend Call - Create Document] action in IconButton widget.
  ChatMessagesRecord? newChat;
  // Models for user_ListSmall dynamic component.
  late FlutterFlowDynamicModels<UserListSmallModel> userListSmallModels;
  // Model for deleteDialog component.
  late DeleteDialogModel deleteDialogModel;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    chatMessagesModels = FlutterFlowDynamicModels(() => ChatMessagesModel());
    userListSmallModels = FlutterFlowDynamicModels(() => UserListSmallModel());
    deleteDialogModel = createModel(context, () => DeleteDialogModel());
  }

  void dispose() {
    unfocusNode.dispose();
    chatMessagesModels.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();

    userListSmallModels.dispose();
    deleteDialogModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
