# ECA0901 DSP Assignment - Biomedical Multirate Fixed-Point Filtering

**Student:** Dhinakaran. S  
**Reg. No.:** 192412353  
**Course:** ECA0901 - Digital Signal Processing

## Title
Design and Real-Time Implementation of a Low-Power, Multirate Fixed-Point Filtering Framework for Biomedical Signal (ECG/EEG) Denoising and Point-of-Care Diagnostics

## What this repository contains
- `report/` - final technical report in PDF and DOCX
- `matlab/` - MATLAB design, multirate and fixed-point scripts
- `c/` - portable Q15 FIR reference implementation for an ARM Cortex-M7/STM32H7-class target
- `data/` - reproducible synthetic ECG dataset and source description
- `results/` - metrics and figures used in the report
- `python/` - optional analysis helper

## Reproducibility
1. Open MATLAB and run the scripts in `matlab/` in order.
2. The included CSV contains a reproducible synthetic ECG-like signal with controlled baseline wander, 50 Hz interference and EMG-like noise.
3. The C file is a hardware-portable fixed-point kernel; no physical board execution is claimed in this submission.

## Design summary
- Sample rate: **360 Hz**
- Primary passband: **0.5-45 Hz**
- Primary FIR: **81-tap Hamming-window band-pass**
- Alternative FIR: **81-tap Kaiser-window band-pass (beta=8.6)**
- IIR benchmark: **4th-order Butterworth band-pass**
- Multirate factor: **M=2**
- Fixed-point format: **Q15** with 20% headroom and 64-bit accumulator
- Target architecture: **ARM Cortex-M7/STM32H7-class comparable platform**

## Important engineering note
The assignment asks for real-time DSP processor implementation and performance analysis. No physical TMS320C5x/ARM board was available in this working environment, so the report explicitly labels processor execution, latency and power figures as **analytical/assumption-based**, not measured hardware results. This avoids presenting simulated values as physical measurements.
