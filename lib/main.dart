import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

void main() {
  Get.put(RegisterController());
  Get.put(LoginController());
  Get.put(HomeController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RegisterScreen(),
    );
  }
}

class RegisterScreen extends GetWidget<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Center(
                  child: Text(
                    'REGISTER'.toUpperCase(),
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: controller.nameController,
                style: TextStyle(color: Colors.black, height: 0.5),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.account_circle_outlined),
                  hintText: 'Nama',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: controller.emailController,
                  style: TextStyle(color: Colors.black, height: 0.5),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: TextField(
                  controller: controller.passwordController,
                  style: TextStyle(color: Colors.black, height: 0.5),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.vpn_key),
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(32),
                      ),
                    ),
                  ),
                  obscureText: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: TextField(
                  controller: controller.confirmPasswordController,
                  style: TextStyle(color: Colors.black, height: 0.5),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.vpn_key),
                    hintText: 'Konfirmasi Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(32),
                      ),
                    ),
                  ),
                  obscureText: true,
                ),
              ),
              SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(
                      Size(330, 50),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                  ),
                  onPressed: () => controller.registerUser(),
                  child: Text('Register', style: TextStyle(fontSize: 16)),
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('sudah punya akun?'),
                  TextButton(
                    onPressed: () {
                      Get.to(LoginScreen());
                    },
                    child: Text('login'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  Future<void> registerUser() async {
    final url =
        'https://book-crud-service-6dmqxfovfq-et.a.run.app/api/register';
    final dio = Dio();
    try {
      final response = await dio.post(
        url,
        options: Options(headers: {'Accept': 'application/json'}),
        data: {
          'name': nameController.text,
          'email': emailController.text,
          'password': passwordController.text,
          'password_confirmation': confirmPasswordController.text,
        },
      );

      if (response.statusCode == 200) {
        // Registrasi berhasil
        Get.snackbar('Registrasi berhasil', 'Registrasi berhasil.');
      } else {
        // Registrasi gagal
        Get.snackbar('Registrasi gagal', 'Registrasi gagal: ${response.data}');
      }
    } catch (e) {
      // Error saat melakukan request
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    }
  }
}

class LoginScreen extends GetWidget<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: controller.emailController,
              style: TextStyle(color: Colors.black, height: 0.5),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
                hintText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: TextField(
                controller: controller.passwordController,
                style: TextStyle(color: Colors.black, height: 0.5),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.vpn_key),
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(32),
                    ),
                  ),
                ),
                obscureText: true,
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(
                  Size(330, 50),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
              ),
              onPressed: () => controller.loginUser(),
              child: Text('Login', style: TextStyle(fontSize: 16)),
            ),
            SizedBox(
              height: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Belum punya akun?'),
                TextButton(
                  onPressed: () {
                    Get.to(RegisterScreen());
                  },
                  child: Text('Register'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> loginUser() async {
    final url = 'https://book-crud-service-6dmqxfovfq-et.a.run.app/api/login';
    final dio = Dio();
    try {
      final response = await dio.post(
        url,
        options: Options(headers: {'Accept': 'application/json'}),
        data: {
          'email': emailController.text,
          'password': passwordController.text,
        },
      );

      if (response.statusCode == 200) {
        // Login berhasil
        print('Login berhasil');
        Get.offAll(HomeScreen());
      } else {
        // Login gagal
        print('Login gagal: ${response.data}');
        Get.dialog(
          AlertDialog(
            title: Text('Login Gagal'),
            content: Text('Email atau password salah. Silakan coba lagi.'),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      // Error saat melakukan request
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    }
  }
}

class HomeScreen extends GetWidget<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => controller.logoutUser(),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: FractionallySizedBox(
              widthFactor: 0.7,
              child: Text(
                'Selamat datang di Halaman Beranda!',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeController extends GetxController {
  Future<void> logoutUser() async {
    final url =
        'https://book-crud-service-6dmqxfovfq-et.a.run.app/api/user/logout';
    final dio = Dio();
    final token = '105|Ay4M213hamo3N1xlUpcM9Q7DJb9HGvus4A9YknXN';

    try {
      final response = await dio.delete(
        url,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        // Logout berhasil
        print('Logout berhasil');
        Get.offAll(LoginScreen());
      } else {
        // Logout gagal
        print('Logout gagal: ${response.data}');
        Get.dialog(
          AlertDialog(
            title: Text('Logout Gagal'),
            content:
                Text('Gagal melakukan logout. Pastikan token telah diperbarui'),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      // Error saat melakukan request
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: $e',
      );
    }
  }
}
