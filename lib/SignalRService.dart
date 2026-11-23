import 'dart:async';
import 'package:signalr_netcore/signalr_client.dart';

class SignalRService {
  static final SignalRService _instance = SignalRService._internal();
  late HubConnection _hubConnection;
  final StreamController<String> _messageController = StreamController.broadcast();

  Function()? onMessageReceived;
  bool isPageActive=false;

  factory SignalRService() => _instance;

  SignalRService._internal();

  Stream<String> get messageStream => _messageController.stream;

  HubConnectionState? get connectionState => _hubConnection.state;

  Future<void> initConnection() async {
    final serverUrl = "https://api.appstroke.ir/patientHub";

    _hubConnection = HubConnectionBuilder()
        .withUrl(serverUrl)
        .build();

    _hubConnection.on("ReceivePatientUpdate", _handleIncomingMessage);

    _hubConnection.onclose(({error}) async {
      print("❌ اتصال قطع شد: $error");
      if(isPageActive)
        {
          await _retryConnection();
        }

    });

    await _startConnection();
  }

  Future<void> _startConnection() async {
    try {
      await _hubConnection.start();
      print("✅ اتصال برقرار شد.");
    } catch (e) {
      print("❌ خطا در اتصال اولیه: $e");
    }
  }


  Future<void> disconnect() async {
    if (_hubConnection.state == HubConnectionState.Connected) {
      await _hubConnection.stop();
      print("🔌 SignalR disconnected");
    }
  }

  Future<void> _retryConnection() async {
    const maxAttempts = 5;
    int attempt = 0;

    while (_hubConnection.state != HubConnectionState.Connected && attempt < maxAttempts) {
      attempt++;
      print("🔁 تلاش مجدد برای اتصال... (تلاش $attempt)");
      try {
        await _hubConnection.start();
        print("✅ اتصال مجدد موفق بود.");
      } catch (e) {
        print("❌ تلاش ناموفق: $e");
        await Future.delayed(Duration(seconds: 3));
      }
    }
  }

  void _handleIncomingMessage(List<Object?>? arguments) {
    onMessageReceived?.call();
  }


}
