# Emergency Room Simulation and Optimization 🏥⏱️

## Overview
This project analyzes patient flow in an emergency room (ER) to identify bottlenecks and test strategies for reducing waiting times. Using historical patient arrival data, we simulated different ER configurations to optimize doctor utilization and minimize patient flow times. Key findings and recommendations are provided to improve ER efficiency.

---

## 📊 Data Analysis
### Dataset: `Case5_emergency-room.csv`
- **Columns**: `interArrival` (time between arrivals in minutes), `type` (patient type: `NIA` for critical, `CW` for non-critical).
- **Key Insights**:
  - **Patient Distribution**: 18% critical (`NIA`), 82% non-critical (`CW`).
  - **Arrival Times**: Best fit to a **Gamma distribution** (shape = 0.964, rate = 0.064) confirmed by statistical tests (AIC/BIC, χ² p-value = 0.17).

---

## 🖥️ Simulation Setup
### Tools & Libraries
- **R** with `simmer` (discrete-event simulation), `fitdistrplus` (distribution fitting).
- **Key Assumptions**:
  - 2 doctors in the original model.
  - Patients require **two treatments** (priority given to critical cases).
  - Simulation runs for **24 hours (1440 minutes)**, repeated 20 times for robustness.

### Patient Pathways
1. **Critical (NIA)**:
   - Priority level 3 → Shorter treatment times (10–70 mins for first treatment, 10–50 mins for second).
2. **Non-Critical (CW)**:
   - Priority level 1 → Longer treatment times (5–25 mins for first treatment, 5–15 mins for second).

---

## 📈 Results
### Original Model
- **Doctor Utilization**: ~100% (overloaded).
- **Average Flow Times**:
  | Patient Type | Flow Time (mins) |
  |--------------|-------------------|
  | Critical     | 108.89            |
  | Non-Critical | 185.25            |
- **Issue**: Growing waiting times indicated an unsustainable system.

---

## 🛠️ Strategies Tested
### 1. Adding Two More Doctors (Total = 4)
- **Outcome**:
  - **Utilization**: Dropped to ~60%.
  - **Flow Times**:
    | Patient Type | Flow Time (mins) |
    |--------------|-------------------|
    | Critical     | 75.14 (↓31%)      |
    | Non-Critical | 28.07 (↓85%)      |
- **Insight**: Significant improvement but potential overstaffing.

### 2. Dedicated Queues per Patient Type
- **Outcome**:
  - **Utilization**: 80% (critical), 100% (non-critical).
  - **Flow Times**:
    | Patient Type | Flow Time (mins) |
    |--------------|-------------------|
    | Critical     | 188.79 (↑73%)     |
    | Non-Critical | 312.34 (↑69%)     |
- **Insight**: Inefficient due to imbalanced workload.

### 3. Split Roles: First vs. Final Treatment Doctors
- **Outcome**:
  - **Utilization**: 100% (first treatment), 70% (final treatment).
  - **Flow Times**:
    | Patient Type | Flow Time (mins) |
    |--------------|-------------------|
    | Critical     | 96.98 (↓11%)      |
    | Non-Critical | 239.02 (↑29%)     |
- **Insight**: Benefits critical patients at the expense of non-critical.

---

## 🎯 Recommendations
1. **Hire 1–2 Additional Doctors**: Balances flow time reduction with resource costs.
2. **Avoid Dedicated Queues**: Causes inefficiency unless staff is expanded further.
3. **Prioritize Critical Patients**: Use role-splitting if prioritizing life-threatening cases is critical.

---

## 📂 Repository Structure
- `emergency-room.csv`: Raw data.
- `analysis.Rmd`: R code for analysis and simulation.

---

## 🔧 How to Reproduce
1. Install R packages: `simmer`, `fitdistrplus`, `ggplot2`.
2. Run `analysis.Rmd` to generate simulations and plots.

---
