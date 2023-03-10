import 'package:flutter/cupertino.dart';
import 'package:mothering_business_network/login.dart';
import 'package:mothering_business_network/routes/base.dart';



class Routes {
  Routes._();

  static const login = '/login';
  // static const intro = '/intro';
  // static const signup = '/signup';
  // static const forgotpassword = "/forgotpassword";
  // static const home = "/home";
  // static const profile = "/profile";
  // static const homescreen ="/homescreen";
  // static const driverfound ="/driverfound";

  static Map<String, WidgetBuilder> get buildRoutes {
    return {
      // splashScreen: (BuildContext context) =>
      // const BaseLayout(page: SplashScreen(), isAppBar: false,),
      login: (BuildContext context) =>
      const BaseLayout(page: Login(), isAppBar: false,),
      // driverfound:(BuildContext context) =>
      // const BaseLayout(page: DriverFound(), isAppBar: false,),
      // signup: (BuildContext context) =>
      // const BaseLayout(page: SignupScreen(), isAppBar: false,),
      // forgotpassword: (BuildContext context) =>
      // const BaseLayout(page: ForgotPasswordScreen(), isAppBar: false,),
      // homescreen: (BuildContext context) =>
      // const BaseLayout(page: DraggableSection(), isAppBar: false,),
      // profile: (BuildContext context) =>
      // const BaseLayout(page: HomeScreen(), isAppBar: false,)
    };
  }
}