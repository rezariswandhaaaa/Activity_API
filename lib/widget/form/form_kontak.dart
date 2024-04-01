import 'dart:io';

import 'package:activity2/controller/kontak_controller.dart';
import 'package:activity2/model/kontak.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FormKontak extends StatefulWidget {
  const FormKontak({super.key});

  @override
  State<FormKontak> createState() => _FormKontakState();
}

class _FormKontakState extends State<FormKontak> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _alamatController = TextEditingController();
  final _noTeleponController = TextEditingController();

  File? _image;
  final _imagePicker = ImagePicker();

  Future<void> getImage() async {
    final XFile? pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("No image selected");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  controller: _namaController,
                  decoration: const InputDecoration(
                    labelText: "Nama",
                    hintText: "Masukkan Nama",
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    hintText: "Masukkan Email",
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: _alamatController,
                  decoration: const InputDecoration(
                    labelText: "Alamat",
                    hintText: "Masukkan Alamat",
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: _noTeleponController,
                  decoration: const InputDecoration(
                    labelText: "Nomor Telepon",
                    hintText: "Masukkan Nomor Telepon",
                  ),
                ),
              ),
              _image == null
                  ? const Text("Tidak ada gambar yang dipilih")
                  : Image.file(_image!),
              ElevatedButton(
                onPressed: getImage,
                child: const Text("Pilih Gambar"),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        var result = await KontakController().addPerson(
                          Kontak(
                              nama: _namaController.text,
                              email: _emailController.text,
                              alamat: _alamatController.text,
                              telepon: _noTeleponController.text,
                              foto: _image!.path),
                          _image,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              result['message'],
                            ),
                          ),
                        );
                      }
                    },
                    child: Text("Simpan")),
              )
            ],
          ),
        ));
  }
}
