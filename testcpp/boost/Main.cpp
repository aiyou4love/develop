#include <cstdlib>
#include <stdlib.h>
#include <stdlib.h>
#include <string>
#include <iostream>

#include <boost/regex.hpp>

using namespace std;
using namespace boost;

regex expression("^select ([a-zA-Z]*) from ([a-zA-Z]*)"); //定义正则表达式expression

int main(int argc, char *argv[])
{
    std::string in;
    cmatch what;
    cout << "enter test string" << endl;
    getline(cin, in);
    if (regex_match(in.c_str(), what, expression)) //regex_match:匹配算法，用于测试一个字符串是否和正则式匹配
    {
        for (int i = 0; i < what.size(); i++)
            cout << "str :" << what[i].str() << endl;
    }
    else
    {
        cout << "Error Input" << endl;
    }
    system("pause");

    return 0;
}
