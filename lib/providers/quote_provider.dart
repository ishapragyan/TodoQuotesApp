import 'package:flutter/material.dart';
import '../services/quote_service.dart';

class QuoteProvider extends ChangeNotifier {

  final QuoteService _quoteService = QuoteService();

  String quote = "Loading motivation...";
  String author = "";

  bool isLoading = false;

  Future<void> fetchQuote() async {

    isLoading = true;
    notifyListeners();

    try {

      final data = await _quoteService.fetchQuote();

      quote = data["quote"]!;
      author = data["author"]!;

    } catch (e) {

      quote = "Stay positive and keep working hard!";
      author = "";

    }

    isLoading = false;
    notifyListeners();
  }
}