import 'package:cubit_task/Controller/Cubits/pageCubit/page_cubit.dart';
import 'package:cubit_task/Models/post_model.dart';
import 'package:cubit_task/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:http/http.dart' as http;

import '../Controller/Cubits/pageCubit/page_state.dart';
import '../Models/DataController/user_controler.dart';

class PostView extends StatefulWidget {
  const PostView({super.key});

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  final _numberOfPostsPerRequest = 10;
  int pageKey = 0;
  final PagingController<int, PostModel> _pagingController =
      PagingController(firstPageKey: 0);
  List<PostModel> postModels = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<PageCubit>().getPosts(pageKey, 10, _pagingController);
    _pagingController.addPageRequestListener((pageKey) {
      // _fetchPosts(pageKey);
      context.read<PageCubit>().getPosts(pageKey, 10, _pagingController);
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Api Pagination'),
      ),
      body: BlocConsumer<PageCubit, PageState>(builder: (context, state) {
        if (state is PageLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is PageLoadedState) {
          return RefreshIndicator(
            onRefresh: () => Future.sync(() => _pagingController.refresh()),
            child: PagedListView(
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<PostModel>(
                    firstPageErrorIndicatorBuilder: (context) {
                  return const Center(child: Text('No Internet'));
                }, noItemsFoundIndicatorBuilder: (_) {
                  return const Center(
                    child: Text("No Data Found"),
                  );
                }, itemBuilder: (_, post, index) {
                  return Container(
                    margin: const EdgeInsets.all(5),

                    // constraints:
                    //     const BoxConstraints(maxHeight: 240, minHeight: 180),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.yellow,
                        border: Border.all(color: Colors.black)),
                    // height: 220,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${post.title}",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('${post.body}',
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  );
                })),
          );
        }
        if (state is PageSocketState) {
          return const Center(child: Text("No internet"));
        }
        return Container();
      }, listener: (context, state) {
        if (state is PageLoadedState) {
          final isLastPage =
              UserControler.postModel!.length < _numberOfPostsPerRequest;
          if (isLastPage) {
            _pagingController.appendLastPage(UserControler.postModel!);
          } else {
            final nextPageKey = pageKey + 1;
            _pagingController.appendPage(UserControler.postModel!, nextPageKey);
          }
        }
      }),
    );
  }

  // Future<void> _fetchPosts(pageKey) async {
  //   try {
  //     var request = http.Request(
  //         'GET',
  //         Uri.parse(
  //             'https://jsonplaceholder.typicode.com/posts?_page=$pageKey&_limit=$_numberOfPostsPerRequest'));

  //     http.StreamedResponse response = await request.send();

  //     if (response.statusCode == 200) {
  //       postModels = postModelFromJson(await response.stream.bytesToString());
  //       final isLastPage = postModels.length < _numberOfPostsPerRequest;
  //       if (isLastPage) {
  //         _pagingController.appendLastPage(postModels);
  //       } else {
  //         final nextPageKey = pageKey + 1;
  //         _pagingController.appendPage(postModels, nextPageKey);
  //       }
  //     } else {
  //       print(response.reasonPhrase);
  //     }
  //   } catch (e) {
  //     showSnackBar(context, e.toString());
  //     _pagingController.error = e;
  //   }
  // }
}
