import 'package:clean_arch_posts_app/Core/Error/exception.dart';
import 'package:clean_arch_posts_app/Core/Network/network_info.dart';
import 'package:clean_arch_posts_app/Features/Post/Data/Models/posts_model.dart';
import 'package:dartz/dartz.dart';
import 'package:clean_arch_posts_app/Core/Error/failure.dart';
import 'package:clean_arch_posts_app/Features/Post/Data/DataSource/local_data_source.dart';
import 'package:clean_arch_posts_app/Features/Post/Data/DataSource/remote_data_source.dart';
import 'package:clean_arch_posts_app/Features/Post/Domain/Entities/post_entity.dart';
import 'package:clean_arch_posts_app/Features/Post/Domain/Repository/posts_repo.dart';

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
    if (await networkInfo.isConnected) {
      try {
        remoteDataSourcel.addPost(postsModel);
        return const Right(unit);
      } on OfflineException {
        return Left(OffLineFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deletePost({required int postId}) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> updatePost({required PostEntity postEntity}) {
    // TODO: implement updatePost
    throw UnimplementedError();
  }
}
