part of 'loading_cubit.dart';

@immutable
final class LoadingState extends Equatable {
  const LoadingState({this.isLoading = false});
  final bool isLoading;

  LoadingState copyWith({bool? isLoading}) {
    return LoadingState(
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [isLoading];
}
