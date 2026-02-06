# enzyme-kinetics-analysis
Computational pipeline for enzyme kinetics analysis using R - bridging wet lab and bioinformatics

## Overview

This project demonstrates the integration of biochemistry and bioinformatics by creating an automated computational pipeline for enzyme kinetics analysis. The pipeline analyzes amylase activity data and performs Michaelis-Menten curve fitting with parameter estimation.

## Motivation

As a biochemist entering the field of bioinformatics, I'm building skills that bridge wet lab experimental work with computational data analysis. This project showcases:
- Understanding of enzyme kinetics (biochemistry foundation)
- Ability to implement statistical modeling in R
- Creation of publication-quality visualizations
- Reproducible research practices

## Key Features

✅ **Michaelis-Menten Analysis**
- Automated curve fitting using non-linear regression
- Parameter estimation (Km and Vmax)
- Statistical validation

✅ **Temperature Optimization**
- Comparative analysis across multiple conditions
- Identification of optimal enzyme activity parameters

✅ **Professional Visualizations**
- Publication-ready plots
- Clear data presentation
- Automated figure generation

## Results

### Enzyme Kinetics
- **Km:** 9.78 mM (substrate concentration at half-maximal velocity)
- **Vmax:** 49.19 μmol/min (maximum enzyme velocity)

### Optimal Conditions
- **Temperature:** 45°C showed highest enzyme activity
- Activity decreased at both lower (25°C) and higher (55°C) temperatures

## Technologies Used

- **R** (v4.x)
- **drc** package - dose-response curve fitting
- **ggplot2** - data visualization
- **dplyr** - data manipulation

## Applications

This pipeline is relevant for:
- Food biotechnology (starch processing with amylase)
- Industrial enzyme optimization
- Quality control in enzyme production
- Research and development
- Educational demonstrations of enzyme kinetics
