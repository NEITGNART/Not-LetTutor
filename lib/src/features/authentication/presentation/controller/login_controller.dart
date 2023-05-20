import 'package:beatiful_ui/src/features/authentication/data/model/user_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../route/app_route.dart';
import '../../../../utils/hive.dart';
import '../../data/model/user.dart';
import '../../service/auth_functions.dart';

class LoginPageController extends GetxController {
  late Box<AuthUser> userBox;
  var isSuccess = false.obs;
  var message = ''.obs;
  var isLoading = false.obs;
  late Rx<AuthUser?> authUser;
  // get isLogin => authUser.value != null;
  // get auth => authUser.value;
  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<AuthUser?> init() async {
    userBox = await HiveBoxes().openBox<AuthUser>('auth_user');
    authUser = Rx<AuthUser?>(null);
    authUser.value = userBox.get('auth_user', defaultValue: null);
    return authUser.value;
  }

  Future<void> logout() async {
    await userBox.delete('auth_user');
    authUser.value = null;
  }

  updateUser(String avatar, String name, String email) {
    // check if avatar is the same
    if (avatar == authUser.value?.avatar) {
      authUser.update((val) {
        val?.name = name;
        val?.email = email;
      });
      return;
    }

    authUser.update((val) {
      val?.avatar = avatar;
      val?.name = name;
      val?.email = email;
    });
    userBox.put('auth_user', authUser.value!);
  }

  void handleSignInGoogle(BuildContext context) async {
    try {
      isLoading.value = true;
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final String? accessToken = googleAuth?.accessToken;

      if (accessToken != null) {
        final response =
            await AuthFunctions.loginWithGoogle(accessToken, (AuthUser user) {
          userBox.put('auth_user', user);
          authUser.value = user;
        });
        if (response['isSuccess'] == false) {
          isSuccess.value = response['isSuccess'] as bool;
          message.value = response['message'] as String;
        } else {
          isSuccess.value = true;
          message.value = 'Login successfully';
          context.goNamed(AppRoute.home.name);
        }
      }
    } catch (e) {
      isSuccess.value = false;
      message.value = e.toString();
    }
    isLoading.value = false;
  }

  void handleSignInFacebook(BuildContext context) async {
    try {
      isLoading.value = true;
      final facebookAuth = FacebookAuth.instance;
      final LoginResult result = await facebookAuth.login();
      if (result.status == LoginStatus.success) {
        final String accessToken = result.accessToken!.token;
        final response =
            await AuthFunctions.loginWithFacebook(accessToken, (AuthUser user) {
          userBox.put('auth_user', user);
          authUser.value = user;
        });
        if (response['isSuccess'] == false) {
          isSuccess.value = response['isSuccess'] as bool;
          message.value = response['message'] as String;
        } else {
          isSuccess.value = true;
          message.value = 'Login successfully';
          context.goNamed(AppRoute.home.name);
        }
      } else {
        isSuccess.value = false;
        message.value = result.message!;
      }
    } catch (e) {
      isSuccess.value = false;
      message.value = e.toString();
    }
    isLoading.value = false;
  }

  Future<void> refreshAuth(BuildContext context, AuthUser auth) async {
    try {
      isLoading.value = true;
      var response =
          await AuthFunctions.refreshAuth(auth.refreshToken!, (AuthUser user) {
        userBox.put('auth_user', user);
        authUser.value = user;
      });
      if (response['isSuccess'] == false) {
        isSuccess.value = response['isSuccess'] as bool;
        message.value = response['message'] as String;
      } else {
        isSuccess.value = true;
        message.value = 'Login successfully';
      }
    } catch (e) {
      isSuccess.value = false;
      message.value = e.toString();
    }
    isLoading.value = false;
  }

  void handleSignIn(BuildContext context, User user) async {
    try {
      isLoading.value = true;
      var response = await AuthFunctions.login(user, (AuthUser user) {
        userBox.put('auth_user', user);
        authUser.value = user;
      });
      if (response['isSuccess'] == false) {
        isSuccess.value = response['isSuccess'] as bool;
        message.value = response['message'] as String;
      } else {
        isSuccess.value = true;
        message.value = 'Login successfully';
        context.goNamed(AppRoute.home.name);
      }
    } catch (e) {
      isSuccess.value = false;
      message.value = e.toString();
    }
    isLoading.value = false;
  }
}
