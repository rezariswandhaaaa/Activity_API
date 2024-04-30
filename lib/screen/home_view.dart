import 'package:activity2/controller/kontak_controller.dart';
import 'package:activity2/model/kontak.dart';
import 'package:activity2/screen/register_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final KontakController _controller = KontakController();

    @override
  void initState() {
    super.initState();
    _controller.getPeople();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Orang"),
      ),
      body: FutureBuilder<List<Kontak>>(
        future: _controller.getPeople(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                Kontak person = snapshot.data![index];
                return ListTile(
                  title: Text(person.nama),
                  subtitle: Text(person.email),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(person.foto),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const RegisterView()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
