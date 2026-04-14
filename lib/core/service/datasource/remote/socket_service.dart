import 'package:boat_sells_app/core/di/injection.dart';
import 'package:boat_sells_app/core/service/datasource/local/local_service.dart';
import 'package:boat_sells_app/utils/api_urls/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketApi {
  factory SocketApi() {
    return _socketApi;
  }

  SocketApi._internal();

  static io.Socket? _socket;
  static io.Socket? get socket => _socket;

  // ─── Socket Initialization ───────────────────────────────────────────────

  static Future<void> init() async {
    if (_socket != null && _socket!.connected) {
      debugPrint('[Socket] Already connected – skipping init.');
      return;
    }

    final LocalService localService = sl<LocalService>();
    final String token = await localService.getToken();
    if (token.isEmpty || token == 'null') {
      debugPrint('[Socket] No valid token – aborting init.');
      return;
    }

    // Auth is passed via setAuth so the server can verify the JWT.
    _socket = io.io(
      ApiUrls.socketBaseUrl,
      io.OptionBuilder()
          .setTransports(['websocket'])
          .setAuth({'token': token})
          .disableAutoConnect()
          .setReconnectionDelay(2000)
          .setReconnectionAttempts(5)
          .setTimeout(5000)
          .build(),
    );

    _socket?.connect();

    // ── Lifecycle events ───────────────────────────────────────────────────
    _socket?.onConnect((_) {
      debugPrint('[Socket] Connected – id: ${_socket?.id}');
    });

    _socket?.on('connection_confirmed', (data) {
      debugPrint('[Socket] connection_confirmed: $data');
    });

    _socket?.on('error', (dynamic data) {
      debugPrint('[Socket] Server error event: $data');
    });

    _socket?.onError((dynamic error) {
      debugPrint('[Socket] Transport error: $error');
    });

    _socket?.on('unauthorized', (dynamic data) {
      debugPrint('[Socket] Unauthorized: $data');
    });

    _socket?.onDisconnect((dynamic data) {
      debugPrint('[Socket] Disconnected: $data');
      reconnect();
    });

    _socket?.onConnectError((dynamic data) {
      debugPrint('[Socket] Connect error: $data');
    });
  }

  static void reconnect() {
    if (_socket != null && !_socket!.connected) {
      debugPrint('[Socket] Reconnecting...');
      _socket?.connect();
    }
  }

  static void disconnect() {
    _socket?.disconnect();
    _socket = null;
    debugPrint('[Socket] Disconnected and cleared.');
  }

  static final SocketApi _socketApi = SocketApi._internal();
}
