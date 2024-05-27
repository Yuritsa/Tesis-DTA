#Código en R para el análisis y visualización de datos
#registrados con un sistema de camáras del movimiento 
#en 3D de actuadores suaves, que fueron diseñados para el
#trabajo de grado de doctorado de Yuritsa Páez
#IPN, UPIITA.

library(tidyverse)
library(ggplot2)
library(scales)

pruebas <- readr::read_csv("./Pruebas24oct2023_todas.csv")
type.convert(pruebas, as.is = TRUE) 

PROMEDIO_Z_B1 <- as.numeric(pruebas$"PROMEDIO Z_B1")
PROMEDIO_X_B2 <- as.numeric(pruebas$"PROMEDIO X_B2")
PROMEDIO_Y_B2 <- as.numeric(pruebas$"PROMEDIO Y_B2")
PROMEDIO_Z_B2 <- as.numeric(pruebas$"PROMEDIO Z_B2")

datos <- data.frame(t = pruebas$Tiempo_Segundos, x1 = pruebas$PROMEDIOX_B1, y1 = pruebas$PROMEDIOY_B1,
                          z1 = PROMEDIO_Z_B1, x2 = PROMEDIO_X_B2, y2 = PROMEDIO_Y_B2,
                          z2 = PROMEDIO_Z_B2)

# Máximo, minimo, promedio y desviación standar para x, body 1

x1 <- datos |> 
  summarize(max = max(x1, na.rm = TRUE),
            min = min(x1, na.rm = TRUE),
            media = mean(x1, na.rm = TRUE),
            mediana = median(x1, na.rm = TRUE),
            desv = sd(x1, na.rm = TRUE))

# Máximo, minimo, promedio y desviación standar para y, body 1
y1 <- datos |> 
  summarize(max = max(y1, na.rm = TRUE),
            min = min(y1, na.rm = TRUE),
            media = mean(y1, na.rm = TRUE),
            mediana = median(y1, na.rm = TRUE),
            desv = sd(y1, na.rm = TRUE))

# Máximo, minimo, promedio y desviación standar para z, body 1
z1 <- datos |> 
  summarize(max = max(z1, na.rm = TRUE),
            min = min(z1, na.rm = TRUE),
            media = mean(z1, na.rm = TRUE),
            mediana = median(z1, na.rm = TRUE),
            desv = sd(z1, na.rm = TRUE))

# Máximo, minimo, promedio y desviación standar para x, body 2
x2 <- datos |> 
  summarize(max = max(x2, na.rm = TRUE),
            min = min(x2, na.rm = TRUE),
            media = mean(x2, na.rm = TRUE),
            mediana = median(x2, na.rm = TRUE),
            desv = sd(x2, na.rm = TRUE))
# Máximo, minimo, promedio y desviación standar para y, body 2
y2 <- datos |> 
  summarize(max = max(y2, na.rm = TRUE),
            min = min(y2, na.rm = TRUE),
            media = mean(y2, na.rm = TRUE),
            mediana = median(y2, na.rm = TRUE),
            desv = sd(y2, na.rm = TRUE))

# Máximo, minimo, promedio y desviación standar para z, body 2
z2 <- datos |> 
  summarize(max = max(z2, na.rm = TRUE),
            min = min(z2, na.rm = TRUE),
            media = mean(z2, na.rm = TRUE),
            mediana = median(z2, na.rm = TRUE),
            desv = sd(z2, na.rm = TRUE))

#write.csv(datos, "datos.csv") para guardar y exportar los datos

# Gráfico de densidad de los datos
# Para cambiar la variable sólo modifica la var x
# se puede obtener cualquier gráfico de densidad 

ggplot(datos, aes(x = x2)) +
  geom_density(fill = "blue", alpha = 0.5) +  
  labs(title = "Densidad de los datos en X para el cuerpo rígido 2",
       x = "Datos registrados del movimiento en x2 (mm)",
       y = "Densidad") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5, size = 16),
        axis.title = element_text(size = 14),
        axis.text = element_text(size = 14)) 

# Transformar los datos al formato largo 
# para obtener facet de los dos gráficos (comparativos)
datos_dens <- datos %>%
  pivot_longer(cols = c(x1, x2), names_to = "variable", values_to = "value")

# Crear el gráfico de densidad con facet_wrap
ggplot(datos_dens, aes(x = value, fill = variable)) +
  geom_density(alpha = 0.5) +
  facet_wrap(~ variable, scales = "free_x") +
  labs(title = "Gráficos de Densidad para x1 y x2", x = "Valor", y = "Densidad") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5, size = 16),
        axis.title = element_text(size = 14),
        axis.text = element_text(size = 14)) 

# Crear el gráfico de densidad con ambas curvas superpuestas
ggplot(datos_dens, aes(x = value, fill = variable, color = variable)) +
  geom_density(alpha = 0.5) +
  labs(title = "Gráficos de Densidad para x1 y x2", 
       x = "Valor (mm)", 
       y = "Densidad") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5, size = 16),
        axis.title = element_text(size = 14),
        axis.text = element_text(size = 14),
        legend.text = element_text(size = 14),
        legend.title = element_text(size = 14)) 

## Crear un marco de datos largo para gráficar boxplot
datos_long <- datos %>%
  pivot_longer(cols = c(z1, z2), names_to = "variable", values_to = "value")

# Crear el boxplot con jitter x para el cuerpo rígido 1 y 2
ggplot(datos_long, aes(x = variable, y = value)) +
  geom_boxplot(fill = "#FFB5C5", alpha = 0.5) +
  geom_jitter(position = position_jitter(width = 0.3), alpha = 0.2) +  # Agregar puntos dispersos (jitter)
  labs(title = " Boxplot de los datos para los cuerpos rígido",
    x = "Variables",
    y = "Valor en mm") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5, size = 16),
        axis.title = element_text(size = 14),
        axis.text = element_text(size = 14)) 

# Para todas las variables

# Transformar los datos al formato largo
datos_long <- datos %>%
  select(-t) %>%  # Excluir la columna 't'
  pivot_longer(cols = everything(), names_to = "variable", values_to = "value")
# Crear el boxplot para todas las variables
ggplot(datos_long, aes(x = variable, y = value)) +
  geom_boxplot() +
  geom_jitter(width = 0.2, alpha = 0.2) +  # Agregar puntos dispersos (jitter)
  labs(x = "Variable", y = "Valor") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Rotar las etiquetas del eje x


