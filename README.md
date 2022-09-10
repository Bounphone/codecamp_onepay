<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->
 
codecamp_onepay ແມ່ນ [Flutter](https://flutter.io) package ສຳລັບສ້າງ ແລະ ຕິດຕາມທຸລະກຳຂອງທະນາຄານ.

## Features

- ສ້າງທຸລະກຳ
- ສາມາດຕິດຕາມທຸລະກຳທີ່ສ້າງຂຶ້ນມາໄດ້


## Get started
ສຳລັບ shopcode ແລະ merchantID ທາງທະນາຄານການຄ້ານ (BCEL) ຈະເປັນຄົນກຳນົດໃຫ້


## Installation

add the following code to your `pubspec.yaml` :

```yaml
dependencies:
  codecamp_onepay: ^1.0.0
```

## Usage

ສາມາດນຳໃຊ້ໂຄດຕົວຢ່າງດັ່ງກ່າວໄດ້ເລີຍ

```dart
import 'package:codecamp_onepay/codecamp_onepay.dart';
import 'package:example/success_page.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String transaction = '';
  String qrData = '';
  String mcid = 'mch5c2f0404102fb';
  String shopcode = '12345678';
  String subScribeKey = 'sub-c-91489692-fa26-11e9-be22-ea7c5aada356';
  String uuID = 'BCELBANK';
  int expiredTime = 3; // ຕ້ອງເປັນນາທີ
  String terminalID = '0000';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bcelQR();
  }

  void bcelQR() {
    setState(() {
      transaction = DateTime.now().toString();
      qrData = CodecampOnepay.initQR(mcid, transaction, terminalID, 1,
          'invoiceID-$transaction', 'Codecamp-Payment', expiredTime,
          closeWhenPaySuccess: false);
    });
    CodecampOnepay.observe(subScribeKey, uuID, mcid, shopcode, (message) {
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return SuccessPage();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('CodeCamp OnePay'),
        ),
        body: Center(
          child: qrData.isEmpty
              ? CircularProgressIndicator()
              : Column(
            children: [
              QrImage(
                data: qrData,
                version: QrVersions.auto,
                size: 200.0,
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  onPressed: () {
                    bcelQR();
                  },
                  child: Text('Refresh QR'))
            ],
          ),
        ));
  }
}

```

## Note

- Description ຄວນເປັນພາສາອັງກິດ ແລະ ຫ້າມຍະຫວ່າງ (ຄວນໃຊ້ອັກຄະລະພິເສດແທນເຊັ່ນ: _) ເພື່ອປ້ອງກັນຂໍ້ຜິດພາດທີ່ຈະເກີດຂຶ້ນ 