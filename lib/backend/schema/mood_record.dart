import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MoodRecord extends FirestoreRecord {
  MoodRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "users" field.
  List<DocumentReference>? _users;
  List<DocumentReference> get users => _users ?? const [];
  bool hasUsers() => _users != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  bool hasDate() => _date != null;

  // "mood" field.
  String? _mood;
  String get mood => _mood ?? '';
  bool hasMood() => _mood != null;

  // "mood2" field.
  String? _mood2;
  String get mood2 => _mood2 ?? '';
  bool hasMood2() => _mood2 != null;

  // "mood3" field.
  String? _mood3;
  String get mood3 => _mood3 ?? '';
  bool hasMood3() => _mood3 != null;

  // "MentalHealth" field.
  String? _mentalHealth;
  String get mentalHealth => _mentalHealth ?? '';
  bool hasMentalHealth() => _mentalHealth != null;

  void _initializeFields() {
    _users = getDataList(snapshotData['users']);
    _date = snapshotData['date'] as DateTime?;
    _mood = snapshotData['mood'] as String?;
    _mood2 = snapshotData['mood2'] as String?;
    _mood3 = snapshotData['mood3'] as String?;
    _mentalHealth = snapshotData['MentalHealth'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Mood');

  static Stream<MoodRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => MoodRecord.fromSnapshot(s));

  static Future<MoodRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => MoodRecord.fromSnapshot(s));

  static MoodRecord fromSnapshot(DocumentSnapshot snapshot) => MoodRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static MoodRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      MoodRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'MoodRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is MoodRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createMoodRecordData({
  DateTime? date,
  String? mood,
  String? mood2,
  String? mood3,
  String? mentalHealth,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'date': date,
      'mood': mood,
      'mood2': mood2,
      'mood3': mood3,
      'MentalHealth': mentalHealth,
    }.withoutNulls,
  );

  return firestoreData;
}

class MoodRecordDocumentEquality implements Equality<MoodRecord> {
  const MoodRecordDocumentEquality();

  @override
  bool equals(MoodRecord? e1, MoodRecord? e2) {
    const listEquality = ListEquality();
    return listEquality.equals(e1?.users, e2?.users) &&
        e1?.date == e2?.date &&
        e1?.mood == e2?.mood &&
        e1?.mood2 == e2?.mood2 &&
        e1?.mood3 == e2?.mood3 &&
        e1?.mentalHealth == e2?.mentalHealth;
  }

  @override
  int hash(MoodRecord? e) => const ListEquality()
      .hash([e?.users, e?.date, e?.mood, e?.mood2, e?.mood3, e?.mentalHealth]);

  @override
  bool isValidKey(Object? o) => o is MoodRecord;
}
