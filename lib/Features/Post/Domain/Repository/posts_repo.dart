import 'package:clean_arch_posts_app/Core/Error/failure.dart';
import 'package:clean_arch_posts_app/Features/Post/Domain/Entities/post_entity.dart';
import 'package:dartz/dartz.dart';

abstract class PostsRepository {
  Future<Either<Failure, List<PostEntity>>> getAllPosts();
  Future<Either<Failure, Unit>> updatePost({required PostEntity postEntity});
  Future<Either<Failure, Unit>> addPost({required PostEntity postEntity});
  Future<Either<Failure, Unit>> deletePost({required int postId});
}
