
library(dplyr)

#import data

setwd('//') #set path to file

datafile <- read_excel('dummy_data.xlsx', sheet = 'red')

#tidy dataframe

datafile[ ,c(5:11)] <- list(NULL)

#define a new variable 'trial' in the dataframe

trialnos <- c(1:10)

trials <- rep(trialnos, times = 99)

datafile$Trial = trials

#define measurement time as a factor

datafile$Measurement_time <- factor(datafile$Measurement_time, levels = c('1','2','3'), 
                                    labels = c('pre','5-post','60-post'))



# Statistics --------------------------------------------------------------

#perform ANOVA on trial ~ measurement time

trial_aov <- aov_ez('Sub', 
                    'Wavelength', 
                    datafile, 
                    within = c('Trial', 'Measurement_time'), 
                    anova_table = list('pes'))

#linear regression

post_red <- datafile %>% filter(Measurement_time == '5-post')

lm_red <- lm(Wavelength ~ Trial, data = post_red)


# Graph -------------------------------------------------------------------


#average across subjects

averageddata <- datafile %>% 
  group_by(Measurement_time, Trial) %>%
  summarise(mean_wavelength = mean(Wavelength, na.rm = TRUE), .groups = "drop")

#red graph

trialplt_r <- ggplot(averageddata, 
                   aes(x = Trial, y = mean_wavelength, linetype = Measurement_time)) +
  geom_line() +
  geom_point() +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black")) +
  labs(y = "Unique Yellow Wavelength",
       linetype = "Measurement Time") +
  ylim(570,586) + 
  scale_x_continuous(breaks = seq(0,10,1))


# Extrapolation -----------------------------------------------------------


slope_red <- -0.1039 #from linear regression
lasttrial_red <- post_red %>% filter(Trial == '10') %>%
  summarise(mean_wavelength = mean(Wavelength, na.rm = TRUE))
red_pre <- datafile %>% filter(Measurement_time == 'pre') %>%
  summarise(mean_wavelength = mean(Wavelength, na.rm = TRUE))

#calculate number of trials needed to return to baseline
n_additional_trials_red <- (lasttrial_red - red_pre) / slope_red


