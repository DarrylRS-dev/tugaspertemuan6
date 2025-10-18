import 'package:flutter/material.dart';

class DataPage extends StatelessWidget {
  final String nama;
  final String npm;
  final String email;
  final String alamat;
  final String noHp;
  final String jenisKelamin;
  final String tanggalLahir;
  final String jamBimbingan;

  const DataPage({
    super.key,
    required this.nama,
    required this.npm,
    required this.email,
    required this.alamat,
    required this.noHp,
    required this.jenisKelamin,
    required this.tanggalLahir,
    required this.jamBimbingan,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data Mahasiswa')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Text('Nama: $nama', style: const TextStyle(fontSize: 18)),
                Text('NPM: $npm', style: const TextStyle(fontSize: 18)),
                Text('Email: $email', style: const TextStyle(fontSize: 18)),
                Text('Alamat: $alamat', style: const TextStyle(fontSize: 18)),
                Text('Nomor HP: $noHp', style: const TextStyle(fontSize: 18)),
                Text('Jenis Kelamin: $jenisKelamin',
                    style: const TextStyle(fontSize: 18)),
                Text('Tanggal Lahir: $tanggalLahir',
                    style: const TextStyle(fontSize: 18)),
                Text('Jam Bimbingan: $jamBimbingan',
                    style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Kembali'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
