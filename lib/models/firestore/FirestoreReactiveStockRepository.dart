// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import '../reactive_repository.dart';
// import '../stock.dart';
//
// class FirestoreReactiveStockRepository extends ReactiveStockRepository {
//   static const String path = 'stocks';
//
//   final Firestore firestore;
//
//   FirestoreReactiveStockRepository(this.firestore);
//
//   @override
//   Stream<Stock> stocks() {
// //    var resp = firestore.collection(path)
// //        .where("userId", isEqualTo: "1")
// //        .getDocuments();
//     return null;
//   }
//
//   @override
//   Future<void> updateStock(Stock stock) {
//     return firestore.collection(path).add(stock.toJson());
//   }
// }
