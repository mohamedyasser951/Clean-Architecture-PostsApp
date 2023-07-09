import 'package:clean_arch_posts_app/Core/Error/failure.dart';
import 'package:clean_arch_posts_app/Features/Post/Domain/Entities/post_entity.dart';
import 'package:clean_arch_posts_app/Features/Post/Domain/Repository/posts_repo.dart';
import 'package:dartz/dartz.dart';

class PostsRepositoryImplem implements PostsRepository{

  @override
  Future<Either<Failure, List<PostEntity>>> getAllPosts() {
    // TODO: implement getAllPOsts
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> addPost({required PostEntity postEntity}) {
    // TODO: implement addPost
    throw UnimplementedError();
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