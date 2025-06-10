#include <stdio.h>
#include <string.h>
#include <assert.h>

#define SIZE (0x8000) /* 2^15 = 32KB */

int main(void)
{
    const char *const FILENAME = "program.bin";
    FILE *outfile;
    char bin_out[SIZE] = {
        0,
    };

    const char program[] = {0xA9, 0xFF, 0x4C, 0x00, 0x80};
    /*
    unsigned char a;

    do
    {
        a = 0xFF;
    } while (1);
    */
    size_t program_size = program_size = sizeof(program) / sizeof(char);

    assert(program_size < 0x7FFC);

    memcpy(bin_out, program, program_size);
    bin_out[0x7FFC] = 0x00;
    bin_out[0x7FFD] = 0x80;

    fopen_s(&outfile, FILENAME, "wb");

    if (outfile == NULL)
    {
        fprintf(stderr, "cannot open outfile");
        return -1;
    }

    fwrite(bin_out, sizeof(char), SIZE, outfile);
    fclose(outfile);

    return 0;
}
