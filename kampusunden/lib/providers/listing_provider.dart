import 'package:flutter/material.dart';
import '../models/listing_model.dart';
import '../services/listing_service.dart';

class ListingProvider with ChangeNotifier {
  final ListingService _listingService = ListingService();

  Stream<List<ListingModel>> get listingsStream => _listingService.getListings();

  Stream<List<ListingModel>> userListingsStream(String userId) {
    return _listingService.getUserListings(userId);
  }

  Future<void> addListing(ListingModel listing) async {
    await _listingService.addListing(listing);
  }

  Future<void> deleteListing(String id) async {
    await _listingService.deleteListing(id);
  }
}
