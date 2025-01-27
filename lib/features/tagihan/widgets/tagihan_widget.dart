import 'package:flutter/material.dart';
import 'package:saku/features/tagihan/screens/tagihan_detail_screen.dart';

class SiswaWidget extends StatelessWidget {
  const SiswaWidget(
      {super.key,
      required this.siswa,
      required this.foto,
      required this.fotoInstansi});

  final dynamic siswa;
  final dynamic foto;
  final dynamic fotoInstansi;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      child: GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(siswa['nama']),
              duration: const Duration(seconds: 2),
            ),
          );

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TagihanDetailScreen(
                siswa: siswa,
              ),
            ),
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // atas
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: const BoxDecoration(
                    color: Color(0xFF373466), // Warna latar belakang
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.0), // Sudut kiri atas
                      topRight: Radius.circular(12.0), // Sudut kanan atas
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // foto
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding:
                                const EdgeInsets.all(2.0), // Ketebalan border
                            decoration: BoxDecoration(
                              color: Colors.white, // Warna border putih
                              borderRadius: BorderRadius.circular(
                                  22.0), // Radius sudut untuk border
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  20.0), // Radius sudut untuk gambar
                              child: Image.network(
                                fotoInstansi,
                                width: 30,
                                height: 30,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      // foto 2
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius:
                                BorderRadius.circular(20.0), // Radius sudut
                            child: Image.network(
                              foto,
                              width: 30,
                              height: 30,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${siswa['nama']}',
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '${siswa['oncard']['account_number']} | ${siswa['oncard']['nama_instansi']} ',
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // bawah
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12.0),
                      bottomRight: Radius.circular(12.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Tagihan Pendidikan',
                              style: TextStyle(fontSize: 10),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Rp${siswa['tagihan']['belum_bayar']}',
                              style: const TextStyle(fontSize: 10),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Absensi Siswa',
                              style: TextStyle(fontSize: 10),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              '0%',
                              style: TextStyle(fontSize: 10),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Saldo Kartu',
                              style: TextStyle(fontSize: 10),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Rp${siswa['oncard']['balance']}',
                              style: const TextStyle(fontSize: 10),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
