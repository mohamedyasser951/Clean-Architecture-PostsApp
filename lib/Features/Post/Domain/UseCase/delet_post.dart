import 'package:clean_arch_posts_app/Core/Error/failure.dart';
import 'package:clean_arch_posts_app/Features/Post/Domain/Repository/posts_repo.dart';
import 'package:dartz/dartz.dart';

class DeletePostUseCase {
  PostsRepository postsRepository;
  DeletePostUseCase({
    required this.postsRepository,
  });

  Future<Either<Failure, Unit>> call(int postId) async {
    return await postsRepository.deletePost(postId: postId);
  }
}
