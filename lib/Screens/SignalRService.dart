import 'package:signalr_netcore/signalr_client.dart';

class SignalRService {
  static final SignalRService _instance = SignalRService._internal();
  late HubConnection _hubConnection;

  factory SignalRService() {
    return _instance;
  }

  SignalRService._internal();

  Future<void> initConnection() async {
    final serverUrl = "https://api.appstrok.ir/patientHub"; // آدرس هاب سیگنال‌ار

    _hubConnection = HubConnectionBuilder()
        .withUrl(serverUrl)
        .build();

    _hubConnection.onclose(({error}) {
      print("❌ Connection Closed: $error");
    });

    _hubConnection.on("ReceivePatientUpdate", _handleIncomingMessage);

    // اتصال به سرور
    await _hubConnection.start()?.then((_) {
      print("✅ SignalR connected");
    }).catchError((e) {
      print("❌ SignalR connect failed: $e");
    });
  }

  void _handleIncomingMessage(List<Object?>? arguments) {
    if (arguments != null && arguments.isNotEmpty) {
      print("📩 Message received: ${arguments.first}");
    }
  }

  Future<void> sendMessage(String user, String message) async {
    try {
      await _hubConnection.invoke("ReceivePatientUpdate", args: [user, message]);
      print("✅ Message sent");
    } catch (e) {
      print("❌ Send failed: $e");
    }
  }
}
