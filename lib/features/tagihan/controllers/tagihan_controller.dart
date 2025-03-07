import 'package:saku/services/api_service.dart';

class TagihanController {
  final ApiService _apiService = ApiService(); // Instance dari service

  Future<List<dynamic>> fetchApi() async {
    final url = Uri.parse(
        'https://api.flashsoftindonesia.com/oncard/api/wali/siswa.php');

    try {
      // Menggunakan API service dengan caching
      final data = await _apiService.get(
        url.toString(),
        headers: {
          // 'Authorization': 'Bearer $_token', // Uncomment jika perlu
          'Content-Type': 'application/json', // Jika diperlukan
        },
        // Defaultnya tidak force refresh, gunakan cache jika ada dan valid
        forceRefresh: false,
        // Tentukan durasi cache dalam ms (optional, default 1 jam)
        cacheDuration: 3600000,
      );

      return data;
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  // Tambahkan method untuk force refresh (berguna untuk fitur pull-to-refresh)
  Future<List<dynamic>> refreshData() async {
    final url = Uri.parse(
        'https://api.flashsoftindonesia.com/oncard/api/wali/siswa.php');

    try {
      // Force refresh, abaikan cache
      final data = await _apiService.get(
        url.toString(),
        headers: {
          // 'Authorization': 'Bearer $_token', // Uncomment jika perlu
          'Content-Type': 'application/json', // Jika diperlukan
        },
        forceRefresh: true, // Force ambil data baru dari API
      );

      return data;
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }
}
