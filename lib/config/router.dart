import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_learning/features/auth/bloc/auth_bloc.dart';
import 'package:flutter_learning/screens/home/home_screen.dart';
import 'package:flutter_learning/screens/login/login_screen.dart';
import 'package:flutter_learning/screens/post_create/post_create_screen.dart';
import 'package:flutter_learning/screens/post_detail/post_detail_screen.dart';
import 'package:flutter_learning/screens/register/register_screen.dart';
import 'package:go_router/go_router.dart';

class RouteName {
  static const String home = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String postCreate = '/posts/create';
  static const String postDetail = '/posts/:id';

  static const publicRoutes = [
    login,
    register,
  ];
}

final router = GoRouter(
  redirect: (context, state) {
    final authState = context.read<AuthBloc>().state;

    if (RouteName.publicRoutes.contains(state.fullPath)) {
      return null;
    }

    if (authState is AuthAuthenticateSuccess) {
      return null;
    }

    return RouteName.login;
  },
  routes: [
    GoRoute(
      path: RouteName.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: RouteName.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: RouteName.register,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: RouteName.postCreate,
      builder: (context, state) => const PostCreateScreen(),
    ),
    GoRoute(
      path: RouteName.postDetail,
      builder: (context, state) => const PostDetailScreen(),
    ),
  ],
);
