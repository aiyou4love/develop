#include <spdlog/sinks/stdout_color_sinks.h>
#include <spdlog/sinks/daily_file_sink.h>

#include <spdlog/spdlog.h>

#include <iostream>
#include <string>
#include <deque>

using std::cin;
using std::cout;
using std::endl;
using std::string;

int main(int argc, char *argv[])
{
    auto console_sink = std::make_shared<spdlog::sinks::stdout_color_sink_mt>();
    console_sink->set_level(spdlog::level::info);
    console_sink->set_pattern("[multi_sink_example] [%^%l%$] %v");

    auto file_sink = std::make_shared<spdlog::sinks::daily_file_sink_mt>("logfile.log", 23, 59);
    file_sink->set_level(spdlog::level::info);

    spdlog::logger logger("multi_sink", {console_sink, file_sink});
    logger.set_level(spdlog::level::info);
    logger.warn("this should appear in both console and file");
    logger.info("this message should not appear in the console, only in the file");
    logger.flush();
    cin.get();
    return 0;
}
