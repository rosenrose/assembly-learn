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

    const char program[] = {
        0x18,             /* clc */
        0xA9, 0x0A,       /* lda #$0A */
        0x69, 0x06,       /* adc #$06 */
        0x8D, 0x00, 0x22, /* sta $2200 */
        0XAD, 0x00, 0x22  /* lda $2200 */
    };
    size_t program_size = sizeof(program) / sizeof(char);

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
