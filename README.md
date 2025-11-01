🧪 Distillation Column Performance Analysis

This project focuses on the performance analysis of a simulated distillation column using MATLAB. A sensor dataset containing 961 time steps and 19 process variables was analyzed to understand the relationships between operational parameters such as reflux ratio, pressure, liquid holdup, tray temperatures, and overall separation efficiency.
📘 Project Overview

The distillation column is a key unit operation in chemical industries, and its performance depends on various operational and design parameters.
This project aims to:

Analyze multi-variable time-series data from a simulated column.

Identify the parameters most influencing separation efficiency.

Develop predictive models for top and bottom product purities.

🧩 Dataset Description

Source: Simulated distillation column dataset (self-generated for academic research)

Size:

Time Steps: 961

Variables: 19

Key Parameters:

Process Conditions: Condenser Pressure, Reboiler Pressure, Feed Temperature, Feed Flowrate

Composition Data: Feed Mole Fraction, Distillate Composition, Bottom Composition

Dynamic States: Liquid Holdup, Tray Temperatures, Reflux Ratio
⚙️ Methodology

Data Preprocessing

Handled missing/null values and removed redundant variables.

Scaled features using normalization for better regression stability.

Conducted correlation mapping to identify dominant factors.

Exploratory Data Analysis (EDA)

Visualized variations of tray temperature and reflux ratio over time.

Studied trends and correlations between process parameters.

Model Development

Implemented Multivariate Linear Regression in MATLAB.

Evaluated performance using R², RMSE, and residual plots.

Identified strong dependencies between reflux ratio, feed composition, and purity.

Model Validation

Achieved R² = 0.93 for purity prediction.

Verified model robustness using unseen time-step data samples.

📊 Results & Insights

The reflux ratio and feed mole fraction were found to be the most influential parameters on separation efficiency.

Top and bottom product purities were predicted accurately with minimal deviation (<7%).

The model provides valuable insights for process optimization in real-time column operations.

🛠️ Tech Stack

MATLAB R2023a — for modeling, regression, and visualization

Microsoft Excel — for dataset cleaning and structure validation

Python (optional) — for cross-verification using Pandas & Scikit-learn
