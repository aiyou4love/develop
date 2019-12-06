#include <rapidxml/rapidxml_print.hpp>
#include <rapidxml/rapidxml_utils.hpp>
//#include <rapidxml/rapidxml_iterators.hpp>
#include <rapidxml/rapidxml.hpp>

#include <deque>
#include <iostream>
#include <string>

using rapidxml::node_element;
using rapidxml::node_pi;
using rapidxml::xml_attribute;
using rapidxml::xml_document;
using rapidxml::xml_node;
using std::cin;
using std::cout;
using std::endl;
using std::string;

int main(int argc, char *argv[])
{
    xml_document<char> mXmlDocument;
    xml_node<char> *mXmlNode = nullptr;
    {
#define XMLHEAD "xml version='1.0' encoding='utf-8'"
        char *xmlHeader_ = mXmlDocument.allocate_string(XMLHEAD);
        xml_node<char> *xmlNode_ =
            mXmlDocument.allocate_node(node_pi, xmlHeader_);
        mXmlDocument.append_node(xmlNode_);

        xml_node<char> *xmlNode1_ =
            mXmlDocument.allocate_node(node_element, "myroot", nullptr);
        mXmlDocument.append_node(xmlNode1_);
        mXmlNode = xmlNode1_;
    }
    {
        xml_node<char> *xmlNode_ =
            mXmlDocument.allocate_node(node_element, "myclass", nullptr);
        mXmlNode->append_node(xmlNode_);
        mXmlNode = xmlNode_;

        xml_attribute<char> *xmlAttribute_ =
            mXmlDocument.allocate_attribute("name1", "value1");
        mXmlNode->append_attribute(xmlAttribute_);

        mXmlNode = mXmlNode->parent();
    }

    string result_;
    rapidxml::print(back_inserter(result_), mXmlDocument, 0);
    cout << result_ << endl;

    cin.get();
    return 0;
}
