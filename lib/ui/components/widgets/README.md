# Common Components

Bu klasör, uygulama genelinde kullanılabilecek ortak bileşenleri içerir. Bu bileşenler, arama ekranları ve seçim ekranları için pagination, refresh ve load more işlevselliği sağlar.

## Bileşenler

### 1. CommonGridView<T>

Genel amaçlı grid view bileşeni. Pagination, refresh ve load more işlevselliği destekler.

#### Özellikler:
- **Pagination**: Otomatik sayfa yükleme
- **Pull to Refresh**: Aşağı çekerek yenileme
- **Load More**: Scroll ile otomatik daha fazla veri yükleme
- **Error Handling**: Hata durumları için özel widget'lar
- **Empty State**: Boş durum için özel widget'lar
- **Customizable**: Grid boyutları, spacing ve padding özelleştirilebilir

#### Kullanım:

```dart
CommonGridView<YourModel>(
  items: yourItemsList,
  itemBuilder: (context, item, index) {
    return YourItemWidget(item: item);
  },
  onLoadMore: () {
    // Daha fazla veri yükle
  },
  onRefresh: () async {
    // Verileri yenile
  },
  hasMoreData: true,
  isLoading: false,
  crossAxisCount: 2,
  mainAxisSpacing: 16,
  crossAxisSpacing: 16,
)
```

### 2. CommonSearchScreenView<T>

Arama ekranları için özel olarak tasarlanmış bileşen. Search field, filter options ve grid view içerir.

#### Özellikler:
- **Search Field**: Arama metni girişi
- **Filter Options**: Yatay scroll filter butonları
- **Results Count**: Bulunan sonuç sayısı
- **Grid View**: CommonGridView entegrasyonu
- **Responsive**: Küçük ekran desteği

#### Kullanım:

```dart
CommonSearchScreenView<YourModel>(
  title: 'Search Results',
  searchHint: 'Search items...',
  items: yourItemsList,
  itemBuilder: (context, item, index) {
    return YourItemWidget(item: item);
  },
  onLoadMore: () {
    // Daha fazla veri yükle
  },
  onRefresh: () async {
    // Verileri yenile
  },
  onSearchChanged: (query) {
    // Arama metni değiştiğinde
  },
  filterOptions: ['All', 'Category 1', 'Category 2'],
  hasMoreData: true,
  isLoading: false,
)
```

### 3. CommonChooseScreenView<T>

Seçim ekranları için özel olarak tasarlanmış bileşen. Item selection ve auto-pop özelliği.

#### Özellikler:
- **Item Selection**: Tek seçim desteği
- **Auto Pop**: Seçim sonrası otomatik route pop
- **Customizable Delay**: Pop gecikmesi ayarlanabilir
- **Grid View**: CommonChooseGridView entegrasyonu

#### Kullanım:

```dart
CommonChooseScreenView<YourModel>(
  title: 'Choose an Option',
  items: yourOptionsList,
  itemBuilder: (context, item, index, isSelected) {
    return YourOptionWidget(
      item: item,
      isSelected: isSelected,
    );
  },
  onItemSelected: (item, index) {
    // Item seçildiğinde
  },
  autoPop: true,
  popDelay: 500, // 500ms gecikme
)
```

### 4. CommonChooseGridView<T>

Seçim ekranları için özel grid view. Item selection ve gesture handling içerir.

#### Özellikler:
- **Selection State**: Seçili item'ları gösterme
- **Gesture Handling**: Tap ile seçim
- **Empty State**: Boş durum için özel widget

#### Kullanım:

```dart
CommonChooseGridView<YourModel>(
  items: yourOptionsList,
  itemBuilder: (context, item, index, isSelected) {
    return YourOptionWidget(
      item: item,
      isSelected: isSelected,
    );
  },
  onItemSelected: (item, index) {
    // Item seçildiğinde
  },
  selectedIndex: currentSelectedIndex,
)
```

## Pagination ve Load More

### Nasıl Çalışır:

1. **Scroll Detection**: Kullanıcı grid'in sonuna yaklaştığında otomatik olarak algılanır
2. **Load More Trigger**: Scroll pozisyonu maxScrollExtent - 200 piksel olduğunda tetiklenir
3. **API Call**: `onLoadMore` callback'i çağrılır
4. **State Management**: Loading state'i yönetilir
5. **Data Update**: Yeni veriler mevcut listeye eklenir

### Örnek Implementation:

