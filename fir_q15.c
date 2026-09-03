/*
 * ECA0901 DSP Assignment
 * Portable Q15 FIR filter reference for ARM Cortex-M7 / STM32H7-class targets.
 * No hardware-specific HAL calls are used; integrate fir_q15_process() into ISR/DMA code.
 */
#include <stdint.h>
#include <stddef.h>
#include <limits.h>

#define Q15_ONE 32768
#define FIR_TAPS 81

typedef struct {
    int16_t coeff[FIR_TAPS];
    int16_t state[FIR_TAPS];
    size_t index;
} fir_q15_t;

static int16_t sat16(int64_t x) {
    if (x > 32767) return 32767;
    if (x < -32768) return -32768;
    return (int16_t)x;
}

static int16_t q15_round_shift(int64_t acc) {
    if (acc >= 0) return sat16((acc + (1LL << 14)) >> 15);
    return sat16(-(((-acc) + (1LL << 14)) >> 15));
}

void fir_q15_init(fir_q15_t *f, const int16_t *coeff) {
    for (size_t i = 0; i < FIR_TAPS; ++i) {
        f->coeff[i] = coeff[i];
        f->state[i] = 0;
    }
    f->index = 0;
}

int16_t fir_q15_process(fir_q15_t *f, int16_t x) {
    f->state[f->index] = x;
    int64_t acc = 0; /* Q30 accumulator; 64-bit prevents multi-tap overflow */
    size_t p = f->index;
    for (size_t k = 0; k < FIR_TAPS; ++k) {
        acc += (int64_t)f->coeff[k] * (int64_t)f->state[p];
        if (p == 0) p = FIR_TAPS - 1;
        else --p;
    }
    f->index++;
    if (f->index == FIR_TAPS) f->index = 0;
    return q15_round_shift(acc);
}

/*
 * Integration notes:
 * 1. Acquire ECG samples using ADC/AFE + DMA.
 * 2. Apply block scaling so |x| <= 0.8 before Q15 conversion.
 * 3. Call fir_q15_process() for each sample in the real-time ISR/task.
 * 4. Decimate by 2 after anti-alias filtering when bandwidth permits.
 * 5. Send filtered samples to diagnostic/communication layer.
 */
