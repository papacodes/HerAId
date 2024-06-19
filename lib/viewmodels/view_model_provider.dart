import 'package:flutter/widgets.dart';
import 'package:her_aid/viewmodels/base_view_model.dart';
import 'package:provider/provider.dart';

class ViewModelProvider<T extends BaseViewModel> extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final viewModel = viewModelBuilder();

    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Builder(builder: (context) => builder(context, viewModel, child)),
    );
  }
}

class ViewModelBuilder<T extends BaseViewModel> extends StatelessWidget {
  final Widget Function(BuildContext, T) builder;

  const ViewModelBuilder({required this.builder, super.key});

  @override
  Widget build(BuildContext context) =>
      Consumer<T>(builder: (context, viewModel, child) => builder(context, viewModel));
}
