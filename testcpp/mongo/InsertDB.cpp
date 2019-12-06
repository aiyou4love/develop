#include <chrono>

#include <bsoncxx/builder/basic/array.hpp>
#include <bsoncxx/builder/basic/document.hpp>
#include <bsoncxx/builder/basic/kvp.hpp>
#include <bsoncxx/types.hpp>

#include <mongocxx/client.hpp>
#include <mongocxx/instance.hpp>
#include <mongocxx/uri.hpp>

using bsoncxx::builder::basic::kvp;
using bsoncxx::builder::basic::make_array;
using bsoncxx::builder::basic::make_document;

void runInsertDB()
{
	// The mongocxx::instance constructor and destructor initialize and shut down the driver,
	// respectively. Therefore, a mongocxx::instance must be created before using the driver and
	// must remain alive for as long as the driver is in use.
	mongocxx::instance inst{};
	mongocxx::client conn{mongocxx::uri{"mongodb://192.168.0.107/unseen?safe=true"}};

	auto db = conn["test"];

	// TODO: fix dates

	// @begin: cpp-insert-a-document
	bsoncxx::document::value restaurant_doc = make_document(
		kvp("grades", make_array("grade", "score", 11)),
		kvp("name", "Vella"));

	// We choose to move in our document here, which transfers ownership to insert_one()
	auto res = db["restaurants"].insert_one(std::move(restaurant_doc));
	// @end: cpp-insert-a-document

	db["restaurants"].update_one(make_document(kvp("name", "Vella")),
								 make_document(kvp("$addToSet", 
								 make_document(kvp("grades",
								 make_document(kvp("test11", "test12")))))));

	db["restaurants"].update_one(make_document(kvp("name", "Vella")),
								 make_document(kvp("$push", 
								 make_document(kvp("grades",
								 make_document(kvp("test21", "test22")))))));

	db["restaurants"].update_one(make_document(kvp("name", "Vella")),
								 make_document(kvp("$pull", 
								 make_document(kvp("grades", "score")))));
}
