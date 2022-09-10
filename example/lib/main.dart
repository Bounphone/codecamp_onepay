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
