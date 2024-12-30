import 'dart:io';
import 'package:vania/vania.dart';
import 'create_products_table.dart';

import 'create_users_table.dart';
import 'create_personal_access_tokens_table.dart';

void main(List<String> args) async {
  await MigrationConnection().setup();

  if (args.isNotEmpty && args.first.toLowerCase() == "migrate:fresh") {
    await Migrate().dropTables();
  } else {
    await Migrate().registry();
  }

  await MigrationConnection().closeConnection();
  exit(0);
}

class Migrate {
  registry() async {
		
    await CreateProductsTable().up();

		 await CreateUsersTable().up();
		 await CreatePersonalAccessTokensTable().up();
	}

  dropTables() async {
		 await CreatePersonalAccessTokensTable().down();
		 await CreateUsersTable().down();

    await CreateProductsTable().down();
	 }
}