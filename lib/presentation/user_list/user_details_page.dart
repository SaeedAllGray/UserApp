import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:user_app/domain/user/user.dart';

class UserDetailsPage extends StatelessWidget {
  final User user;
  const UserDetailsPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            child: CachedNetworkImage(
              imageUrl: user.avatar,
              fit: BoxFit.fitHeight,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.contact_page),
            title: Text('${user.firstName} ${user.lastName}'),
          ),
          ListTile(
            leading: const Icon(Icons.mail),
            title: Text(user.email),
          ),
        ],
      ),
    );
  }
}
