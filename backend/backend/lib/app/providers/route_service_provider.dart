import 'package:vania/vania.dart';
import 'package:order_entry__diky__listianto/route/api_route.dart';
import 'package:order_entry__diky__listianto/route/web.dart';
import 'package:order_entry__diky__listianto/route/web_socket.dart';

class RouteServiceProvider extends ServiceProvider {
  @override
  Future<void> boot() async {}

  @override
  Future<void> register() async {
    WebRoute().register();
    ApiRoute().register();
    WebSocketRoute().register();
  }
}
