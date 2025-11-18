# Aplicando análise exploratória em um conjunto de dados

# Carregando o conjunto iris
data(iris)

# Visualizando 
str(iris)

head(iris, 10)
summary(iris)

# carregando pacotes 
library(tidyverse)
library(rstatix)

# Verificando as estatísticas agrupando por espécies

# Pétalas
iris |> 
  group_by(Species) |> 
  get_summary_stats(Petal.Length, Petal.Width)

# Sépala 
iris |> 
  group_by(Species) |>
  get_summary_stats(Sepal.Length, Sepal.Width)


# Criando um novo DF para visualizações 
newiris <- iris |>
  pivot_longer(cols = c(Sepal.Length, 
                        Sepal.Width, 
                        Petal.Length, 
                        Petal.Width),
               names_to = "Variable",
               values_to = "Value") |>
  separate(Variable, into = c("Type", "Measure"), sep = "\\.")

  
# Criando visualizações para a análise exploratória 

ggplot(newiris, aes(x = Measure, y = Value, shape = Type )) +
  geom_jitter(alpha = 0.6, width = 0.1) +
  facet_wrap(~ Species) +
  theme_classic()

ggsave("exploratoria1.png")


# Outra visualização 
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width)) +
  geom_jitter(alpha = 0.6, width = 0.1) +
  facet_wrap(~ Species) +
  theme_classic()

ggsave("exploratoria2.png")


# 
ggplot(newiris, aes(x = Measure, y = Value, color = Type)) +
  geom_jitter(alpha = 0.6, width = 0.1) +
  stat_summary(fun.data = mean_sdl, fun.args = list(mult = 1), 
               geom = "pointrange", color = "red", size = 0.3) +
  facet_wrap(~ Species) +
  theme_classic()

ggsave("exploratoria3.png")

