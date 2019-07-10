import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

import '../api/const.dart';
import '../model/search_model.dart';
import '../api/api.dart';

class ProviderBlock {
  final String _EMPTY = "_empty_";

  final _api = Api();
  final _fetcher = PublishSubject<SearchModel>();

  stream() => _fetcher.stream;

  static ProviderBlock instance() => ProviderBlock();

  // API request
  void fetchQueryList() async {
    fetchUrl(search_url, (map) => SearchModel.fromJson(map));
  }

  void dispose() {
    if (!_fetcher.isClosed) {
      _fetcher.close();
    }
  }

  void fetchUrl(String url, Function handleData) async {
    _api.fetchUrl(url, (map) {
      _fetcher.sink.add(handleData(map));
    }, (errorMsg) {
      _fetcher.sink.addError(errorMsg, null);
    }, () {
      _fetcher.sink.addError(_EMPTY);
    });
  }

  Widget streamBuilder<T>({
    T initalData,
    Function success,
    Function error,
    Function empty,
    Function loading,
    Function finished,
  }) {
    return StreamBuilder(
        stream: stream(),
        initialData: initalData,
        builder: (context, AsyncSnapshot<T> snapshot) {
          if (finished != null) {
            finished();
          }
          if (snapshot.hasData) {
            if (success != null) return success(snapshot.data);
          } else if (snapshot.hasError) {
            final errorStr = snapshot.error;
            if (errorStr == _EMPTY) {
              if (empty != null) return empty();
            } else {
              if (error != null) return error(errorStr);
            }
          } else {
            if (loading != null) return loading();
          }
        });
  }
}
