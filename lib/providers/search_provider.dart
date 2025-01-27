import 'package:bugrani2/services/search_service.dart';
import 'package:flutter/material.dart';

class SearchProvider with ChangeNotifier {
  final SearchService _searchService = SearchService();
  List<dynamic> _searchResults = [];
  bool _isLoading = false;

  List<dynamic> get searchResults => _searchResults;
  bool get isLoading => _isLoading;

  Future<void> searchEmployees(String query) async {
    _isLoading = true;
    notifyListeners();

    _searchResults = await _searchService.searchEmployees(query);

    _isLoading = false;
    notifyListeners();
  }

  void clearResults() {
    _searchResults = [];
    notifyListeners();
  }
}
