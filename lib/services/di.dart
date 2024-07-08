import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../features/orders/data/datasources/product_remote_datasource.dart';
import '../features/orders/data/repositories/product_repo_impl.dart';
import '../features/orders/domain/repositories/product_repo.dart';
import '../features/orders/domain/usecases/get_products.dart';
import '../features/orders/presentation/bloc/order_bloc.dart';

final getIt = GetIt.instance;

void setupDependencyInjection() {
  // Register http client
  getIt.registerLazySingleton(() => http.Client());

  // Register data sources
  getIt.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(client: getIt()),
  );

  // Register repositories
  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(remoteDataSource: getIt()),
  );

  // Register use cases
  getIt.registerLazySingleton(() => GetProducts(getIt()));

  // Register BLoCs
  getIt.registerSingleton(ProductBloc(getIt<ProductRepository>(),
      getProducts: getIt<GetProducts>()));
}
