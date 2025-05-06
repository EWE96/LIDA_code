

library(dplyr)
library(ggplot2)
library(ggcorrplot)

#import data

setwd('//') #set path to file

data_r <- read_excel('dummy_data.xlsx', sheet = 'red')


#average across trials for each participant


data_r_av <- data_r %>%
  group_by(Sub, Measurement_time, Adaptation_duration) %>%
  summarise(mean_UY = mean(Wavelength, na.rm = TRUE), .groups = 'drop')


#define factors


data_r_av$Adaptation_duration <- factor(data_r_av$Adaptation_duration,
                                        levels = c(1,2,3), 
                                        labels = c("15m", "60m", "240m"))
data_r_av$Measurement_time <- factor(data_r_av$Measurement_time,
                                        levels = c(1,2,3), 
                                        labels = c("pre", "5-post", "60-post"))


#pivot formatting to columns for each condition

red_temp <- data_r_av %>%
  filter(Measurement_time %in% c("pre", "5-post"))

red_temp <- red_temp %>%
  pivot_wider(
    id_cols = c(Sub, Adaptation_duration),
    names_from = Measurement_time,
    values_from = mean_UY
  ) %>%
  mutate(UY_diff = `5-post` - pre)

#Pivot wider to get one column per adaptation duration

red <- red_temp %>%
  pivot_wider(
    id_cols = Sub,
    names_from = Adaptation_duration,
    values_from = UY_diff,
    names_prefix = "diff_"
  )


# Graphs ------------------------------------------------------------------


#graph 15 vs 60 red

r_15_60 <- ggplot(red, aes(x = diff_15m, y = diff_60m)) +
  geom_point() +
  geom_smooth(
    data = red,
    aes(x = diff_15m, y = diff_60m),
    method = lm,
    se = F,
    color = 'black'
  ) +
  xlab("UY shift 15m (nm)") +
  ylab("UY shift 60m (nm)") +
  ylim(0,18) +
  xlim(0,16) +
  theme_bw(base_size = 14) +
  theme(panel.grid = element_blank())

#graph 15 vs 240 red

r_15_240 <- ggplot(red, aes(x = diff_15m, y = diff_240m)) +
  geom_point() +
  geom_smooth(
    data = red,
    aes(x = diff_15m, y = diff_240m),
    method = lm,
    se = F,
    color = 'black'
  ) +
  xlab("UY shift 15m (nm)") +
  ylab("UY shift 240m (nm)") +
  ylim(0,18) +
  xlim(0,16) +
  theme_bw(base_size = 14) +
  theme(panel.grid = element_blank())

#graph 60 vs 240 red

r_60_240 <- ggplot(red, aes(x = diff_60m, y = diff_240m)) +
  geom_point() +
  geom_smooth(
    data = red,
    aes(x = diff_60m, y = diff_240m),
    method = lm,
    se = F,
    color = 'black'
  ) +
  xlab("UY shift 60m (nm)") +
  ylab("UY shift 240h (nm)") +
  ylim(0,18) +
  xlim(0,16) +
  theme_bw(base_size = 14) +
  theme(panel.grid = element_blank())


#put graphs together

allcorrs <- ggarrange(r_15_60, r_15_240, r_60_240,ncol = 3, nrow = 1)


# Correlations ------------------------------------------------------------


#correlation matrix red

vars_red <- dplyr::select(red, diff_15m, diff_60m, diff_240m)
cor_mat_red <- cor(vars_red)

##plot
cor_plot_red <- ggcorrplot(cor_mat_red)

