import 'package:flutter/material.dart';
import 'data_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Mahasiswa',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const FormPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();

  final cNama = TextEditingController();
  final cNpm = TextEditingController();
  final cEmail = TextEditingController();
  final cAlamat = TextEditingController();
  final cNoHp = TextEditingController();

  String? JenisKelamin;
  DateTime? tglLahir;
  TimeOfDay? jamBimbingan;

  @override
  void dispose() {
    cNama.dispose();
    cNpm.dispose();
    cEmail.dispose();
    cAlamat.dispose();
    cNoHp.dispose();
    super.dispose();
  }

  String get tglLahirLabel {
    if (tglLahir == null) return 'Pilih Tanggal Lahir';
    return '${tglLahir?.day}/${tglLahir?.month}/${tglLahir?.year}';
  }

  String get jamLabel {
    if (jamBimbingan == null) return 'Pilih Jam Bimbingan';
    final jam = jamBimbingan?.hour ?? 0;
    final menit = jamBimbingan?.minute ?? 0;
    return '$jam:${menit.toString().padLeft(2, '0')}';
  }

  // 🔹 Fungsi untuk mengirim data ke halaman berikut
  void _kirimData() {
    if (!_formKey.currentState!.validate() ||
        tglLahir == null ||
        jamBimbingan == null ||
        JenisKelamin == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data belum lengkap')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DataPage(
          nama: cNama.text,
          npm: cNpm.text,
          email: cEmail.text,
          alamat: cAlamat.text,
          noHp: cNoHp.text,
          jenisKelamin: JenisKelamin!,
          tanggalLahir: tglLahirLabel,
          jamBimbingan: jamLabel,
        ),
      ),
    );
  }

  // 🔹 Fungsi untuk mereset semua data form
  void _resetData() {
    setState(() {
      cNama.clear();
      cNpm.clear();
      cEmail.clear();
      cAlamat.clear();
      cNoHp.clear();
      JenisKelamin = null;
      tglLahir = null;
      jamBimbingan = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data berhasil direset')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Form Mahasiswa")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: cNama,
                decoration: const InputDecoration(
                  labelText: "Nama",
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (val) =>
                    val == null || val.isEmpty ? "Nama wajib diisi" : null,
              ),
              TextFormField(
                controller: cNpm,
                decoration: const InputDecoration(
                  labelText: "NPM",
                  prefixIcon: Icon(Icons.numbers),
                ),
                validator: (val) =>
                    val == null || val.isEmpty ? "NPM wajib diisi" : null,
              ),
              TextFormField(
                controller: cEmail,
                decoration: const InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (val) => val == null || val.isEmpty
                    ? "Email wajib diisi"
                    : !RegExp(r'^[\w\.-]+@unsika\.ac\.id$').hasMatch(val)
                        ? "Format email tidak valid"
                        : null,
              ),
              TextFormField(
                controller: cAlamat,
                decoration: const InputDecoration(
                  labelText: "Alamat",
                  prefixIcon: Icon(Icons.home),
                ),
                validator: (val) =>
                    val == null || val.isEmpty ? "Alamat wajib diisi" : null,
              ),
              TextFormField(
                controller: cNoHp,
                decoration: const InputDecoration(
                  labelText: "Nomor Telepon",
                  prefixIcon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
                validator: (val) => val == null || val.isEmpty
                    ? "Nomor telepon wajib diisi"
                    : !RegExp(r'^[0-9]+$').hasMatch(val)
                        ? "Nomor telepon hanya boleh angka"
                        : val.length < 10
                            ? "Nomor telepon minimal 10 digit"
                            : null,
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: "Jenis Kelamin"),
                items: const [
                  DropdownMenuItem(value: "Laki-laki", child: Text("Laki-laki")),
                  DropdownMenuItem(value: "Perempuan", child: Text("Perempuan")),
                ],
                onChanged: (String? value) {
                  setState(() {
                    JenisKelamin = value;
                  });
                },
                value: JenisKelamin,
                validator: (val) =>
                    val == null ? "Jenis kelamin wajib diisi" : null,
              ),
              ElevatedButton(
                onPressed: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1990),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    setState(() => tglLahir = picked);
                  }
                },
                child: Text(tglLahirLabel),
              ),
              ElevatedButton(
                onPressed: () async {
                  final picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (picked != null) {
                    setState(() => jamBimbingan = picked);
                  }
                },
                child: Text(jamLabel),
              ),
              const SizedBox(height: 25),

              // 🔹 Tombol Simpan & Lihat Data
              ElevatedButton.icon(
                onPressed: _kirimData,
                icon: const Icon(Icons.save),
                label: const Text('Simpan & Lihat Data'),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),

              const SizedBox(height: 10),

              // 🔹 Tombol Reset Data
              ElevatedButton.icon(
                onPressed: _resetData,
                icon: const Icon(Icons.refresh),
                label: const Text('Reset Data'),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