```dart
class _MyScreenState extends State<MyScreen> {
  final List<MyModel> _items = [];
  bool _isLoading = false;
  bool _hasMoreData = true;
  int _currentPage = 0;

  Future<void> _loadMoreData() async {
    if (_isLoading || !_hasMoreData) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // API call
      final newItems = await apiService.getItems(page: _currentPage);
      
      if (newItems.isEmpty) {
        _hasMoreData = false;
      } else {
        _items.addAll(newItems);
        _currentPage++;
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonGridView<MyModel>(
      items: _items,
      itemBuilder: (context, item, index) => MyItemWidget(item: item),
      onLoadMore: _loadMoreData,
      hasMoreData: _hasMoreData,
      isLoading: _isLoading,
    );
  }
}
```

## Refresh İşlevselliği

### Pull to Refresh:

```dart
CommonGridView<YourModel>(
  // ... diğer parametreler
  onRefresh: () async {
    // Verileri sıfırla ve yeniden yükle
    _items.clear();
    _currentPage = 0;
    _hasMoreData = true;
    await _loadInitialData();
  },
)
```

## Error Handling

### Error State:

```dart
CommonGridView<YourModel>(
  // ... diğer parametreler
  error: _error,
  retryCallback: () {
    // Hata durumunda tekrar dene
    _loadInitialData();
  },
  errorWidget: CustomErrorWidget(
    error: _error,
    onRetry: _loadInitialData,
  ),
)
```

## Customization

### Grid Ayarları:

```dart
CommonGridView<YourModel>(
  // ... diğer parametreler
  crossAxisCount: 3, // 3 sütun
  mainAxisSpacing: 20, // Satır arası boşluk
  crossAxisSpacing: 20, // Sütun arası boşluk
  padding: EdgeInsets.all(16),
)
```

### Custom Widget'lar:

```dart
CommonGridView<YourModel>(
  // ... diğer parametreler
  emptyStateWidget: CustomEmptyState(),
  loadingWidget: CustomLoadingWidget(),
  loadingMoreWidget: CustomLoadMoreWidget(),
  errorWidget: CustomErrorWidget(),
)
```

## Performance Optimizations

1. **Lazy Loading**: Sadece görünür item'lar render edilir
2. **Scroll Controller**: Efficient scroll handling
3. **State Management**: Minimal rebuild'ler
4. **Memory Management**: Proper disposal of controllers

## Best Practices

1. **API Pagination**: Backend'de proper pagination implement edin
2. **Loading States**: Kullanıcıya loading feedback'i verin
3. **Error Handling**: Hata durumlarını graceful handle edin
4. **Empty States**: Boş durumlar için meaningful mesajlar gösterin
5. **Performance**: Büyük listeler için virtualization kullanın

## Migration Guide

### Eski Search Screen'dan Yeni'ye:

**Eski:**
```dart
class IdeaSearchScreenView extends StatefulWidget {
  // ... eski implementation
}
```

**Yeni:**
```dart
class IdeaSearchScreenView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommonSearchScreenView<IdeaModel>(
      title: TextConstants.searchResult,
      searchHint: TextConstants.searchIdeas,
      items: _ideaItems,
      itemBuilder: (context, idea, index) {
        return IdeaSearchedItem(idea: idea);
      },
      onLoadMore: _loadMoreIdeas,
      onRefresh: _refreshIdeas,
      filterOptions: scrollingIdeaType,
    );
  }
}
```

### Eski Choose Screen'dan Yeni'ye:

**Eski:**
```dart
class CustomChooseTypeScreenView extends StatefulWidget {
  // ... eski implementation
}
```

**Yeni:**
```dart
class CustomChooseTypeScreenView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommonChooseScreenView<AppImages>(
      title: TextConstants.chooseType,
      items: widget.chooseTypeModel.typeList,
      itemBuilder: (context, image, index, isSelected) {
        return ChooseTypeItem(
          image: image,
          isSelected: isSelected,
        );
      },
      onItemSelected: (image, index) {
        widget.chooseTypeModel.onItemTap?.call(image);
      },
    );
  }
}
```

## Troubleshooting

### Common Issues:

1. **Load More Not Working**: `hasMoreData` ve `onLoadMore` parametrelerini kontrol edin
2. **Refresh Not Working**: `onRefresh` callback'inin async olduğundan emin olun
3. **Performance Issues**: `crossAxisCount` ve spacing değerlerini optimize edin
4. **Memory Leaks**: ScrollController'ları proper dispose edin

### Debug Tips:

```dart
CommonGridView<YourModel>(
  // ... diğer parametreler
  onLoadMore: () {
    print('Load more triggered');
    _loadMoreData();
  },
  onRefresh: () async {
    print('Refresh triggered');
    await _refreshData();
  },
)
```

Bu common component'ler sayesinde, arama ve seçim ekranlarınızı hızlıca implement edebilir, pagination, refresh ve load more işlevselliğini kolayca ekleyebilirsiniz.
