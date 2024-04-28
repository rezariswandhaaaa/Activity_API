import 'dart:io';

import 'package:activity2/controller/kontak_controller.dart';
import 'package:activity2/model/kontak.dart';
import 'package:activity2/screen/home_view.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FormKontak extends StatefulWidget {
  const FormKontak({super.key});

  @override
  State<FormKontak> createState() => _FormKontakState();
}

class _FormKontakState extends State<FormKontak> {
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _alamatController = TextEditingController();
  final _noTeleponController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  File? _image;
  final _imagePicker = ImagePicker();

  Future<void> getImage() async {
    final XFile? pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    setState(
      () {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print("No image selected");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(10),
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  controller: _namaController,
                  decoration: const InputDecoration(
                    labelText: "Nama",
                    hintText: "Masukkan Nama",
                    prefixIcon: Icon(Icons.account_box),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter some Name';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  decoration: const InputDecoration(
                      labelText: "Email",
                      hintText: "Masukkan Email",
                      prefixIcon: Icon(Icons.add_box)),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter some Email';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _alamatController,
                  decoration: const InputDecoration(
                      labelText: "Alamat",
                      hintText: "Masukkan Alamat",
                      prefixIcon: Icon(Icons.add_home_work)),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter some Address';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: _noTeleponController,
                  decoration: const InputDecoration(
                      labelText: "Nomor Telepon",
                      hintText: "Masukkan Nomor Telepon",
                      prefixIcon: Icon(Icons.add_call)),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter some Number';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 15,),
              _image == null
                  ? const Text("Tidak ada gambar yang dipilih")
                  : Image.file(_image!),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: getImage,
                child: const Text("Pilih Gambar"),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
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
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeView()),
                          (route) => false,
                        );
                      }
                    },
                    child: const Text("Submit")),
              )
            ],
          ),
        ));
  }
}
