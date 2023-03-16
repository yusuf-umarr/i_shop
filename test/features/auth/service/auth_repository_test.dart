import 'package:flutter_test/flutter_test.dart';
import 'package:i_shop_riverpod/core/config/response/api_response.dart';
import 'package:i_shop_riverpod/features/auth/model/user_model.dart';
import 'package:i_shop_riverpod/features/auth/service/auth_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockService extends Mock implements AuthRepositoryImpl {}

void main() {

  late MockService mockService;

  setUp(() {
    mockService = MockService();
  });
  group('AuthRepository-', () {
    final res = ApiResponse<UserModel>(
      success: true,
      data: UserModel(),
      message: "login successfully!!!",
    );

    UserModel model = UserModel(email: "", password: "");
    test(
      'check if the user login response is correct',
      () async {
     
        when(() => mockService.login(model)).thenAnswer((_) async =>res);
        
        final loginRes = await mockService.login(model);

        expect(loginRes, res);
      },
    );
    //
    test(
      'check if the user register response is correct',
      () async {
     
        when(() => mockService.register(model)).thenAnswer((_) async =>res);
        
        final loginRes = await mockService.register(model);

        expect(loginRes, res);
      },
    );
    //
    test(
      'check if the user updateAddress response is correct',
      () async {
     
        when(() => mockService.updateAddress("address")).thenAnswer((_) async =>res);
        
        final loginRes = await mockService.updateAddress("address");

        expect(loginRes, res);
      },
    );
    //
    test(
      'check if the user updateUser response is correct',
      () async {
     
        when(() => mockService.updateUser(model)).thenAnswer((_) async =>res);
        
        final loginRes = await mockService.updateUser(model);

        expect(loginRes, res);
      },
    );
    test(
      'check if the user getUserData response is correct',
      () async {
     
        when(() => mockService.getUserData()).thenAnswer((_) async =>res);
        
        final loginRes = await mockService.getUserData();

        expect(loginRes, res);
      },
    );
    //
    
    //
  });
}
