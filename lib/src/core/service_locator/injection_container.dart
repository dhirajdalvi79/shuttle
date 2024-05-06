import 'package:get_it/get_it.dart';
import 'package:shuttle/src/features/auth_and_user/domain/usecases/get_all_contacts.dart';
import 'package:shuttle/src/features/auth_and_user/domain/usecases/get_all_users.dart';
import 'package:shuttle/src/features/auth_and_user/presentation/bloc/add_to_contact_bloc/add_to_contact_bloc.dart';
import 'package:shuttle/src/features/chat/data/data_sources/chat_remote_data_source.dart';
import 'package:shuttle/src/features/chat/data/repositories/chat_repository_implementation.dart';
import 'package:shuttle/src/features/chat/domain/repositories/chat_repository.dart';
import 'package:shuttle/src/features/chat/domain/usecases/delete_messages.dart';
import 'package:shuttle/src/features/chat/domain/usecases/get_chats.dart';
import 'package:shuttle/src/features/chat/domain/usecases/get_latest_message.dart';
import 'package:shuttle/src/features/chat/domain/usecases/get_messages.dart';
import 'package:shuttle/src/features/chat/domain/usecases/get_number_of_unread_messages.dart';
import 'package:shuttle/src/features/chat/domain/usecases/get_user_name_and_profile_url.dart';
import 'package:shuttle/src/features/chat/presentation/bloc/latest_message_bloc/latest_message_bloc.dart';
import 'package:shuttle/src/features/chat/presentation/bloc/number_of_message_bloc/number_of_message_bloc.dart';
import 'package:shuttle/src/features/chat/presentation/bloc/send_message_bloc/send_message_bloc.dart';
import 'package:shuttle/src/features/chat/presentation/bloc/username_and_profile_image_url_bloc/username_and_profile_image_url_bloc.dart';
import 'package:shuttle/src/features/chat/presentation/bloc/chat_list_bloc/chat_list_bloc.dart';
import 'package:shuttle/src/features/chat/presentation/cubit/message_status_update_cubit/message_status_update_cubit.dart';
import 'package:shuttle/src/firebase_backend/chat/chat_remote_data_source_implementation.dart';
import '../../features/auth_and_user/data/data_sources/auth_and_user_remote_data_source.dart';
import '../../features/auth_and_user/data/repositories/auth_and_user_repository_implementation.dart';
import '../../features/auth_and_user/domain/repositories/auth_and_user_repository.dart';
import '../../features/auth_and_user/domain/usecases/add_to_contact.dart';
import '../../features/auth_and_user/domain/usecases/contact_exists.dart';
import '../../features/auth_and_user/domain/usecases/login.dart';
import '../../features/auth_and_user/domain/usecases/logout.dart';
import '../../features/auth_and_user/domain/usecases/signup.dart';
import '../../features/auth_and_user/presentation/bloc/all_users_bloc/all_users_bloc.dart';
import '../../features/auth_and_user/presentation/bloc/auth_bloc/auth_bloc.dart';
import '../../features/auth_and_user/presentation/bloc/contact_exists_bloc/contact_exists_bloc.dart';
import '../../features/auth_and_user/presentation/bloc/get_contacts_bloc/get_contacts_bloc.dart';
import '../../features/chat/domain/usecases/chat_status_update.dart';
import '../../features/chat/domain/usecases/get_app_user.dart';
import '../../features/chat/domain/usecases/get_user_chat_status.dart';
import '../../features/chat/domain/usecases/message_status_update.dart';
import '../../features/chat/domain/usecases/send_message.dart';
import '../../features/chat/presentation/bloc/chat_messages_bloc/chat_messages_bloc.dart';
import '../../features/chat/presentation/bloc/chat_status_update_bloc/chat_status_update_bloc.dart';
import '../../features/chat/presentation/bloc/get_app_user_bloc/get_app_user_bloc.dart';
import '../../features/chat/presentation/bloc/get_user_chat_status_bloc/get_user_chat_status_bloc.dart';
import '../../features/chat/presentation/cubit/message_selection_mode_cubit/message_selection_mode_cubit.dart';
import '../../features/chat/presentation/cubit/select_messages_cubit/select_messages_cubit.dart';
import '../../firebase_backend/authentication/auth_and_user_remote_data_source_implementaion.dart';
import '../../firebase_backend/firebase_initialize.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _initAuth();
  await _initChat();
}

