import 'package:order_entry__diky__listianto/app/http/controllers/auth_controller.dart';
import 'package:order_entry__diky__listianto/app/http/controllers/product_controller.dart';
import 'package:order_entry__diky__listianto/app/http/controllers/user_controller.dart';
import 'package:vania/vania.dart';


class ApiRoute implements Route {
  @override
  void register() {
    Router.basePrefix('api');

    Router.post('/register', AuthController().register);
    Router.post('login', authController.login);
    Router.get('me', userController.index);
    
    Router.get('/products', productController.index);
    Router.get('/products/:id', productController.show);
    Router.post('/products', productController.create);
    Router.put('/products/:id', productController.update);
    Router.delete('/products/:id', productController.destroy);
  }
}
