library codecamp_onepay;

import 'package:codecamp_onepay/cc_onepay_qr.dart';
import 'package:pubnub/pubnub.dart';

class CodecampOnepay {
  /// ເລີ່ມຕົ້ນສ້າງ QR
  static String initQR(String mcID, String transactionID, String terminalID,
      int amount, String invoiceID, String description, int expiredMinute,
      {bool? closeWhenPaySuccess}) {
    return CCOnePayQR().generateQR(mcID, transactionID, terminalID, amount,
        invoiceID, description, expiredMinute);
  }

  /// ຕິດຕາມທຸລະກຳວ່າສຳເລັດ ຫຼື ບໍ?
  static Future<void> observe(String subscribeKey, String uuID, String mcID,
      String shopCode, Function(Envelope) onData) async {
    var pubnub = PubNub(
        defaultKeyset: Keyset(subscribeKey: subscribeKey, uuid: UUID(uuID)));

    /// Subscribe to a channel
    var channel = "mcid-$mcID-$shopCode";
    var subscription = pubnub.subscribe(
        channels: {channel},
        keyset: Keyset(subscribeKey: subscribeKey, uuid: UUID(uuID)));

    /// callback from server
    subscription.messages.listen((message) async {
      onData(message);
    });
  }
}