Future<void> _initAuth() async {
  sl
    ..registerFactory(() => AuthBloc(login: sl(), signUp: sl(), logOut: sl()))
    ..registerFactory(() => GetContactsBloc(getAllContacts: sl()))
    ..registerFactory(() => AllUsersBloc(getAllUsers: sl()))
    ..registerFactory(() => AddToContactBloc(addToContact: sl()))
    ..registerFactory(() => ContactExistsBloc(contactExists: sl()))
    ..registerLazySingleton(() => LogIn(authAndUserRepository: sl()))
    ..registerLazySingleton(() => SignUp(authAndUserRepository: sl()))
    ..registerLazySingleton(() => LogOut(authAndUserRepository: sl()))
    ..registerLazySingleton(() => GetAllContacts(authAndUserRepository: sl()))
    ..registerLazySingleton(() => GetAllUsers(authAndUserRepository: sl()))
    ..registerLazySingleton(() => AddToContact(authAndUserRepository: sl()))
    ..registerLazySingleton(() => ContactExists(authAndUserRepository: sl()))
    ..registerLazySingleton<AuthAndUserRepository>(
        () => AuthAndUserRepoImplementation(authAndUserRemoteDataSource: sl()))
    ..registerLazySingleton<AuthAndUserRemoteDataSource>(() =>
        AuthAndUserRemoteDataSourceImplementation(
            firebaseInitSingleton: FirebaseInitSingleton()));
}

Future<void> _initChat() async {
  sl
    ..registerFactory(() => GetAppUserBloc(getAppUser: sl()))
    ..registerFactory(() => UserNameAndProfileImageUrlBloc(
          getUserNameAndProfileUrl: sl(),
        ))
    ..registerFactory(() => LatestMessageBloc(getLatestMessage: sl()))
    ..registerFactory(
        () => NumberOfMessageBloc(getNumberOfUnreadMessages: sl()))
    ..registerFactory(() => ChatListBloc(getChats: sl()))
    ..registerFactory(() => ChatMessagesBloc(getMessages: sl()))
    ..registerFactory(() => SendMessageBloc(sendMessage: sl()))
    ..registerFactory(() => MessageStatusUpdateCubit(messageStatusUpdate: sl()))
    ..registerFactory(() => GetUserChatStatusBloc(getUserChatStatus: sl()))
    ..registerFactory(() => ChatStatusUpdateBloc(chatStatusUpdate: sl()))
    ..registerFactory(() => MessageSelectionModeCubit())
    ..registerFactory(() => SelectMessagesCubit(deleteMessages: sl()))
    ..registerLazySingleton(() => GetAppUser(chatRepository: sl()))
    ..registerLazySingleton(
        () => GetUserNameAndProfileUrl(chatRepository: sl()))
    ..registerLazySingleton(() => GetLatestMessage(chatRepository: sl()))
    ..registerLazySingleton(
        () => GetNumberOfUnreadMessages(chatRepository: sl()))
    ..registerLazySingleton(() => GetChats(chatRepository: sl()))
    ..registerLazySingleton(() => GetMessages(chatRepository: sl()))
    ..registerLazySingleton(() => SendMessage(chatRepository: sl()))
    ..registerLazySingleton(() => MessageStatusUpdate(chatRepository: sl()))
    ..registerLazySingleton(() => GetUserChatStatus(chatRepository: sl()))
    ..registerLazySingleton(() => ChatStatusUpdate(chatRepository: sl()))
    ..registerLazySingleton(() => DeleteMessages(chatRepository: sl()))
    ..registerLazySingleton<ChatRepository>(
        () => ChatRepositoryImplementation(chatDataSource: sl()))
    ..registerLazySingleton<ChatRemoteDataSource>(() =>
        ChatRemoteDataSourceImplementation(
            firebaseInitSingleton: FirebaseInitSingleton()));
}
