#include <lz4/lz4hc.h>
#include <lz4/lz4.h>

#include <cstdint>
#include <iostream>
#include <cstring>

void lz4decompress(const char *nValue, int16_t nInsize, char *nDest, int16_t &nOutsize)
{
    nOutsize = (*(int16_t *)(nValue));
    int16_t size = (int16_t)LZ4_decompress_safe(nValue + 2, nDest, nInsize - 2, nOutsize);
    if (size < 0)
    {
        std::cout << "size < 0" << std::endl;
        nOutsize = 0;
    }
}

void lz4compress(const char *nValue, int16_t nInsize, char *nDest, int16_t &nOutsize)
{
    int destSize = LZ4_compressBound(nInsize);
    nOutsize = (int16_t)LZ4_compress_default(nValue, nDest + 2, nInsize, destSize);
    if (nOutsize <= 0)
    {
        std::cout << "nOutsize <= 0" << std::endl;
        nOutsize = 0;
    }
    else
    {
        (*((int16_t *)nDest)) = nOutsize;
        nOutsize += 2;
    }
}

int main()
{
    const char *s = "hello world!";
    char v[255];
    memset(v, 0, sizeof(v));
    int16_t l = 0;
    lz4compress(s, strlen(s), v, l);
    char v1[255];
    memset(v1, 0, sizeof(v1));
    int16_t l1 = 0;
    lz4decompress(v, l, v1, l1);
    std::cout << v1 << " " << l1 << " " << strlen(s) << std::endl;
    return 0;
}