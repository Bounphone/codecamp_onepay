class CCOnePayQR{
  String _addZero(int value) {
    return value >= 9 ? value.toString() : '0$value';
  }

  String _genQR(List<dynamic> data){
    String qr = '';
    for (var i = 0; i < data.length; i++) {
      String _key = '${data[i]['k']}';
      String _value = '${data[i]['v']}';
      int valueLength = _value.length;
      qr = qr + _addZero(int.parse(_key)) + _addZero(valueLength) + _value;
    }
    return qr;
  }

  /// ເລີ່ມຕົ້ນສ້າງ QR
  String generateQR(String mcID, String transactionID, String terminalID,
      int amount, String invoiceID, String description, int expiredMinute,
      {bool? closeWhenPaySuccess}) {

    const mcc = '5734';
    const ccy = 418;
    const country = 'LA';
    const province = 'VTE';

    var field33 = [
      {"k": 0, "v": 'BCEL'},
      {"k": 1, "v": 'ONEPAY'},
      {"k": 2, "v": mcID}
    ];

    /// ຕ້ອງການທີ່ຈະປິດແອັບ BCEL One ເມື່ອຊຳລະເງິນສຳເລັດ ຫຼື ບໍ? (Default = true)
    if (closeWhenPaySuccess ?? true) {
      field33.add(
        {"k": 05, "v": 'CLOSEWHENDONE'},
      );
    }
    var field62 = [
      {"k": 1, "v": invoiceID},
      {"k": 5, "v": transactionID},
      {"k": 7, "v": terminalID},
      {"k": 8, "v": description}
    ];

    var qrData = [
      {"k": 0, "v": '01'},
      {"k": 1, "v": '11'},
      {"k": 33, "v": _genQR(field33)},
      {"k": 52, "v": mcc},
      {"k": 53, "v": ccy},
      {"k": 54, "v": amount},
      {"k": 58, "v": country},
      {"k": 60, "v": province},
      {"k": 62, "v": _genQR(field62)}
    ];
    return _genQR(qrData);
  }
}