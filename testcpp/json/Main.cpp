#include <rapidjson/rapidjson.h>
#include <rapidjson/stringbuffer.h>
#include <rapidjson/document.h>
#include <rapidjson/writer.h>

#include <deque>
#include <iostream>
#include <string>

using std::cin;
using std::cout;
using std::deque;
using std::endl;
using std::string;

#define RAPIDJSONSTR(x) rapidjson::Value::StringRefType(x)
#define RAPIDJSONALLOC mDocument.GetAllocator()

int main(int argc, char *argv[])
{
    rapidjson::Document mDocument(rapidjson::kObjectType);
    rapidjson::Value *mValue = &mDocument;

    deque<rapidjson::Value *> mValues;
    {
        mValues.push_back(mValue);
        rapidjson::Value value_(rapidjson::kObjectType);
        mValue->AddMember(RAPIDJSONSTR("myclass1"), value_, RAPIDJSONALLOC);
        mValue = &((*mValue)["myclass1"]);

        mValue->AddMember(RAPIDJSONSTR("int32"), 64, RAPIDJSONALLOC);

        string name("constchar");
        string value("helloworld");
        mValue->AddMember(RAPIDJSONSTR(name.c_str()), RAPIDJSONSTR(value.c_str()), RAPIDJSONALLOC);
        mValue->AddMember("test111", "value222", RAPIDJSONALLOC);

        mValue = mValues.back();
        mValues.pop_back();
    }

    {
        {
            mValues.push_back(mValue);
            rapidjson::Value value_(rapidjson::kArrayType);
            mValue->AddMember(RAPIDJSONSTR("myarray1"), value_, RAPIDJSONALLOC);
            mValue = &((*mValue)["myarray1"]);
        }
        {
            mValues.push_back(mValue);
            rapidjson::Value value_(rapidjson::kObjectType);
            mValue->PushBack(value_, RAPIDJSONALLOC);
            mValue = &((*mValue)[mValue->Size() - 1]);
        }
        {
            mValues.push_back(mValue);
            rapidjson::Value value_(rapidjson::kArrayType);
            mValue->AddMember(RAPIDJSONSTR("myarray2"), value_, RAPIDJSONALLOC);
            mValue = &((*mValue)["myarray2"]);

            mValue->PushBack(800, RAPIDJSONALLOC);

            mValue = mValues.back();
            mValues.pop_back();
        }
        {
            mValue = mValues.back();
            mValues.pop_back();
        }
        {
            mValue = mValues.back();
            mValues.pop_back();
        }
        {
            rapidjson::StringBuffer stringBuffer_;
            rapidjson::Writer<rapidjson::StringBuffer> writer_(stringBuffer_);
            mDocument.Accept(writer_);
            cout << stringBuffer_.GetString() << endl;
        }
    }
    cin.get();
    return 0;
}
