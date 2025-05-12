import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/Deliverable.dart';
import '../models/Report.dart';
import '../models/Rubric.dart';

class ApiService {
  static const _base = 'https://votre-backend.example.com/api';

  static Future<List<Deliverable>> fetchDeliverables() async {
    final res = await http.get(Uri.parse('$_base/deliverables'));
    return (json.decode(res.body) as List).map((e) => Deliverable.fromJson(e)).toList();
  }
  static Future<List<Report>> fetchReports() async {
    final res = await http.get(Uri.parse('$_base/reports'));
    return (json.decode(res.body) as List).map((e) => Report.fromJson(e)).toList();
  }
  static Future<List<Rubric>> fetchRubrics() async {
    final res = await http.get(Uri.parse('$_base/rubrics'));
    return (json.decode(res.body) as List).map((e) => Rubric.fromJson(e)).toList();
  }
  static Future<void> submitScores() async {
    // POST scores (à implémenter selon votre API)
  }
}