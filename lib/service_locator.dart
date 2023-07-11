import 'package:clean_arch_posts_app/Core/Network/network_info.dart';
import 'package:clean_arch_posts_app/Features/Post/Data/DataSource/local_data_source.dart';
import 'package:clean_arch_posts_app/Features/Post/Data/DataSource/remote_data_source.dart';
import 'package:clean_arch_posts_app/Features/Post/Data/Repository/repository_impl.dart';
import 'package:clean_arch_posts_app/Features/Post/Domain/Repository/posts_repo.dart';
import 'package:clean_arch_posts_app/Features/Post/Domain/UseCase/add_post.dart';
import 'package:clean_arch_posts_app/Features/Post/Domain/UseCase/delet_post.dart';
import 'package:clean_arch_posts_app/Features/Post/Domain/UseCase/get_all_posts.dart';
import 'package:clean_arch_posts_app/Features/Post/Domain/UseCase/update_post.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'Features/Post/Presentation/Bloc/PostsBloc/posts_bloc.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  //BLOCS
  sl.registerFactory<PostsBloc>(() => PostsBloc(getAllPostsUseCase: sl()));

  //Repositories
  sl.registerLazySingleton<PostsRepository>(() => PostsRepositoryImplem(
      remoteDataSourcel: sl(), localeDataSource: sl(), networkInfo: sl()));

//UseCases

  sl.registerLazySingleton(() => GetAllPostsUseCase(postsRepository: sl()));
  sl.registerLazySingleton(() => AddPostUseCase(postsRepository: sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(postsRepository: sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(postsRepository: sl()));

  //DataSource
  sl.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImplem(client: sl()));
  sl.registerLazySingleton<LocaleDataSource>(
      () => LocaleDataSourceImplem(sharedPreferences: sl()));

  //Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImplem());

  //External
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton(
    () => sharedPreferences,
  );
  sl.registerLazySingleton(() => http.Client());

  sl.registerLazySingleton(() => InternetConnectionChecker());
}
