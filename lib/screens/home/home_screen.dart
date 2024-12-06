import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_learning/config/router.dart';
import 'package:flutter_learning/features/auth/bloc/auth_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

enum ListItem {
  logout,
  profile,
  settings,
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ListItem? selectedItem;

  void _handleLogout(BuildContext context) {
    context.read<AuthBloc>().add(AuthLogoutStarted());
  }

  void _handleCreatePost(BuildContext context) {
    context.push(RouteName.postCreate);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        switch (state) {
          case AuthLogoutSuccess():
            context.go(RouteName.login);
            break;
          case AuthLogoutFailure(message: final msg):
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text(
                      'Logout Failure',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    content: Text(
                      msg,
                      style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  );
                });
            break;
          default:
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'EXCONNECT',
            style: TextStyle(fontWeight: FontWeight.w900, color: Colors.indigo),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                HugeIcons.strokeRoundedAddCircle,
                color: Colors.indigo,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(HugeIcons.strokeRoundedSearch01,
                  color: Colors.indigo),
            ),
            IconButton(
              onPressed: () {
                _handleLogout(context);
              },
              icon: const Icon(HugeIcons.strokeRoundedLogout01,
                  color: Colors.indigo),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: FilledButton(
                  style: FilledButton.styleFrom(
                      elevation: 0,
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 24)),
                  onPressed: () {
                    _handleCreatePost(context);
                  },
                  child: const Row(
                    children: [
                      Icon(HugeIcons.strokeRoundedPencilEdit01),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        'What happening now!?',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
              const Post(),
            ],
          ),
        ),
      ),
    );
  }
}

class Post extends StatelessWidget {
  const Post({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 2,
          decoration: const BoxDecoration(
            color: Colors.black12,
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset('assets/images/logo.png',
                          height: 50, width: 50),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                        child: Row(
                      children: [
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Nguyễn Hoàng Nam',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                'Người tham gia ẩn danh',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black45),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.more_horiz),
                        )
                      ],
                    ))
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.network(
                      'https://pbs.twimg.com/media/GdfA0Apa8AARrph?format=jpg&name=900x900',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          HugeIcons.strokeRoundedFavourite,
                          color: Colors.black87,
                        ),
                        label: const Text(
                          '123',
                          style: TextStyle(color: Colors.black87),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          HugeIcons.strokeRoundedChatting01,
                          color: Colors.black87,
                        ),
                        label: const Text(
                          '123',
                          style: TextStyle(color: Colors.black87),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          HugeIcons.strokeRoundedBookmark02,
                          color: Colors.black87,
                        ),
                        label: const Text(
                          '123',
                          style: TextStyle(color: Colors.black87),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          HugeIcons.strokeRoundedShare01,
                          color: Colors.black87,
                        ),
                        label: const Text(
                          '123',
                          style: TextStyle(color: Colors.black87),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )),
        Container(
          height: 2,
          decoration: const BoxDecoration(
            color: Colors.black12,
          ),
        ),
      ],
    );
  }
}
