import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

class BaseViewModel extends ChangeNotifier {
  bool _disposed = false;

  bool _busy = false;
  bool get busy => _busy;

  String errorMessage = '';
  dynamic data;
  bool get disposed => _disposed;

  BuildContext? baseContext;

  void setBusy(bool newValue) {
    _busy = newValue;
    notifyListeners();
  }

  //NOTE: Should we set busy automaticlly to false once the error message was set
  void setErrorMessage(String newValue, {bool? setBusy}) {
    _busy = setBusy ?? _busy;
    errorMessage = newValue;
    notifyListeners();
  }

  void setData(dynamic newValue) {
    data = newValue;
    notifyListeners();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  //NOTE: Calls the builder function with this updated ViewModel
  void forceRebuild() {
    notifyListeners();
  }

  void softResetStateManager(
      {bool? disposed, bool? busy, bool? errorMessage, bool? data}) {
    if (disposed == true) {
      _disposed = false;
    }

    if (busy == true) {
      _busy = false;
    }

    if (errorMessage == true) {
      this.errorMessage = '';
    }

    if (data == true) {
      this.data = null;
    }
  }

  void softResetStateManagers() {
    _disposed = false;
    _busy = false;
    errorMessage = '';
    data = null;
  }

  void resetStateManagersWithStateUpdate() {
    _disposed = false;
    _busy = false;
    errorMessage = '';
    data = null;

    forceRebuild();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}

//NOTE: This was left for ref and ideas, this should be removed before going into main

// abstract class ReactiveViewModel extends BaseViewModel {
//   List<ValueNotifier> _notifiers = [];
//   List<ValueNotifier> get notifiers => [];

//   ReactiveViewModel() {
//     if (notifiers.isNotEmpty) {
//       _reactToNotifiers(notifiers);
//     }
//   }

//   void _reactToNotifiers(List<ValueNotifier> notifiers) {
//     _notifiers = notifiers;
//     for (var notifier in _notifiers) {
//       notifier.addListener(_indicateChange);
//     }
//   }

//   @override
//   void dispose() {
//     for (var notifier in _notifiers) {
//       notifier.removeListener(_indicateChange);
//     }
//     super.dispose();
//   }

//   void _indicateChange() {
//     notifyListeners();
//   }
// }

// @protected
// class DynamicSourceViewModel<T> extends ReactiveViewModel {
//   bool changeSource = false;

//   void notifySourceChanged() {
//     changeSource = true;
//   }

//   @override
//   List<ValueNotifier> get notifiers => [];
// }

// abstract class Initializable {
//   void initialize();
// }

// class StreamData<T> extends DynamicSourceViewModel<T> {
//   Stream<T> stream;

//   Function(T data)? onData;
//   Function()? onSubscribed;
//   Function(dynamic error)? onError;
//   Function()? onCancel;
//   Function(T data)? transformData;

//   T? data; // Add this property to store the data

//   StreamData(
//     this.stream, {
//     this.onData,
//     this.onSubscribed,
//     this.onError,
//     this.onCancel,
//     this.transformData,
//   }) {
//     initialize();
//   }

//   late StreamSubscription<T> _streamSubscription;

//   void initialize() {
//     _streamSubscription = stream.listen(
//       (incomingData) {
//         setError(null);

//         final interceptedData = transformData?.call(incomingData) ?? incomingData;

//         if (interceptedData != null) {
//           data = interceptedData;
//         } else {
//           data = incomingData;
//         }

//         notifyListeners();

//         onData?.call(data as T);
//       },
//       onError: (error) {
//         setError(error);
//         data = null;
//         onError?.call(error);
//         notifyListeners();
//       },
//     );

//     onSubscribed?.call();
//   }

//   @override
//   void dispose() {
//     _streamSubscription.cancel();
//     onCancel?.call();
//     super.dispose();
//   }
// }
