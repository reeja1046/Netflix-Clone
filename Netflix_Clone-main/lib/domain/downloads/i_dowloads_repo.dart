import 'package:dartz/dartz.dart';
import 'package:netflix_project/domain/core/failures/main_failure.dart';
import 'package:netflix_project/domain/downloads/models/downloads.dart';

abstract class IDownloadsRepo {
  Future<Either<MainFailure, List<Downloads>>> getDownloadsImages();
}
