import 'dart:convert';
import 'package:http/http.dart' as http;

class TagihanController {
  Future<List<dynamic>> fetchApi() async {
    final url = Uri.parse(
        'https://api.flashsoftindonesia.com/oncard/api/wali/siswa.php');
    try {
      // Menambahkan Authorization Bearer Token di header
      final response = await http.get(
        url,
        headers: {
          // 'Authorization': 'Bearer $_token', // Token Anda
          'Content-Type': 'application/json', // Jika diperlukan
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // print(data);
        return data;
      } else {
        // print(response);
        throw Exception('Gagal mengambil data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }
}
