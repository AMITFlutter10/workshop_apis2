import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:workshop_apis2/models/category_model.dart';
import 'package:workshop_apis2/models/login_response.dart';
import 'package:workshop_apis2/repos/dio_helper.dart';
import 'package:workshop_apis2/repos/end_points.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());

  static MainCubit get(context) => BlocProvider.of(context);

  LoginResponse? user;
  // User? user;

  login(String email, String pass) async {
    emit(LoadingLoginState());
    await DioHelper.dio.post(
      loginEndPoint,
      data: {
        "email": email,
        "password": pass,
      },
    ).then((value) {
      if (value.statusCode == 200) {
        user = LoginResponse.fromJson(value.data);
        // user = User.fromJson(value.data["user"]);
        print(user!.token);

        emit(SuccessLoginState());
      } else {
        print(value.data);
        emit(ErrorLoginState());
      }
    }).catchError((error) {
      print(error.toString());
      emit(ErrorLoginState());
    });
  }

  register(String email, String name, String mobile, String pass) async {
    emit(LoadingRegisterState());
    await DioHelper.dio
        .post(
      registerEndPoint,
      data: FormData.fromMap({
        "name": name,
        "email": email,
        "password": pass,
        "mobile": mobile,
      }),
    )
        .then((value) {
      if (value.statusCode == 200) {
        emit(SuccessRegisterState());
      } else {
        print(value.data);
        emit(ErrorRegisterState());
      }
    }).catchError((error) {
      print(error.toString());
      emit(ErrorRegisterState());
    });
  }

  List<CategoryModel> categories = [];

  getCategories() async {
    categories = [];
    emit(LoadingGetCategoriesState());
    await DioHelper.dio
        .get(getAllCategoriesEndPoint,
            options: Options(headers: {
              "Authorization": "Bearer ${user!.token!}",
            }))
        .then((value) {
      if (value.statusCode == 200) {
        for (var element in value.data["data"]) {
          categories.add(CategoryModel.fromJson(element));
        }

        print(categories.length);

        emit(SuccessGetCategoriesState());
      } else {
        print(value.data);
        emit(ErrorGetCategoriesState());
      }
    }).catchError((error) {
      print(error);
      emit(ErrorGetCategoriesState());
    });
  }
}
