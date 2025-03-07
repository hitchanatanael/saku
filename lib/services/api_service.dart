import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  // Singleton pattern
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  // Cache duration dalam milidetik (default: 1 jam)
  final int defaultCacheDuration = 3600000;

  // Method untuk menyimpan data ke cache
  Future<void> setCacheData(String url, dynamic data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cacheData = {
        'data': data,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      };
      await prefs.setString(_getCacheKey(url), jsonEncode(cacheData));
    } catch (e) {
      print('Error saving cache: $e');
    }
  }

  // Method untuk mendapatkan data dari cache
  Future<dynamic> getCacheData(String url, {int? cacheDuration}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cacheKey = _getCacheKey(url);

      if (!prefs.containsKey(cacheKey)) return null;

      final cachedDataStr = prefs.getString(cacheKey);
      if (cachedDataStr == null) return null;

      final cachedData = jsonDecode(cachedDataStr);
      final cacheTime = cachedData['timestamp'] as int;
      final currentTime = DateTime.now().millisecondsSinceEpoch;

      // Check if cache is still valid
      final validDuration = cacheDuration ?? defaultCacheDuration;
      if (currentTime - cacheTime <= validDuration) {
        return cachedData['data'];
      }

      return null;
    } catch (e) {
      print('Error getting cache: $e');
      return null;
    }
  }

  // Generate cache key dari URL
  String _getCacheKey(String url) {
    return 'api_cache_${url.hashCode}';
  }

  // Method untuk GET request dengan caching
  Future<dynamic> get(
    String url, {
    Map<String, String>? headers,
    bool forceRefresh = false,
    int? cacheDuration,
  }) async {
    // Jika tidak force refresh, coba ambil dari cache dulu
    if (!forceRefresh) {
      final cachedData = await getCacheData(url, cacheDuration: cacheDuration);
      if (cachedData != null) {
        return cachedData;
      }
    }

    // Jika tidak ada cache atau kadaluarsa, fetch dari API
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Simpan data ke cache
        await setCacheData(url, data);
        return data;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      // Coba ambil data cache lama sebagai fallback jika ada error
      final oldCachedData =
          await getCacheData(url, cacheDuration: double.maxFinite.toInt());
      if (oldCachedData != null) {
        return oldCachedData;
      }
      rethrow;
    }
  }

  // Method untuk menghapus cache tertentu
  Future<void> clearCache(String url) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_getCacheKey(url));
    } catch (e) {
      print('Error clearing cache: $e');
    }
  }

  // Method untuk menghapus semua cache
  Future<void> clearAllCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final keys = prefs.getKeys();
      for (final key in keys) {
        if (key.startsWith('api_cache_')) {
          await prefs.remove(key);
        }
      }
    } catch (e) {
      print('Error clearing all cache: $e');
    }
  }
}
