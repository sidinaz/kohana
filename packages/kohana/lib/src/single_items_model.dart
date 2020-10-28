import 'package:kohana/src/model.dart';
import 'package:kohana/src/view_state.dart';
import 'package:rxdart/rxdart.dart';

class SingleItemsModel<T> extends BaseModel {
  final int itemsPerPage;
  final Map<int, _Page<T>> _currentPages = Map();
  final BehaviorSubject<List<T>> _itemsSubject;

  int get length =>
      _itemsSubject.value != null ? _itemsSubject.value.length : 0;

  SingleItemsModel([this.itemsPerPage = 30])
      : this._itemsSubject = BehaviorSubject<List<T>>();

  Stream<List<T>> get items => _itemsSubject;

  List<T> get itemsValue => _itemsSubject.value ?? [];

  void push() => _itemsSubject.add(itemsValue);

  void clear() {
    _currentPages.clear();
    _itemsSubject.add([]);
  }

  void setItems(List<T> items, [int page = 0]) {
    if (page == null) {
      //append items
      List<T> _items = [];
      if (_currentPages.containsKey(0)) {
        _items = [..._currentPages[0].items];
      }
      _items = [..._items, ...items];
      _currentPages[0] = _Page(_items, 0);
    } else {
      //set items
      _currentPages[page] = _Page(items, page);
    }
    final list = _currentPages.keys.toList()..sort();
    this._itemsSubject.add(convert(list.map(($) => _currentPages[$]).toList()));
  }

  void appendItems(List<T> items) {
    setItems(items, null);
    setActivity(ViewState.Done);
  }

  List<T> convert(List<_Page<T>> items) =>
      items.map((i) => i.items).reduce((a, b) => [...a, ...b]);

  int eventToPageNumber(Object event) => length ~/ itemsPerPage;

  bool requestMore(Object event) => length % itemsPerPage == 0 || length == 0;
}

class _Page<T> {
  final List<T> items;
  final int page;

  _Page([this.items = const [], this.page = 0]);
}
