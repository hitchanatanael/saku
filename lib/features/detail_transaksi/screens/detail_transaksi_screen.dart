import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailTransaksiScreen extends StatefulWidget {
  const DetailTransaksiScreen({super.key});

  @override
  State<DetailTransaksiScreen> createState() => _DetailTransaksiScreenState();
}

class _DetailTransaksiScreenState extends State<DetailTransaksiScreen> {
  final Map<String, dynamic> data = {
    "id": 490,
    "oncard_invoice": "PHNX-4464-20250219-164504911217-INV-BILLER",
    "user_request_id": 171,
    "reference_id": "LkolYbROgt",
    "tagihan_user_id": 794,
    "user_billed_id": 159,
    "is_done": true,
    "status_transaksi": "success",
    "response_payment_gateway": null,
    "trx_types": "default",
    "expired_at": "2025-02-20T10:50:04.000000Z",
    "created_at": "2025-02-19T09:45:04.000000Z",
    "updated_at": "2025-02-20T10:50:04.000000Z",
    "user_request": {
      "id": 171,
      "oncard_user_id": 5173,
      "uuid": "9106f1ca-75aa-48be-b5ca-ff00d771f7fb",
      "user_identity": "ridhohawali3",
      "name": "Ridho Hawali Fani",
      "telepon": null,
      "avatar": null,
      "created_at": "2024-09-23T14:40:19.000000Z",
      "updated_at": "2024-09-23T14:40:19.000000Z"
    },
    "user_billed": {
      "id": 159,
      "oncard_user_id": 1487,
      "uuid": "2254627553017659",
      "user_identity": "user-3CB7A",
      "name": "Preti Epira-MA",
      "telepon": "6285264397615",
      "avatar": null,
      "created_at": "2024-09-23T13:37:00.000000Z",
      "updated_at": "2025-02-21T02:12:09.000000Z"
    },
    "tagihan_user": {
      "id": 794,
      "uuid": "3493363521428113",
      "tagihan_id": 119,
      "organisasi_id": 2,
      "user_id": 159,
      "jumlah_diskon": 0,
      "jumlah_tagihan": 1740000,
      "jumlah_dibayarkan": 1740000,
      "jumlah_belum_dibayarkan": 0,
      "status_pembayaran": "lunas",
      "jenis_user": "siswa",
      "user_info": "110",
      "keterangan": null,
      "noted": null,
      "created_at": "2025-01-04T00:47:51.000000Z",
      "updated_at": "2025-02-20T10:50:04.000000Z",
      "deleted_at": null
    }
  };

  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    return DateFormat('dd MMMM yyyy, HH:mm').format(dateTime);
  }

  String formatCurrency(int amount) {
    final currencyFormatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return currencyFormatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Transaksi'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCard(
              'Status Transaksi',
              [
                _buildInfoRow(
                    'Status',
                    data['status_transaksi'] == 'success'
                        ? 'Berhasil'
                        : data['status_transaksi']),
                _buildInfoRow('Selesai', data['is_done'] ? 'Ya' : 'Tidak'),
                _buildInfoRow('Tanggal Dibuat', formatDate(data['created_at'])),
                _buildInfoRow(
                    'Tanggal Kedaluwarsa', formatDate(data['expired_at'])),
              ],
            ),
            SizedBox(height: 16),
            _buildCard(
              'Informasi Penagih',
              [
                _buildInfoRow('Nama', data['user_request']['name']),
                _buildInfoRow(
                    'ID Pengguna', data['user_request']['user_identity']),
                _buildInfoRow(
                    'Telepon', data['user_request']['telepon'] ?? '-'),
              ],
            ),
            SizedBox(height: 16),
            _buildCard(
              'Informasi Tertagih',
              [
                _buildInfoRow('Nama', data['user_billed']['name']),
                _buildInfoRow('Telepon', data['user_billed']['telepon'] ?? '-'),
              ],
            ),
            SizedBox(height: 16),
            _buildCard(
              'Informasi Tagihan',
              [
                _buildInfoRow('Status',
                    data['tagihan_user']['status_pembayaran'].toUpperCase()),
                _buildInfoRow('Jenis User', data['tagihan_user']['jenis_user']),
                _buildInfoRow('Jumlah Tagihan',
                    formatCurrency(data['tagihan_user']['jumlah_tagihan'])),
                _buildInfoRow('Diskon',
                    formatCurrency(data['tagihan_user']['jumlah_diskon'])),
                _buildInfoRow('Sudah Dibayar',
                    formatCurrency(data['tagihan_user']['jumlah_dibayarkan'])),
                _buildInfoRow(
                    'Sisa Pembayaran',
                    formatCurrency(
                        data['tagihan_user']['jumlah_belum_dibayarkan'])),
                _buildInfoRow(
                    'Keterangan', data['tagihan_user']['keterangan'] ?? '-'),
                _buildInfoRow('Catatan', data['tagihan_user']['noted'] ?? '-'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String title, List<Widget> children) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
            SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
