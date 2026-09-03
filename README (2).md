# Fixed-point embedded reference

This folder contains a portable Q15 FIR implementation intended for integration on an ARM Cortex-M7/STM32H7-class target or another DSP-class MCU.

It is **not claimed as a measured board execution**. The assignment environment did not include a physical processor board. The report therefore separates code readiness from analytical real-time estimates.

The implementation uses:
- Q15 input/coefficient representation
- 64-bit Q30 accumulation to prevent multi-tap overflow
- rounding during requantization
- a 20% signal headroom target before Q15 conversion
