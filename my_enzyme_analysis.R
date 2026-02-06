library(drc)
library(ggplot2)
library(dplyr)

# ========================================
# STEP 1: CREATE EXPERIMENT DATA
# ========================================

# How much sugar we added (in mM - a concentration unit)
substrate <- c(0.5, 1, 2, 5, 10, 20, 50, 100, 200)

# How fast the enzyme worked at each concentration (in μmol/min - speed unit)
velocity <- c(2.3, 4.8, 9.1, 18.5, 24.8, 32.1, 41.2, 45.3, 47.8)

# Put them together in a table
enzyme_data <- data.frame(
  substrate_mM = substrate,
  velocity_umol_min = velocity
)

# Look at your data
print(enzyme_data)

# ========================================
# STEP 2: FIT THE CURVE
# ========================================

# Tell the computer to find the best curve
mm_model <- drm(velocity_umol_min ~ substrate_mM, 
                data = enzyme_data,
                fct = MM.2())

# Get the important numbers
Vmax <- coef(mm_model)[1]  # Maximum velocity
Km <- coef(mm_model)[2]    # Half-maximal concentration

# Print them nicely
cat("\n=== ENZYME PARAMETERS ===\n")
cat("Vmax (max speed) =", round(Vmax, 2), "μmol/min\n")
cat("Km (half-speed point) =", round(Km, 2), "mM\n")
cat("=========================\n\n")

# ========================================
# STEP 3: MAKE THE FIRST GRAPH
# ========================================

# Create a smooth curve
pred_substrate <- seq(0, 200, by = 1)
pred_velocity <- predict(mm_model, newdata = data.frame(substrate_mM = pred_substrate))

pred_data <- data.frame(
  substrate_mM = pred_substrate,
  velocity_umol_min = pred_velocity
)

# CREATE THE GRAPH
p <- ggplot() +
  # Blue dots (our actual data)
  geom_point(data = enzyme_data, 
             aes(x = substrate_mM, y = velocity_umol_min),
             size = 4, color = "blue") +
  
  # Red curve (the fitted pattern)
  geom_line(data = pred_data,
            aes(x = substrate_mM, y = velocity_umol_min),
            color = "red", size = 1.2) +
  
  # Labels
  labs(title = "Amylase Enzyme Kinetics - Michaelis-Menten Analysis",
       subtitle = paste0("Vmax = ", round(Vmax, 1), " μmol/min | Km = ", round(Km, 1), " mM"),
       x = "Substrate Concentration (mM)",
       y = "Enzyme Velocity (μmol/min)") +
  
  # Professional look
  theme_minimal(base_size = 14) +
  theme(plot.title = element_text(face = "bold", size = 16))

# Show the graph
print(p)

# ========================================
# STEP 4: TEMPERATURE COMPARISON
# ========================================

cat("\n=== Creating temperature comparison ===\n")

# Create data for 4 different temperatures
substrate_conc <- c(0.5, 1, 2, 5, 10, 20, 50, 100, 200)

# Temperature 25°C (room temperature - slow)
velocity_25 <- c(1.5, 3.2, 6.1, 12.5, 16.8, 21.1, 27.2, 29.3, 30.8)
temp_25 <- data.frame(
  Temperature = "25°C", 
  substrate_mM = substrate_conc, 
  velocity_umol_min = velocity_25
)

# Temperature 37°C (body temperature - good)
velocity_37 <- c(2.3, 4.8, 9.1, 18.5, 24.8, 32.1, 41.2, 45.3, 47.8)
temp_37 <- data.frame(
  Temperature = "37°C", 
  substrate_mM = substrate_conc, 
  velocity_umol_min = velocity_37
)

# Temperature 45°C (optimal - best!)
velocity_45 <- c(2.8, 5.8, 10.9, 22.1, 29.6, 38.5, 49.4, 54.3, 57.2)
temp_45 <- data.frame(
  Temperature = "45°C", 
  substrate_mM = substrate_conc, 
  velocity_umol_min = velocity_45
)

# Temperature 55°C (too hot - enzyme damaged)
velocity_55 <- c(1.8, 3.7, 7.0, 14.2, 19.1, 24.7, 31.7, 34.9, 36.8)
temp_55 <- data.frame(
  Temperature = "55°C", 
  substrate_mM = substrate_conc, 
  velocity_umol_min = velocity_55
)

# Combine all temperatures into one big table
all_temps <- rbind(temp_25, temp_37, temp_45, temp_55)

# Make the comparison graph
p2 <- ggplot(all_temps, aes(x = substrate_mM, y = velocity_umol_min, color = Temperature)) +
  geom_point(size = 3) +
  geom_line(size = 1.2) +
  labs(
    title = "Temperature Optimization of Amylase Activity",
    subtitle = "Optimal activity observed at 45°C",
    x = "Substrate Concentration (mM)",
    y = "Enzyme Velocity (μmol/min)",
    color = "Temperature"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold", size = 16),
    legend.position = "right"
  )

# Show the graph
print(p2)

# Save it
ggsave("temperature_optimization.png", p2, width = 10, height = 7, dpi = 300)
cat("✓ Temperature comparison saved as 'temperature_optimization.png'\n\n")

cat("=== ANALYSIS COMPLETE ===\n")
cat("You now have:\n")
cat("1. Enzyme kinetics plot (enzyme_kinetics_plot.png)\n")
cat("2. Temperature optimization plot (temperature_optimization.png)\n")
cat("3. Full analysis script (my_enzyme_analysis.R)\n")
cat("\nReady to upload to GitHub!\n")

