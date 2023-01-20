import 'package:cubit_task/Controller/Cubits/pageCubit/page_state.dart';
import 'package:cubit_task/Controller/Repositories/post_repo.dart';
import 'package:cubit_task/Utils/status_code.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// part of 'page_state.dart';

class PageCubit extends Cubit<PageState> {
  PageCubit() : super(PageInitialState());

  getPosts(pageKey, postPerPage, controler) async {
    emit(PageLoadingState());
    int response = await PostRepo.fetchPost(pageKey, postPerPage, controler);
    if (response == 200) {
      emit(PageLoadedState());
    } else if (response == StatusCode.socketException) {
      emit(PageSocketState());
    } else if (response == StatusCode.tokenExpire) {
      emit(PageTokenExpireState());
    }
  }
}
