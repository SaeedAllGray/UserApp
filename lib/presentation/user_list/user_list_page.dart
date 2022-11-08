import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/application/user_list_service.dart';
import 'package:user_app/presentation/user_list/bloc/user_list_bloc.dart';
import 'package:user_app/presentation/user_list/user_details_page.dart';
import 'package:user_app/presentation/user_list/widgets/rounded_dialog.dart';
import '../../src/localization/l10n.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  UserListBloc bloc = UserListBloc();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController textController =
      TextEditingController(text: 'Saeed All Gharae');
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc..add(GetUserListEvent(1)),
      child: Scaffold(
        appBar: AppBar(title: const Text('Users')),
        body: BlocBuilder<UserListBloc, UserListState>(
          builder: (context, state) {
            if (state is UserListNotLoadedState) {
              return const Center(
                child: Text("Users are unavailable!"),
              );
            } else if (state is UserListLoadedState) {
              return Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: state.userList.length,
                  itemBuilder: (context, index) => ListTile(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            UserDetailsPage(user: state.userList[index]),
                      ),
                    ),
                    leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(state.userList[index].avatar)),
                    title: Text(
                        "${state.userList[index].firstName} ${state.userList[index].lastName}"),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  ),
                ),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => showDialog(
              context: context,
              builder: (context) => RoundedDialog(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(context.l10n.newUser),
                      TextField(
                        controller: textController,
                        decoration: InputDecoration(
                          labelText: context.l10n.name,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await UserService.addUser(textController.text);
                          Navigator.pop(context);
                        },
                        child: Text(context.l10n.add),
                      )
                    ],
                  ))),
        ),
      ),
    );
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      bloc
        ..add(ScrollEvent())
        ..add(GetUserListEvent(bloc.pageNumber));
    }
  }
}
