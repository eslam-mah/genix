import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:genix/core/utils/router.dart';
import 'package:genix/features/search%20page/view%20model/search/search_cubit.dart';
import 'package:go_router/go_router.dart';

import '../../users/data/models/user_model.dart';
import 'cubit/create_chat_cubit/create_chat_cubit.dart';

// Cubit to manage the form state
class ConversionStatusCubit extends Cubit<bool> {
  ConversionStatusCubit() : super(true); // By default, Direct Message is selected

  void toggleChat(bool isChat) => emit(isChat);
}

class SelectedUserCubit extends Cubit<List<UserModel>> {
  SelectedUserCubit() : super([]); // By default, Direct Message is selected

  void onSelected(UserModel user) {
    final List<UserModel> selectedUsers = state;
    selectedUsers.add(user);
    emit(selectedUsers);
  }

  void onRemoveUser(UserModel user) {
    final List<UserModel> selectedUsers = state;
    selectedUsers.removeWhere((element) => element.id == user.id);
    emit(selectedUsers);
  }
}

class NewCreateChatScreen extends StatefulWidget {
  const NewCreateChatScreen({Key? key}) : super(key: key);

  @override
  State<NewCreateChatScreen> createState() => _NewCreateChatScreenState();
}

class _NewCreateChatScreenState extends State<NewCreateChatScreen> {
  final SelectedUserCubit _selectedUserCubit = SelectedUserCubit();
  final CreateConversationCubit _createConversationCubit = CreateConversationCubit();
  Timer? _debounce;
  final ConversionStatusCubit _conversionStatusCubit = ConversionStatusCubit();
  final TextEditingController _groupNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateConversationCubit, CreateChatState>(
      bloc: _createConversationCubit,
      listener: (context, createChatState) {
        if (createChatState is CreateChatSuccess) {
          context.pop();
          context.push(Rout.kChatScreen, extra: {'chatRoom': createChatState.createChatRoomResponse.data});
        }
      },
      builder: (context, createChatState) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Create a New Chat and Group'),
          ),
          bottomNavigationBar: BlocBuilder<ConversionStatusCubit, bool>(
            bloc: _conversionStatusCubit,
            builder: (context, isDirectMessage) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 20.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (isDirectMessage) {
                      if (_selectedUserCubit.state.length == 1) {
                        _createConversationCubit.createConversation(type: "dm", userModel: _selectedUserCubit.state);
                      } else {
                        Fluttertoast.showToast(
                          msg: "Please select only one user for Direct Message",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }
                    } else {
                      if (_selectedUserCubit.state.isNotEmpty) {
                        if (_groupNameController.text.isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Please enter group name",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                          return;
                        }
                        _createConversationCubit.createConversation(
                          type: "group",
                          userModel: _selectedUserCubit.state,
                          groupName: _groupNameController.text,
                        );
                      } else {
                        Fluttertoast.showToast(
                          msg: "Please select atleast one user for Group",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }
                      // Group
                    }
                  },
                  child: createChatState is CreateChatLoading
                      ? const SizedBox(
                          height: 50,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ],
                          ),
                        )
                      : const Text(
                          'Create Chat',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                ),
              );
            },
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<ConversionStatusCubit, bool>(
                  bloc: _conversionStatusCubit,
                  builder: (context, isDirectMessage) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _conversionStatusCubit.toggleChat(true);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isDirectMessage ? Colors.green : Colors.grey,
                          ),
                          child: const Text(
                            'Direct message',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton(
                            onPressed: () {
                              _conversionStatusCubit.toggleChat(false);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: !isDirectMessage ? Colors.green : Colors.grey,
                            ),
                            child: const Text(
                              'Group',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 20),
                BlocBuilder<ConversionStatusCubit, bool>(
                  bloc: _conversionStatusCubit,
                  builder: (context, isDirectMessage) {
                    if (isDirectMessage) {
                      return SearchUserField(
                        selectedUserCubit: _selectedUserCubit,
                        conversionType: "direct",
                      ); // Show search field for Direct Message
                    } else {
                      return GroupCreationFields(
                        selectedUserCubit: _selectedUserCubit,
                        groupNameController: _groupNameController,
                      ); // Show group creation fields
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Widget to search users (for both Direct Message and Group creation)
class SearchUserField extends StatefulWidget {
  final SelectedUserCubit selectedUserCubit;
  final String? conversionType;

  const SearchUserField({Key? key, required this.selectedUserCubit, this.conversionType}) : super(key: key);

  @override
  State<SearchUserField> createState() => _SearchUserFieldState();
}

class _SearchUserFieldState extends State<SearchUserField> {
  Timer? _debounce;
  final SearchCubit _searchCubit = SearchCubit();
  late SelectedUserCubit _selectedUserCubit;

  @override
  void initState() {
    _selectedUserCubit = widget.selectedUserCubit;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Search User"),
          const SizedBox(height: 10),
          TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter user name',
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (value) {
              if (_debounce?.isActive ?? false) _debounce?.cancel();
              _debounce = Timer(const Duration(milliseconds: 500), () {
                _searchCubit.searchByUser(query: value);
                // do something with query
              });
            },
          ),
          Expanded(
            child: BlocBuilder<SearchCubit, SearchState>(
              bloc: _searchCubit,
              builder: (context, state) {
                if (state is SearchByUserLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is SearchByUserError) {
                  return const Center(child: Text('Something went wrong'));
                } else if (state is SearchByUserSuccess) {
                  if (widget.conversionType == "direct" && _selectedUserCubit.state.isNotEmpty) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: ListTile(
                        trailing: Checkbox(
                          value: _selectedUserCubit.state.any((element) => element.id == _selectedUserCubit.state.first.id),
                          onChanged: (value) {
                            if (value == false) {
                              _selectedUserCubit.onRemoveUser(_selectedUserCubit.state.first);
                            }
                            setState(() {});
                          },
                        ),
                        leading: Column(
                          children: [
                            SizedBox(
                              height: 55,
                              width: 55,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: _selectedUserCubit.state.first.profileImg ?? "",
                                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) => Container(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.grey,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.person,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        title: Text(_selectedUserCubit.state.first.showname ?? ""),
                      ),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.users.data.collection.length,
                    itemBuilder: (context, index) {
                      if (widget.conversionType == "direct" && _selectedUserCubit.state.isNotEmpty) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: ListTile(
                            trailing: Checkbox(
                              value: _selectedUserCubit.state.any((element) => element.id == _selectedUserCubit.state.first.id),
                              onChanged: (value) {
                                if (value == true) {
                                  // _selectedUserCubit.onSelected();
                                } else {
                                  _selectedUserCubit.onRemoveUser(_selectedUserCubit.state.first);
                                }
                                setState(() {});
                              },
                            ),
                            leading: Column(
                              children: [
                                SizedBox(
                                  height: 55,
                                  width: 55,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: state.users.data.collection[index].profileImg ?? "",
                                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                      errorWidget: (context, url, error) => Container(
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.grey,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.person,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            title: Text(state.users.data.collection[index].showname ?? ""),
                          ),
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ListTile(
                          trailing:
                              // widget.conversionType == "direct" && _selectedUserCubit.state.isEmpty
                              //     ?
                              Checkbox(
                            value: _selectedUserCubit.state.any((element) => element.id == state.users.data.collection[index].id),
                            onChanged: (value) {
                              if (value == true) {
                                _selectedUserCubit.onSelected(state.users.data.collection[index]);
                              } else {
                                _selectedUserCubit.onRemoveUser(state.users.data.collection[index]);
                              }
                              setState(() {});
                            },
                          ),
                          // : null,
                          leading: Column(
                            children: [
                              SizedBox(
                                height: 55,
                                width: 55,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: state.users.data.collection[index].profileImg ?? "",
                                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) => Container(
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.grey,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.person,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          title: Text(state.users.data.collection[index].showname ?? ""),
                        ),
                      );
                    },
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Widget to display Group creation fields
class GroupCreationFields extends StatelessWidget {
  final SelectedUserCubit selectedUserCubit;
  final TextEditingController groupNameController;

  const GroupCreationFields({Key? key, required this.selectedUserCubit, required this.groupNameController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Group Name"),
          const SizedBox(height: 10),
          TextField(
            controller: groupNameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter group name',
            ),
          ),
          const SizedBox(height: 20),
          const Text("Search and Add Members"),
          const SizedBox(height: 10),
          SearchUserField(
            selectedUserCubit: selectedUserCubit,
          ),
        ],
      ),
    );
  }
}
