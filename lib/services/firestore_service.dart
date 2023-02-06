import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:syren/models/models.dart';

class FirestoreService<T extends FirebaseModel> extends GetxService {
  final String collection;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  final T Function(String, Map<String, dynamic>?) fromDS;
  final Map<String, dynamic> Function(T)? toMap;

  FirestoreService(this.collection, {required this.fromDS, this.toMap});

  String? userId;
  //
  @override
  void onInit() {
    if (auth.currentUser != null) {
      userId = auth.currentUser?.uid;
    } else {
      userId = null;
    }
    super.onInit();
  }

  Future<dynamic> createByUser(T item) async {
    try {
      await _db
          .collection('users')
          .doc(userId)
          .collection(collection)
          .add(item.toJson());
      return true;
    } catch (e) {
      debugPrintStack();
      return false;
    }
  }

  Stream<List<T>> streamListByUser() {
    var ref = _db.collection('users').doc(userId).collection(collection);
    return ref.snapshots().map(
        (list) => list.docs.map((doc) => fromDS(doc.id, doc.data())).toList());
  }

  Stream<List<T>> streamQueryListByUser(
      {List<OrderBy>? orderBy, List<QueryArgs>? args}) {
    CollectionReference collref =
        _db.collection('users').doc(userId).collection(collection);
    Query? ref;
    if (orderBy != null) {
      for (var order in orderBy) {
        if (ref == null) {
          ref = collref.orderBy(order.field, descending: order.descending);
        } else {
          ref = ref.orderBy(order.field, descending: order.descending);
        }
      }
    }
    if (args != null) {
      for (QueryArgs arg in args) {
        if (ref == null) {
          ref = collref.where(arg.key, isEqualTo: arg.value);
        } else {
          ref = ref.where(arg.key, isEqualTo: arg.value);
        }
      }
    }
    if (ref != null) {
      return ref.snapshots().map((snap) => snap.docs
          .map((doc) => fromDS(doc.id, doc.data() as Map<String, dynamic>))
          .toList());
    } else {
      return collref.snapshots().map((snap) => snap.docs
          .map((doc) => fromDS(doc.id, doc.data() as Map<String, dynamic>))
          .toList());
    }
  }

  Future<T?> getQuery({List<QueryArgs>? args}) async {
    CollectionReference collref = _db.collection(collection);
    Query? ref;
    if (args != null) {
      for (QueryArgs arg in args) {
        if (ref == null) {
          ref = collref.where(arg.key, isEqualTo: arg.value);
        } else {
          ref = ref.where(arg.key, isEqualTo: arg.value);
        }
      }
    }

    QuerySnapshot query;
    if (ref != null) {
      query = await ref.get();
    } else {
      query = await collref.get();
    }

    var result = query.docs
        .map((doc) => fromDS(doc.id, doc.data() as Map<String, dynamic>));

    return (result.isEmpty) ? null : result.first;
  }

  Future<T?> getSingle(String id) async {
    var snap = await _db.collection(collection).doc(id).get();
    if (!snap.exists) return null;
    return fromDS(snap.id, snap.data());
  }

  Stream<T> streamSingle(String id) {
    return _db
        .collection(collection)
        .doc(id)
        .snapshots()
        .map((snap) => fromDS(snap.id, snap.data()));
  }

  Stream<List<T>> streamList() {
    var ref = _db.collection(collection);
    return ref.snapshots().map(
        (list) => list.docs.map((doc) => fromDS(doc.id, doc.data())).toList());
  }

