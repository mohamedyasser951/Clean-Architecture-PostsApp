import 'package:clean_arch_posts_app/Core/Error/exception.dart';
import 'package:clean_arch_posts_app/Core/Network/network_info.dart';
import 'package:clean_arch_posts_app/Features/Post/Data/Models/posts_model.dart';
import 'package:dartz/dartz.dart';
import 'package:clean_arch_posts_app/Core/Error/failure.dart';
import 'package:clean_arch_posts_app/Features/Post/Data/DataSource/local_data_source.dart';
import 'package:clean_arch_posts_app/Features/Post/Data/DataSource/remote_data_source.dart';
import 'package:clean_arch_posts_app/Features/Post/Domain/Entities/post_entity.dart';
import 'package:clean_arch_posts_app/Features/Post/Domain/Repository/posts_repo.dart';

typedef DeleteOrUpdateOrAddPost = Future<Unit> Function();

class PostsRepositoryImplem implements PostsRepository {
  RemoteDataSource remoteDataSourcel;
  LocaleDataSource localeDataSource;
  NetworkInfo networkInfo;
  PostsRepositoryImplem({
    required this.remoteDataSourcel,
    required this.localeDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<PostEntity>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await remoteDataSourcel.getAllPosts();
        localeDataSource.cashePosts(remotePosts);
        return Right(remotePosts);
      } on ServerFailure {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await localeDataSource.getCachedPosts();
        return Right(localPosts);
      } on EmptyCacheFailure {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(
      {required PostEntity postEntity}) async {
    PostsModel postsModel = PostsModel(
        id: postEntity.id, title: postEntity.title, body: postEntity.body);
    return await getMessage(() {
      return remoteDataSourcel.addPost(postsModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> updatePost(
      {required PostEntity postEntity}) async {
    PostsModel postsModel = PostsModel(
        id: postEntity.id, title: postEntity.title, body: postEntity.title);
    return await getMessage(() {
      return remoteDataSourcel.updatePost(postsModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> deletePost({required int postId}) async {
    return await getMessage(() {
      return remoteDataSourcel.deletePost(postId);
    });
  }

  Future<Either<Failure, Unit>> getMessage(
      DeleteOrUpdateOrAddPost addOrUpdateOrDeleteFunction) async {
    if (await networkInfo.isConnected) {
      try {
        await addOrUpdateOrDeleteFunction();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }
}
