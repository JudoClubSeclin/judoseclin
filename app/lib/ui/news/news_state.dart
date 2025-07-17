abstract class NewsState {
  const NewsState();
}

class NewsInitialState extends NewsState{}

class NewsLoadingState extends NewsState{}

class NewsSuccessState extends NewsState {
  final String newsId;
  NewsSuccessState({required this.newsId});
}

class NewsErrorState extends NewsState {
  final String error;
  NewsErrorState(this.error);
}