  Future<List<T>> getQueryList(
      {List<OrderBy>? orderBy,
      List<QueryArgs>? args,
      int? limit,
      dynamic startAfter}) async {
    CollectionReference collref = _db.collection(collection);
    Query? ref;
    if (args != null) {
      for (QueryArgs arg in args) {
        if (ref == null) {
          ref = collref.where(arg.key, isEqualTo: arg.value);
        } else {
          ref = ref.where(arg.key, isEqualTo: arg.value);
        }
      }
    }
    if (orderBy != null) {
      for (var order in orderBy) {
        if (ref == null) {
          ref = collref.orderBy(order.field, descending: order.descending);
        } else {
          ref = ref.orderBy(order.field, descending: order.descending);
        }
      }
    }
    if (limit != null) {
      if (ref == null) {
        ref = collref.limit(limit);
      } else {
        ref = ref.limit(limit);
      }
    }
    if (ref != null && startAfter != null && orderBy != null) {
      ref = ref.startAfter([startAfter]);
    }
    QuerySnapshot query;
    if (ref != null) {
      query = await ref.get();
    } else {
      query = await collref.get();
    }

    return query.docs
        .map((doc) => fromDS(doc.id, doc.data() as Map<String, dynamic>))
        .toList();
  }

  Stream<List<T>> streamQueryList(
      {List<OrderBy>? orderBy, List<QueryArgs>? args}) {
    CollectionReference collref = _db.collection(collection);
    Query? ref;
    if (orderBy != null) {
      for (var order in orderBy) {
        if (ref == null) {
          ref = collref.orderBy(order.field, descending: order.descending);
        } else {
          ref = ref.orderBy(order.field, descending: order.descending);
        }
      }
    }
    if (args != null) {
      for (QueryArgs arg in args) {
        if (ref == null) {
          ref = collref.where(arg.key, isEqualTo: arg.value);
        } else {
          ref = ref.where(arg.key, isEqualTo: arg.value);
        }
      }
    }
    if (ref != null) {
      return ref.snapshots().map((snap) => snap.docs
          .map((doc) => fromDS(doc.id, doc.data() as Map<String, dynamic>))
          .toList());
    } else {
      return collref.snapshots().map((snap) => snap.docs
          .map((doc) => fromDS(doc.id, doc.data() as Map<String, dynamic>))
          .toList());
    }
  }

  Future<List<T>> getListFromTo(String field, DateTime from, DateTime to,
      {List<QueryArgs> args = const []}) async {
    var ref = _db.collection(collection).orderBy(field);
    for (QueryArgs arg in args) {
      ref = ref.where(arg.key, isEqualTo: arg.value);
    }
    QuerySnapshot query = await ref.startAt([from]).endAt([to]).get();
    return query.docs
        .map((doc) => fromDS(doc.id, doc.data() as Map<String, dynamic>))
        .toList();
  }

  Stream<List<T>> streamListFromTo(String field, DateTime from, DateTime to,
      {List<QueryArgs> args = const []}) {
    var ref = _db.collection(collection).orderBy(field, descending: true);
    for (QueryArgs arg in args) {
      ref = ref.where(arg.key, isEqualTo: arg.value);
    }
    var query = ref.startAfter([to]).endAt([from]).snapshots();
    return query.map(
        (snap) => snap.docs.map((doc) => fromDS(doc.id, doc.data())).toList());
  }

  Future<dynamic> createItem(T item, {String? id}) {
    if (id != null) {
      return _db.collection(collection).doc(id).set(item.toJson());
    } else {
      return _db.collection(collection).add(item.toJson());
    }
  }

  // updates an existing entry (missing fields won't be touched on update),
  // document must exist
  Future<void> update(T item) async {
    return await _db
        .collection(collection)
        .doc(item.id)
        .set(item.toJson(), SetOptions(merge: true));
  }

  // updates an existing entry (missing fields won't be touched on update),
  // document must exist
  Future updateByUser(T item) async {
    await _db
        .collection('users')
        .doc(userId)
        .collection(collection)
        .doc(item.id)
        .update(item.toJson());
  }

  Future<void> delete(String id) async {
    return await _db.collection(collection).doc(id).delete();
  }

  Future deleteByUser(String documentId) async {
    await _db
        .collection('users')
        .doc(userId)
        .collection(collection)
        .doc(documentId)
        .delete();
  }
}

class QueryArgs {
  final String key;
  final dynamic value;
  QueryArgs(this.key, this.value);
}

class OrderBy {
  final String field;
  final bool descending;
  OrderBy(this.field, {this.descending = false});
}
