import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buku Kontak',
      home: const KontakFormPage(),
    );
  }
}

// Model data satu kontak: nama, email, no HP
class Kontak {
  final String nama;
  final String email;
  final String noHp;

  Kontak({required this.nama, required this.email, required this.noHp});
}

class KontakFormPage extends StatefulWidget {
  const KontakFormPage({super.key});

  @override
  State<KontakFormPage> createState() => _KontakFormPageState();
}

class _KontakFormPageState extends State<KontakFormPage> {
  // List untuk menyimpan semua kontak yang sudah ditambahkan
  List<Kontak> daftarKontak = [];

  // Controller untuk masing-masing form input
  final TextEditingController namaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController noHpController = TextEditingController();

  void _simpanKontak() {
    if (namaController.text.trim().isEmpty) return; // jangan simpan kalau nama kosong

    setState(() {
      daftarKontak.add(
        Kontak(
          nama: namaController.text,
          email: emailController.text,
          noHp: noHpController.text,
        ),
      );
      // Kosongkan form lagi setelah data disimpan
      namaController.clear();
      emailController.clear();
      noHpController.clear();
    });
  }

  @override
  void dispose() {
    namaController.dispose();
    emailController.dispose();
    noHpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buku Kontak'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // ---------- FORM INPUT ----------
            TextField(
              controller: namaController,
              decoration: const InputDecoration(
                labelText: 'Nama Lengkap',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: noHpController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Nomor Handphone',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _simpanKontak,
                child: const Text('Simpan'),
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),

            // ---------- DAFTAR KONTAK ----------
            Expanded(
              child: daftarKontak.isEmpty
                  ? const Center(child: Text('Belum ada kontak tersimpan'))
                  : ListView.builder(
                      itemCount: daftarKontak.length,
                      itemBuilder: (context, index) {
                        final kontak = daftarKontak[index];
                        return Card(
                          child: ListTile(
                            leading: const Icon(Icons.person),
                            title: Text(kontak.nama),
                            subtitle: Text('${kontak.email}\n${kontak.noHp}'),
                            isThreeLine: true,
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}