import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflitetest/data/model/itemresponse.dart';

import 'approuter.dart';
import 'basic_info_cubit.dart';

void main() {
  runApp(SQflitetestApp());

}
class SQflitetestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocProvider(
        create: (_) => BasicInfoCubit(),
    child: BasicInfoApp()
    ));
    }
  }
class BasicInfoApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<BasicInfoCubit>(context).loadInfo();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
        ),
        // backgroundColor: grayCMYKColor,
        // drawer: SideDrawer(),
        body: Column(
          children: <Widget>[
            // _buildsearchBar(),
            // SizedBox(
            //   height: 20.0,
            // ),
            Expanded(child: _infoList()),
          ],
        ),
      ),
    );
  }

  Widget _infoList() {
    return BlocBuilder<BasicInfoCubit, BasicInfoState>(builder: (context, state) {
      if (state is BasicInfoLoading) {
        return _loadingIndicator();
      }

      if (state is BasicInfoLoaded) {
        return Stack(
          children: [
            ListView.separated(
                padding: EdgeInsets.only(top: 80),
                itemBuilder: (context, index) {
                  return _details(state.basicInfoList[index], context);
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    color: Colors.white,
                    height: 0,
                  );
                },
                itemCount: state.basicInfoList.length + (0)),
            Container(
              // color: Color(0xffFAFAFA),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Card(
                  child: TextFormField(
                    onChanged: (value) {
                      context.read<BasicInfoCubit>().search(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search here',
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      prefixIcon: Icon(
                        Icons.search,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      }

      return Container();
    });
  }

  Widget _loadingIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Widget _details(ItemResponse item, BuildContext context) {
    return Padding(
      key: ValueKey(item.id),
      padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 8),
      child:
         InkWell(
          onTap: () {
            // Navigator.pushNamed(context, Survey_Screen_ROUTE,
            //     arguments: diarist.id);
          },
          onLongPress: () {
            // Navigator.pushNamed(context, EditProfilePage.ROUTE,
            //     arguments: diarist.id);
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 12,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item.id.toString(),
                      style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),

                    Text(

                      item!.title.substring(0,item.title.length~/2),
                      style: Theme.of(context).textTheme.bodyText2,
                    )
                  ],
                )
              ],
            ),
          ),
        ),

    );

  }
}


