import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/listing_model.dart';

class ListingService {
  final CollectionReference _listingsCollection = FirebaseFirestore.instance.collection('listings');

  Future<void> addListing(ListingModel listing) async {
    await _listingsCollection.doc(listing.id).set(listing.toMap());
  }

  Future<void> deleteListing(String id) async {
    await _listingsCollection.doc(id).delete();
  }

  Stream<List<ListingModel>> getListings() {
    return _listingsCollection.orderBy('createdAt', descending: true).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return ListingModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  Stream<List<ListingModel>> getUserListings(String userId) {
    return _listingsCollection
        .where('createdBy', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ListingModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }
}
