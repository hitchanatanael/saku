import 'dart:async';
import 'package:flutter/material.dart';
import 'package:saku/features/home/widgets/siswa_widget.dart';
import 'package:saku/features/tagihan/controllers/tagihan_controller.dart';
import 'package:shimmer/shimmer.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:saku/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TagihanController _controller = TagihanController();
  late StreamSubscription<RemoteMessage> _messageSubscription;

  @override
  void initState() {
    super.initState();
    _messageSubscription = messageStreamController.listen((message) {
      Get.snackbar(
        message.notification?.title ?? 'New Message',
        message.notification?.body ?? 'You have a new message',
      );
    });
  }

  @override
  void dispose() {
    _messageSubscription.cancel();
    super.dispose();
  }

  FutureBuilder<List<dynamic>> viewApi() {
    return FutureBuilder<List<dynamic>>(
      future: _controller.fetchApi(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              children: List.generate(5, (index) {
                return const SizedBox(
                  width: double.infinity,
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    color: Colors.green,
                    child: Padding(
                      padding: EdgeInsets.all(50),
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              }),
            ),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Error : ${snapshot.error}'),
          );
        }

        if (snapshot.hasData) {
          final data = snapshot.data!;

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final siswa = (data[index]['siswa']);

              var fotoUrl =
                  'https://saku.oncard.id/assets_oncard/images/bg_new6.jpg';

              return SiswaWidget(
                  siswa: siswa, foto: fotoUrl, fotoInstansi: fotoUrl);
            },
          );
        }

        return const Center(child: Text('No data available'));
      },
    );
  }

  AppBar sectionAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFF373466),
      leading: IconButton(
        icon: const Icon(Icons.menu), // Icon di kiri
        color: Colors.white,
        onPressed: () {},
      ),
      title: const Text('Home', style: TextStyle(color: Colors.white)),
      actions: const [
        Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(
              Icons.person,
              color: Colors.white,
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: sectionAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // section info
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Card(
                    color: Colors.green,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Image.asset(
                        'assets/images/User.png',
                        height: 25,
                        width: 25,
                        color: Colors.white,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selamat Datang', // Menampilkan data yang dimuat
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Hello World', // Menampilkan data yang dimuat
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Banner'),
                  SizedBox(
                    height: 75,
                    width: double.infinity,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          'assets/images/banner.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Icon Apps'),
                  SizedBox(
                    height: 100,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Hello World'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  color: Color(0xFFe3f2fe),
                                  child: Container(
                                    width: 60,
                                    padding: const EdgeInsets.all(2),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(2),
                                          child: Image.asset(
                                            'assets/images/invoice.png',
                                            height: 55,
                                            width: 50,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  'Biaya Pendidikan',
                                  style: TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 25),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/tagihan');
                            },
                            child: Column(
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  color: Color(0xFFe3f2fe),
                                  child: Container(
                                    width: 60,
                                    padding: const EdgeInsets.all(2),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(2),
                                          child: Image.asset(
                                            'assets/images/smartphone.png',
                                            height: 55,
                                            width: 48,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  'Cashless',
                                  style: TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 25),
                          Column(
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                color: Color(0xFFe3f2fe),
                                child: Container(
                                  width: 60,
                                  padding: const EdgeInsets.all(2),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(2),
                                        child: Image.asset(
                                          'assets/images/calendar.png',
                                          height: 55,
                                          width: 50,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                'Absensi',
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 25),
                          Column(
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                color: Color(0xFFe3f2fe),
                                child: Container(
                                  width: 60,
                                  padding: const EdgeInsets.all(2),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(2),
                                        child: Image.asset(
                                          'assets/images/exam-time.png',
                                          height: 55,
                                          width: 50,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                'UTS / UAS',
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 25),
                          Column(
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                color: Color(0xFFe3f2fe),
                                child: Container(
                                  width: 60,
                                  padding: const EdgeInsets.all(2),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(2),
                                        child: Image.asset(
                                          'assets/images/setting.png',
                                          height: 55,
                                          width: 50,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                'Pengaturan',
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Informasi'),
                  viewApi(), // Tambahkan ini
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
