import 'package:clean_arch_posts_app/Core/Error/failure.dart';
import 'package:clean_arch_posts_app/Features/Post/Domain/Entities/post_entity.dart';
import 'package:clean_arch_posts_app/Features/Post/Domain/Repository/posts_repo.dart';
import 'package:dartz/dartz.dart';

class AddPostUseCase {
  PostsRepository postsRepository;
  AddPostUseCase({
    required this.postsRepository,
  });

  Future<Either<Failure, Unit>> call(PostEntity postEntity) async {
    return await postsRepository.addPost(postEntity: postEntity);
  }
}
