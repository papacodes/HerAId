import 'package:flutter/widgets.dart';
import 'package:oats_package/oats_package.dart';
import 'package:oats_package/views/base/base_viewmodel.dart';
import 'package:provider/provider.dart';

class ViewModelProvider<T extends ChangeNotifier> extends StatefulWidget {
  final T Function() viewModelBuilder;
  final Widget Function(BuildContext, T, Widget?) builder;
  final Widget? child;

  const ViewModelProvider({
    required this.viewModelBuilder,
    required this.builder,
    super.key,
    this.child,
  });

  @override
  State<ViewModelProvider<T>> createState() => _ViewModelProviderState<T>();
}

class _ViewModelProviderState<T extends ChangeNotifier> extends State<ViewModelProvider<T>> with RouteAware {
  late T viewModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final ModalRoute? modalRoute = ModalRoute.of(context);
    if (modalRoute is PageRoute) {
      routeObserver.subscribe(this, modalRoute);
    }
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    super.didPopNext();

    if (viewModel is BaseViewModel) {
      (viewModel as BaseViewModel).onPoppedBack();
    }
  }

  @override
  void initState() {
    super.initState();
    viewModel = widget.viewModelBuilder();
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<T>(
        create: (_) => viewModel,
        child: Builder(
          builder: (context) => widget.builder(context, Provider.of<T>(context), widget.child),
        ),
      );
}

class ViewModelBuilder<T extends BaseViewModel> extends StatelessWidget {
  final Widget Function(BuildContext, T) builder;

  const ViewModelBuilder({required this.builder, super.key});

  @override
  Widget build(BuildContext context) =>
      Consumer<T>(builder: (context, viewModel, child) => builder(context, viewModel));
}
