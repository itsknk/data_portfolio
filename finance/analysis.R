# Load required libraries
install.packages(c("fpp2", "urca"))
library(fpp2)
library(urca)
library(dplyr)
library(readxl)
library(ivreg)
library(readr)

# Set working directory
setwd("")

# Load dataset
bitcoin_data <- read_excel("dataset.xlsx")
View(bitcoin_data)

# Summary statistics (logged and non-logged)
log_vars <- grep("^Log", names(bitcoin_data), value = TRUE)
nonlog_vars <- c("GDP(billions)", "S&P-500-Historical-Data-Price", "XLK-Historical-Data-Price",
                 "BitcoinHashRate", "BitcoinTradeVolume", "BitcoinMarketCap", "NetworkDifficulty", "BitcoinPrice")

sapply(bitcoin_data[log_vars], sd, na.rm = TRUE)
sapply(bitcoin_data[nonlog_vars], sd, na.rm = TRUE)

# Plot time series (log variables)
plot_vars <- c("LogGDP", "Log-S&P-500-Historical-Data-Price", "Log-XLK",
               "LogBitcoinHashRate", "LogBitcoinTradeVolume", "LogBitcoinMarketCap",
               "LogNetworkingDifficulty", "LogBitcoinPrice")
bitcoin_ts <- ts(bitcoin_data[plot_vars])
autoplot(bitcoin_ts)

# Unit root tests
unit_root_results <- lapply(plot_vars, function(var) {
  list(
    original = summary(ur.df(bitcoin_data[[var]], type = "drift")),
    differenced = summary(ur.df(diff(bitcoin_data[[var]]), type = "drift"))
  )
})
names(unit_root_results) <- plot_vars

# First differences
diff_vars <- c("LogGDP", "Log-S&P-500-Historical-Data-Price", "Log-XLK", "LogBitcoinPrice",
               "LogBitcoinHashRate", "LogBitcoinTradeVolume", "LogBitcoinMarketCap",
               "LogNetworkingDifficulty", "LogTotalBitcoin")
diff_names <- paste0("d", tolower(gsub("Log", "l", gsub("-", "", diff_vars))))
bitcoin_diff <- data.frame(matrix(ncol = length(diff_vars), nrow = nrow(bitcoin_data)))
colnames(bitcoin_diff) <- diff_names

for (i in 2:nrow(bitcoin_data)) {
  bitcoin_diff[i, ] <- bitcoin_data[i, diff_vars] - bitcoin_data[i - 1, diff_vars]
}

# Time series regression with tslm
bitcoin_diff <- na.omit(bitcoin_diff)
y <- ts(bitcoin_diff$dlbitcoinprice, frequency = 4)

fit1 <- tslm(y ~ dlgdp + dlSP + dlxlk + dlhashrate + dltradevolume + dlmarketcap, data = bitcoin_diff)
fit2 <- tslm(y ~ dlgdp + dlSP + dlxlk + dlhashrate + dltradevolume + dlmarketcap + trend, data = bitcoin_diff)
fit3 <- tslm(y ~ dlgdp + dlSP + dlxlk + dlhashrate + dltradevolume + dlmarketcap + trend + season, data = bitcoin_diff)

summary(fit1)
summary(fit2)
summary(fit3)

autoplot(ts(bitcoin_diff))

# Export to CSV
write.csv(bitcoin_diff, "data.csv", row.names = FALSE)

# Reload with manual season/trend vars
bitcoin_diff2 <- read_csv("data.csv")
View(bitcoin_diff2)

# IV Regression
iv_model <- ivreg(dlbitcoinprice ~ dlmarketcap + dlgdp + dlSP + dlxlk + dlhashrate + dltradevolume + trend + season2 + season3 + season4  |
                    dlnetworkdifficulty + dlhashrate + dlgdp + dlSP + dlxlk + dltradevolume + trend + season2 + season3 + season4,
                  data = bitcoin_diff2)
summary(iv_model)

# Comparison Models
models <- list(
  lm_sp = lm(dlbitcoinprice ~ dlSP, data = bitcoin_diff2),
  lm_xlk = lm(dlbitcoinprice ~ dlxlk, data = bitcoin_diff2),
  lm_spxlk = lm(dlbitcoinprice ~ dlSP + dlxlk, data = bitcoin_diff2),
  lm_controls = lm(dlbitcoinprice ~ dlSP + dlxlk + dlgdp + dlhashrate + dltradevolume, data = bitcoin_diff2),
  lm_all = lm(dlbitcoinprice ~ dlSP + dlxlk + dlgdp + dlhashrate + dltradevolume + trend + season2 + season3 + season4, data = bitcoin_diff2),
  tslm_all = tslm(ts(dlbitcoinprice, frequency = 4) ~ dlSP + dlxlk + dlgdp + dlhashrate + dltradevolume + trend + season, data = bitcoin_diff2)
)

lapply(models, summary)

