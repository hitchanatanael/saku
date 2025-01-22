import 'package:flutter/material.dart';
import 'package:saku/features/home/widgets/siswa_widget.dart';
import 'package:saku/features/tagihan/controllers/tagihan_controller.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final TagihanController _controller = TagihanController();

  @override
  void initState() {
    super.initState();
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
                        )),
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
                    height: 100,
                    width: double.infinity,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Image.asset(
                        'assets/images/banner.png',
                        fit: BoxFit.fill,
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
                            child: Card(
                              child: Container(
                                width: 100,
                                padding: const EdgeInsets.all(10),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.receipt,
                                      color: Colors.pink,
                                      size: 40,
                                    ),
                                    SizedBox(height: 5),
                                    Text('Tiket',
                                        style: TextStyle(fontSize: 12)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/tagihan');
                            },
                            child: Card(
                              child: Container(
                                width: 100,
                                padding: const EdgeInsets.all(10),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.receipt_long,
                                      color: Colors.purple,
                                      size: 40,
                                    ),
                                    SizedBox(height: 5),
                                    Text('Tagihan',
                                        style: TextStyle(fontSize: 12)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Card(
                            child: Container(
                              width: 100,
                              padding: const EdgeInsets.all(10),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                    color: Colors.blue,
                                    size: 40,
                                  ),
                                  SizedBox(height: 5),
                                  Text('Jadwal',
                                      style: TextStyle(fontSize: 12)),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Card(
                            child: Container(
                              width: 100,
                              padding: const EdgeInsets.all(10),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                    color: Colors.blue,
                                    size: 40,
                                  ),
                                  SizedBox(height: 5),
                                  Text('Jadwal',
                                      style: TextStyle(fontSize: 12)),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Card(
                            child: Container(
                              width: 100,
                              padding: const EdgeInsets.all(10),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                    color: Colors.blue,
                                    size: 40,
                                  ),
                                  SizedBox(height: 5),
                                  Text('Jadwal',
                                      style: TextStyle(fontSize: 12)),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
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
