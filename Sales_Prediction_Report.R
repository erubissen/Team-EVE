################################################################################
# Project Name : Variables affecting Sales of commercial district              # 
# Project type : Regression Analysis                                           #
# Date         : 2018/04/07                                                    #
# By           : Team Ev??                                                      #
################################################################################


# 1. ??£?ê¶ï§? ?ê½ç§»? (Install and call library for necessary packages) ----

install.packages("readxl")
install.packages("writexl")
install.packages("dplyr")
install.packages("data.table")
install.packages("car")
install.packages("gvlma")
install.packages("lm.beta")
install.packages("lmtest")
install.packages("magrittr")
install.packages("tidyverse")
library(readxl)
library(writexl)
library(dplyr)
library(data.table)
library(car)
library(gvlma)
library(lm.beta)
library(lmtest)
library(magrittr)
library(tidyverse)

# 2. ?ëµ??? ???±? ?ê½???  (Set Directory) ----
setwd(dir = "C:/Users/eljuw/Desktop/Team EVE/")
getwd()


# 3. ??²?? ?ê½? ?º??­??¤æ¹?? (Read Data) ----

# ï§¡ë©¸?? : ??²?? ?ê½??? ?ê½???±?? ?¨ë¦?¬??²?? ?ê½£ç? ?ê¶???
#        ?ê½???±???ë¿´ç±ê³ë²?? ?ê½£æ¿ë¬ì£??½ ?ê½???±?? ?¨â¤??ê¸½æ²? ?ë´½æ¿¡????ª ?? è¹ë?½ ?ê¸½æ²?­?µ ?ê¸½æ²?®ê°???ï§Â??½ ??²?? ?ê½??ë±???£ ?? ??
#        ??²?? ?ê½??? 2015??éº??ê½? 2018??? 1??¡æºë¯?? è­°ë?±?ë¸???
#        RStudio?ë¿??ê½? encoding ??¤???? è«â¹???ë¸?æ¹?? ???ë¹? ï§â¤ë±? ????ªï§ë?£ ??º?ë¼±æ¿¡? ???? ?ë¸?æ¹?? ???ë¹?
#        ?ê¸½æ²?¯?½ ?ë¿????? Commercial_ æ¿??, è«ê³ ?ï§Â ?ë¿????? Hinter_æ¿?? ?ê½??? 
#        ?ë¸????? = N_Aparts, ï§ë¬ì»????ê½? = N_Facs, ?? ?ë£??? = N_Store,
#        ????ë£???¤?´? = F_Pop, ?ê¸½äº?±?¤?´? = S_Pop, ï§ê³¸?£??¤?´? = W_Pop, ?°ë¶¿ì ï§ã¼?§ = Sales, ??¼?ë±???¼?®? = Income_Spend
#
# 
# äºì±ê½?
# ?ê¸½æ²? : Commercial District, ?ê¸½æ²?®ê°???ï§Â : Hinterland, ?ë¸????? : Number of Aparments, 
# ï§ë¬ì»????ê½? : Number of Gathering Facilities ????ë£???¤?´? = Floating Population, ?ê¸½äº?±?¤?´? : Settled Population
# ï§ê³¸?£??¤?´? : Working Population, ?°ë¶¿ì ï§ã¼?§ : Estimated Sales, ??¼?ë±?/??¼?®? : Income and Spend

# ?ê¸½æ²? ????²?? ?ê½? ?º??­??¤æ¹??

C_Sales         <- read_excel(path = "Commercial_Sales.xlsx", sheet = 1, col_names = TRUE)
C_N_Aparts      <- read_excel(path = "Commercial_N_Aparts.xlsx", sheet = 1, col_names = TRUE)
C_N_Facs        <- read_excel(path = "Commercial_N_Facs.xlsx", sheet = 1, col_names = TRUE)
C_N_Store       <- read_excel(path = "Commercial_N_Store.xlsx", sheet = 1, col_names = TRUE)
C_Income_Spend  <- read_excel(path = "Commercial_Income_Spend.xlsx", sheet = 1, col_names = TRUE)
C_F_Pop         <- read_excel(path = "Commercial_F_Pop.xlsx", sheet = 1, col_names = TRUE)
C_S_Pop         <- read_excel(path = "Commercial_S_Pop.xlsx", sheet = 1, col_names = TRUE)
C_W_Pop         <- read_excel(path = "Commercial_W_Pop.xlsx", sheet = 1, col_names = TRUE)

# è«ê³ ?ï§Â ????²?? ?ê½? ?º??­??¤æ¹??

H_N_Aparts      <- read_excel(path = "Hinter_N_Aparts.xlsx", sheet = 1, col_names = TRUE)
H_N_Facs        <- read_excel(path = "Hinter_N_Facs.xlsx", sheet = 1, col_names = TRUE)
H_N_Store       <- read_excel(path = "Hinter_N_Store.xlsx", sheet = 1, col_names = TRUE)
H_Income_Spend  <- read_excel(path = "Hinter_Income_Spend.xlsx", sheet = 1, col_names = TRUE)
H_F_Pop         <- read_excel(path = "Hinter_F_Pop.xlsx", sheet = 1, col_names = TRUE)
H_S_Pop         <- read_excel(path = "Hinter_S_Pop.xlsx", sheet = 1, col_names = TRUE)
H_W_Pop         <- read_excel(path = "Hinter_W_Pop.xlsx", sheet = 1, col_names = TRUE)

# ????ª??  ?? £???æ¿¡ìë§? ??????æ¿?? ?ë§å¯ê»ì£ ????¤?ë¸?æ¹?? ???ë¸??ë¿? Structure?? ????¤
str(C_Sales) 
# tbl_df ??????æ¿?? ??²?? ?ê½? ?ë´??? ??«??æ¿?? ?º??­ï§ê¾§ì¾???£ ????¤


# 4. ??²?? ?ê½? ??¾ï§£ì? (Preproecessing of Data) ----

# ?º??­??© ??²?? ?ê½??ë±???? Raw Dataæ¿¡ì?¥ ???? £ ?ê¶????ë¸? ??²?? ?ê½£åª? ?ë¸???¶å¯ê»ë±???  ï§ë¡ªë¦??ë¸£è¾ëªë¿ ??¾ï§£ì??? ??»?ë¹??ê½? ?ë¸????ë¸? ??²?? ?ê½??ë±¾ï§? ?ê¶????ë¸???

# 4-1. ?ë¸????ë¸? ?ë¿´ï§? ??²?? ?ê½£æ¿¡? ?????£?ë¸?æ¹??(?ê¸½æ²?) ----

# åªê³´ì»? ??²?? ?ê½? ?ë´??? ??«?ë¿??ê½? ?ê¶????ë¸? ??²?? ?ê½£ï§? ?°ë¶¿í§?ë¸???
# ?ê¶????ë¸? ??²?? ?ê½??? 2018??? 1??¡ ??²?? ?ê½???«??æ¿?? ï§â¤ë±? ??²?? ?ê½??ë¿??ê½? 2018??? 1??¡ ??²?? ?ê½£ç? ?°ë¶¿í§?ë¸????
# ?°ë¶¿í§?ë¸??? ??²?? ?ê½£ç? è¹ë?? æ¹²ê³????¤ ?ê¸½æ²?¯?«?ë±¶ç? ??¤??ê°?????æ¿?? ?? ?? ¹?ë¸???

# ï§ã¼?§
C_Sales <- C_Sales [C_Sales$æ¹²ê³??_?????¡_?ë¶¾ë±¶ == 201801, c(2, 12)]
C_Sales <- C_Sales [order(C_Sales$?ê¸½æ²?_?ë¶¾ë±¶, decreasing = FALSE), ]

# ?ë¸?????
C_N_Aparts <- C_N_Aparts [C_N_Aparts$æ¹²ê³??_?????¡_?ë¶¾ë±¶ == 201801, c(2, 4)]
C_N_Aparts <- C_N_Aparts [order(C_N_Aparts$?ê¸½æ²?_?ë¶¾ë±¶, decreasing = FALSE), ]

# ï§ë¬ì»????ê½?
C_N_Facs <- C_N_Facs [C_N_Facs$æ¹²ê³??_?????¡_?ë¶¾ë±¶ == 201801, c(2, 4)]
C_N_Facs <- C_N_Facs [order(C_N_Facs$?ê¸½æ²?_?ë¶¾ë±¶, decreasing = FALSE), ]

# ?? ?ë£?
C_N_Store <- C_N_Store [C_N_Store$æ¹²ê³??_?????¡_?ë¶¾ë±¶ == 201801, c(2, 6)]
C_N_Store <- C_N_Store [order(C_N_Store$?ê¸½æ²?_?ë¶¾ë±¶, decreasing = FALSE), ]

# ??¼?ë±?/??¼?®?
C_Income_Spend <- C_Income_Spend [C_Income_Spend$æ¹²ê³??_?????¡_?ë¶¾ë±¶ == 201801, c(2, 4, 6)]
C_Income_Spend <- C_Income_Spend [order(C_Income_Spend$?ê¸½æ²?_?ë¶¾ë±¶, decreasing = FALSE), ]

# ????ë£???¤?´?
C_F_Pop <- C_F_Pop [C_F_Pop$æ¹²ê³??_?????¡_?ë¶¾ë±¶ == 201801, c(2, 4)]
C_F_Pop <- C_F_Pop [order(C_F_Pop$?ê¸½æ²?_?ë¶¾ë±¶, decreasing = FALSE), ]

# ?ê¸½äº?±?¤?´?
C_S_Pop <- C_S_Pop [C_S_Pop$`æ¹²ê³???????¡ ?ë¶¾ë±¶` == 201801, c(2, 4)]
C_S_Pop <- C_S_Pop [order(C_S_Pop$`?ê¸½æ²? ?ë¶¾ë±¶`, decreasing = FALSE), ]
colnames(C_S_Pop) <- c("?ê¸½æ²?_?ë¶¾ë±¶", "?¥?_?ê¸½äº?±?¤?´?_??")
# ?ê¸½æ²?¯?½ ?ê¸½äº?±?¤?´? ??²?? ?ê½? ????ª??  è¹Â???? ?±? ?ê¶??? ?ë¿? _åªÂ ?ë¾¾æ¹²ê³ë¸£?¾ëªë¿ ??»??ª???ê¶æ¹²? ???ë¹? colnames?? è¹Âå¯??

# ï§ê³¸?£??¤?´?
C_W_Pop <- C_W_Pop [C_W_Pop$æ¹²ê³??_?????¡_?ë¶¾ë±¶ == 201801, c(2, 4)]
C_W_Pop <- C_W_Pop [order(C_W_Pop$?ê¸½æ²?_?ë¶¾ë±¶, decreasing = FALSE), ]


# C_Sales (ï§ã¼?§)??? ??²?? ?ê½£åª? åªê³´ë¦? ?ê½é®ê¾©ëª?ë¾½é«??æ¿¡? ?êµ??? ?ì¡???³æ¹?? ?ë¸£è¾ëªë¿ ?ê¸½æ²?¯?«?ë±¶è¹ê¾¨ì¤ ?ºê¾¨ìª?ë¸?æ¹?? ???ë¹??ê½?
# aggregate function??£ ?? ???ë¸??ë¿? ?ê¸½æ²?¯?«?ë±¶è¹ê¾¨ì¤ ?ë¹??£ ?´?ë¸³??
# sum ??£ ?ë¸??? ®ï§?? numeric ?? ?ë¿? ?ë¸???æ¿?? ??¦?ê½???»??æ¿?? ??¦??¡_ï§ã¼?§_æ¹²ëë¸???£ numeric ???ê¹?æ¿?? è¹Â???ë¸???
C_Sales$??¦??¡_ï§ã¼?§_æ¹²ëë¸? <- as.numeric(C_Sales$??¦??¡_ï§ã¼?§_æ¹²ëë¸?)
C_Sales <- aggregate(C_Sales$??¦??¡_ï§ã¼?§_æ¹²ëë¸?, by=list(Code=C_Sales$?ê¸½æ²?_?ë¶¾ë±¶), FUN=sum)
colnames(C_Sales) <- c("?ê¸½æ²?_?ë¶¾ë±¶", "??¦??¡_ï§ã¼?§_æ¹²ëë¸?")

# C_N_Store (?ê¸½æ²?¯?½ ?? ?ë£???½ ??)?ë£? C_Sales ï§£ì? ?ê½é®ê¾©ëª?ë¾½é«??æ¿¡? ?êµ??? ?ì¡???³?ë¼??ê½? åªì?? process?? è«ì?¬?ë¸??ë¿? ?ë¹??£ ?´?ë¸³??
C_N_Store$?? ?ë£?_?? <- as.numeric(C_N_Store$?? ?ë£?_??)
C_N_Store <- aggregate(C_N_Store$?? ?ë£?_??, by=list(Code=C_N_Store$?ê¸½æ²?_?ë¶¾ë±¶), FUN=sum)
colnames(C_N_Store) <- c("?ê¸½æ²?_?ë¶¾ë±¶", "?? ?ë£?_??")

# ï§â¤ëª? ??²?? ?ê½??ë´??? ??«??æ¿?? ???? ?????£
C_N_Aparts     <- as.data.frame(C_N_Aparts)
C_N_Facs       <- as.data.frame(C_N_Facs)
C_N_Store      <- as.data.frame(C_N_Store)
C_Income_Spend <- as.data.frame(C_Income_Spend)
C_F_Pop        <- as.data.frame(C_F_Pop)
C_S_Pop        <- as.data.frame(C_S_Pop)
C_W_Pop        <- as.data.frame(C_W_Pop)


# 4.2. ?ë¸????ë¸? ?ë¿´ï§? ??²?? ?ê½£æ¿¡? ?????£?ë¸?æ¹??(è«ê³ ?ï§Â) ----

# ?ë¸?????
H_N_Aparts <- H_N_Aparts [H_N_Aparts$`æ¹²ê³???????¡ ?ë¶¾ë±¶` == 201801, c(2, 4)]
H_N_Aparts <- H_N_Aparts [order(H_N_Aparts$`?ê¸½æ²? ?ë¶¾ë±¶`, decreasing = FALSE), ]
colnames(H_N_Aparts) <- c("?ê¸½æ²?_?ë¶¾ë±¶", "?ë¸?????_??ï§Â_??")
# ?ê¸½æ²?®ê°???ï§Â ?ë¸???????½ ??²?? ?ê½? ????ª??  è¹Â???? ?±? ?ê¶??? ?ë¿? _åªÂ ?ë¾¾æ¹²ê³ë¸£?¾ëªë¿ ??»??ª???ê¶æ¹²? ???ë¹? colnames?? è¹Âå¯??

# ï§ë¬ì»????ê½?
H_N_Facs <- H_N_Facs [H_N_Facs$æ¹²ê³??_?????¡_?ë¶¾ë±¶ == 201801, c(2, 4)]
H_N_Facs <- H_N_Facs [order(H_N_Facs$?ê¸½æ²?_?ë¶¾ë±¶, decreasing = FALSE), ]

# ?? ?ë£?
H_N_Store <- H_N_Store [H_N_Store$`æ¹²ê³?? ?????¡ ?ë¶¾ë±¶` == 201801, c(2, 5)]
H_N_Store <- H_N_Store [order(H_N_Store$`?ê¸½æ²? ?ë¶¾ë±¶`, decreasing = FALSE), ]
colnames(H_N_Store) <- c("?ê¸½æ²?_?ë¶¾ë±¶", "?? ?ë£?_??")
# ?ê¸½æ²?®ê°???ï§Â ??¼?ë±???¼?®ê¾©ì½ ??²?? ?ê½? ????ª??  è¹Â???? ?±? ?ê¶??? ?ë¿? _åªÂ ?ë¾¾æ¹²ê³ë¸£?¾ëªë¿ ??»??ª???ê¶æ¹²? ???ë¹? colnames?? è¹Âå¯??

# ??¼?ë±?/??¼?®?
H_Income_Spend <- H_Income_Spend [H_Income_Spend$æ¹²ê³???????¡?ë¶¾ë±¶ == 201801, c(2, 4, 6)]
H_Income_Spend <- H_Income_Spend [order(H_Income_Spend$?ê¸½æ²?¯?«?ë±?, decreasing = FALSE), ]
colnames(H_Income_Spend) <- c("?ê¸½æ²?_?ë¶¾ë±¶", "??¡?ë£æ´¹ì¢ë¼?ë±?_æ¹²ëë¸?", "ï§Â?°?_?¥?·??ë¸?")
# ?ê¸½æ²?®ê°???ï§Â ??¼?ë±???¼?®ê¾©ì½ ??²?? ?ê½? ????ª??  è¹Â???? ?±? ?ê¶??? ?ë¿? _åªÂ ?ë¾¾æ¹²ê³ë¸£?¾ëªë¿ ??»??ª???ê¶æ¹²? ???ë¹? colnames?? è¹Âå¯??

# ????ë£???¤?´?
H_F_Pop <- H_F_Pop [H_F_Pop$æ¹²ê³??_?????¡_?ë¶¾ë±¶ == 201801, c(2, 3)]
H_F_Pop <- H_F_Pop [order(H_F_Pop$?ê¸½æ²?_?ë¶¾ë±¶, decreasing = FALSE), ]

# ?ê¸½äº?±?¤?´?
H_S_Pop <- H_S_Pop [H_S_Pop$`æ¹²ê³???????¡ ?ë¶¾ë±¶` == 201801, c(2, 3)]
H_S_Pop <- H_S_Pop [order(H_S_Pop$`?ê¸½æ²? ?ë¶¾ë±¶`, decreasing = FALSE), ]
colnames(H_S_Pop) <- c("?ê¸½æ²?_?ë¶¾ë±¶", "?¥?_?ê¸½äº?±?¤?´?_??")
# ?ê¸½æ²?®ê°???ï§Â ?ê¸½äº?±?¤?´?ì½ ??²?? ?ê½? ????ª??  è¹Â???? ?±? ?ê¶??? ?ë¿? _åªÂ ?ë¾¾æ¹²ê³ë¸£?¾ëªë¿ ??»??ª???ê¶æ¹²? ???ë¹? colnames?? è¹Âå¯??

# ï§ê³¸?£??¤?´?
H_W_Pop <- H_W_Pop [H_W_Pop$æ¹²ê³??_?????¡_?ë¶¾ë±¶ == 201801, c(2,4)]
H_W_Pop <- H_W_Pop [order(H_W_Pop$?ê¸½æ²?_?ë¶¾ë±¶, decreasing = FALSE), ]


# H_N_Store (?ê¸½æ²?®ê°???ï§Â??½ ?? ?ë£???½ ??)?ë£? C_Sales ï§£ì? ?ê½é®ê¾©ëª?ë¾½é«??æ¿¡? ?êµ??? ?ì¡???³?ë¼??ê½? åªì?? process?? è«ì?¬?ë¸??ë¿? ?ë¹??£ ?´?ë¸³??
H_N_Store$?? ?ë£?_?? <- as.numeric(H_N_Store$?? ?ë£?_??)
H_N_Store <- aggregate(H_N_Store$?? ?ë£?_??, by=list(Code=H_N_Store$?ê¸½æ²?_?ë¶¾ë±¶), FUN=sum)
colnames(H_N_Store) <- c("?ê¸½æ²?_?ë¶¾ë±¶", "?? ?ë£?_??")

# ï§â¤ëª? ??²?? ?ê½??ë´??? ??«??æ¿?? ???? ?????£
H_N_Aparts     <- as.data.frame(H_N_Aparts)
H_N_Facs       <- as.data.frame(H_N_Facs)
H_N_Store      <- as.data.frame(H_N_Store)
H_Income_Spend <- as.data.frame(H_Income_Spend)
H_F_Pop        <- as.data.frame(H_F_Pop)
H_S_Pop        <- as.data.frame(H_S_Pop)
H_W_Pop        <- as.data.frame(H_W_Pop)


# 4-3. ??²?? ?ê½? ?ë¹ç§»ìë¦? (Merging Data) ----

# åª?? ??²?? ?ê½??ë±???£ ?ê¸½æ²?­?µ ?ê¸½æ²?®ê°???ï§Âæ¿?? åªê³´ì»? ?ë¹?¾ë¨?ê½? ??²?? ?ê½£ç? ?ëª¢åª?ì¤? ï§ë®ë±???
# ?? è¸?? ?ë´½æ¿¡?? ¥???ë¿??ê½??? ?«??½è¹Â??åªÂ ?ê¸½æ²?¯?½ ï§ã¼?§ C_Sales ??«??æ¿?? ?? ?? æ¹²ê³????æ¿?? ??????
# ï§â¤ë±? è¹Â???ë±???? ?ê¸½æ²?_?ë¶¾ë±¶æ¿?? ?ºê¾¨ìªåªÂ ?ë¦??ë¼???³æ¹?? ?ë¸£è¾ëªë¿ ?? ?? ?? ???ë¸??ë¿? ??²?? ?ê½£ç? ??»?ë¹?ë¸???
# C_Sales?ë¿??? 1744åªì?½ ?ê¸½æ²?_?ë¶¾ë±¶åªÂ è­°ë?±?ë¸??? æ´¹ëª???æ¿?? 1?º??ê½? 1744æºë¯????½ ??²?? ?ê½? ?ë´??? ??«??£ ?ê¹??ê½??? ?? ?ë¿? ï§ì? ?ê½? ?ë¹ç§»ì?


Total_Commercial <- data.frame('?ê¸½æ²?_?ë¶¾ë±¶' = c(1:1744))
View(Total_Commercial)

Total_Commercial <- merge(Total_Commercial, C_Sales,
                          by = "?ê¸½æ²?_?ë¶¾ë±¶", all = TRUE)

Total_Commercial <- merge(Total_Commercial, C_N_Aparts,
                          by = "?ê¸½æ²?_?ë¶¾ë±¶", all = TRUE)

Total_Commercial <- merge(Total_Commercial, C_N_Facs,
                          by = "?ê¸½æ²?_?ë¶¾ë±¶", all = TRUE)

Total_Commercial <- merge(Total_Commercial, C_N_Store,
                          by = "?ê¸½æ²?_?ë¶¾ë±¶", all = TRUE)

Total_Commercial <- merge(Total_Commercial, C_Income_Spend,
                          by = "?ê¸½æ²?_?ë¶¾ë±¶", all = TRUE)

Total_Commercial <- merge(Total_Commercial, C_F_Pop,
                          by = "?ê¸½æ²?_?ë¶¾ë±¶", all = TRUE)

Total_Commercial <- merge(Total_Commercial, C_S_Pop,
                          by = "?ê¸½æ²?_?ë¶¾ë±¶", all = TRUE)

Total_Commercial <- merge(Total_Commercial, C_W_Pop,
                          by = "?ê¸½æ²?_?ë¶¾ë±¶", all = TRUE)

View(Total_Commercial)


# ?ê¸½æ²?®ê°???ï§Â (Hinterland)??½ ??²?? ?ê½? merge

Total_Hinter <- data.frame("?ê¸½æ²?_?ë¶¾ë±¶" = c(1:1744))
View(Total_Hinter)

Total_Hinter <- merge(Total_Hinter, H_N_Aparts,
                      by = "?ê¸½æ²?_?ë¶¾ë±¶", all = TRUE)

Total_Hinter <- merge(Total_Hinter, H_N_Facs,
                      by = "?ê¸½æ²?_?ë¶¾ë±¶", all = TRUE)

Total_Hinter <- merge(Total_Hinter, H_N_Store,
                      by = "?ê¸½æ²?_?ë¶¾ë±¶", all = TRUE)

Total_Hinter <- merge(Total_Hinter, H_Income_Spend,
                      by = "?ê¸½æ²?_?ë¶¾ë±¶", all = TRUE)

Total_Hinter <- merge(Total_Hinter, H_F_Pop,
                      by = "?ê¸½æ²?_?ë¶¾ë±¶", all = TRUE)

Total_Hinter <- merge(Total_Hinter, H_S_Pop,
                      by = "?ê¸½æ²?_?ë¶¾ë±¶", all = TRUE)

Total_Hinter <- merge(Total_Hinter, H_W_Pop,
                      by = "?ê¸½æ²?_?ë¶¾ë±¶", all = TRUE)

View(Total_Hinter)



# 4-4. å¯ê³ë¥«ç§»? ?? £å«?? è«?? ??²?? ?ê½? ?? ?±? ----

# ?ëª? ????ª ï§â¤ëª? C_Sales??½ ?ê¸½æ²?¯?«?ë±¶ç? æ¹²ê³????æ¿?? ?ë¹?¾ë¨?ì£±ï§?ï§?? ï§â¤ë±? è¹Â???ë±???  ?ê¸½æ²?®?æ¿¡? è­°ê³ê¶??ë§å¯ê»ì  ?ë¸???²?ë¼??ê½? å¯ê³ë¥«ç§»??? è­°ë?±?ë¸?
# ??  å¯ê³ë¥«ç§»??? åªÂï§Â??? ?ºê¾©ê½??£ ?ë¸???ï§?? ?¾ëªì £åªÂ ?ê¹?æ¹?? ?ë¿¬ï§?åªÂ ??³??¬ 
# ?? ??´ å¯ê³ë¥«ç§»??? ??³?? ?ê¸½æ²?¯?? ??²?? ?ê½? ?ºê¾©ê½?ë¿??ê½? ?? £???ë¸???å¯ê»?  ?êµ???£å¯ê»?æ¿?? ?????ë¸??ë¿? ?? £??

Total_Commercial <- na.omit(Total_Commercial)
Total_Hinter     <- na.omit(Total_Hinter)

# ?? ª?±?ê½¦??? ??»??ª?ê½???£ ???ë¸??ë¿? ï§â¤ë±? colnames?? ??º?ë¼±æ¿¡? è¹Âå¯??
colnames(Total_Commercial) 
colnames(Total_Hinter)
#?ê¸½æ²?_?ë¶¾ë±¶, ?ë¸?????_??ï§Â_??, ï§ë¬ì»????ê½?_??, ?? ?ë£?_??, ??¡_?ë£æ´¹?_??¼?ë±?_æ¹²ëë¸?, ï§Â?°?_?¥?·??ë¸?, ?¥?_????ë£???¤?´?_??, ?¥?_?ê¸½äº?±?¤?´?_??, ?¥?_ï§ê³¸?£??¤?´?_??

colnames(Total_Commercial) <- c("Code", "Sales", "C_N_Aparts", "C_N_Facs", "C_Store", "C_Income", 
                                "C_Spend", "C_F_Pop", "C_S_Pop", "C_W_Pop")
colnames(Total_Hinter) <- c("Code", "H_N_Aparts", "H_N_Facs", "H_Store", "H_Income", "H_Spend", 
                                "H_F_Pop", "H_S_Pop", "H_W_Pop")

# ?ë¿????æ¿?? ?????£
writexl::write_xlsx(Total_Commercial, path = "Total_Commercial.xlsx")
writexl::write_xlsx(Total_Hinter, path = "Total_Hinter.xlsx")


# 4-5. ï§â¤ë±? ??²?? ?ê½? ?ë¹ç§»ìë¦? ----

# ?ê¸½æ²?­?µ ?ê¸½æ²?®ê°???ï§Â??½ ï§â¤ë±? ??²?? ?ê½£ç? ?ë¹ç§»ì?
All_Total <- merge(Total_Commercial, Total_Hinter,
                 by = "Code", all = TRUE)
View(All_Total)

# ?ë¹ç§»ì??ë¿??ë£? å¯ê³ë¥«ç§»??? è­°ë?±?ë¸???æ¿?? å¯ê³ë¥«ç§»??? ?ë¾??ë¸???

All_Total <- na.omit(All_Total)
# å¯ê³ë¥«ç§»??? ï§â¤ëª? ?? £å«ê³ ë¸?ï§?? ?¥? 1050åªì?½ ??²?? ?ê½£åª? è­°ë?±


# ?ëª¢åª? ?ë¹?¾ë¨?ì­? ??²?? ?ê½? ?ë¿????æ¿?? ?????£?ë¸?æ¹?? 

writexl::write_xlsx(All_Total, path = "All_Total.xlsx")

# 4-6. ?ë¸????ë¾??? Data ï§ë¶¾??±?ë¿?ê½? ?ê¶??? £

# ?? ?? £ ?ë¸????ë¸? Data?? All_Total ?ë¸??êµ? ?ë¨??«??æ¿?? ï§ë¶¾??±???? ï§¡â¥???ë¸??? ???? ??²?? ?ê½£ç? ?? £å«ê³ ë¸??ë¿?
# ?«??? ????¢?? ??å¯ì?£ ï§ë®ë±??ë¼±ä»¥??ê½?
rm(list=(ls()[ls()!="All_Total"]))

# 5. ??ä»¥ë¬?¶æ´¹Â?ºê¾©ê½ 

# 5.1 Model_1 :?ê¸½æ²?¯?½ ï§ã¼?§??£ ?«??½è¹Â??æ¿¡ìë¸??ë¿? ?ê¸½æ²? ????? è«ê³ ?ï§Â??½ ?ë£ç±??????ë±? åªê¾©?½ ??ä»¥ë¬?¶æ´¹Â?ºê¾©ê½ ----

# 5.1.1 è¹Â???ê½??ê¹? ?¨ì±?  ----

All_Total <- readxl::read_excel(path = "All_Total.xlsx",
                                sheet = 1,
                                col_names = TRUE)

# Linear Model test?? ?ë¸?æ¹?? ???ë¹? ï§â¤ë±? è¹Â???ë±???£ Numeric??æ¿?? è¹Âå¯??

All_Total <- mutate_all(All_Total, function(x) as.numeric(x))  

str(All_Total) #ï§â¤ëª? Numeric??¤å¯ê»?£ ?????

lm.result.all      <- lm(Sales ~ . - Code, data = All_Total)??¤ #Code?? ?ë£ç±?????åªÂ ?ë¸?????æ¿?? ?®ê¾§í³?ë¸?ï§Â ?ë¸???¬
lm.result.forward  <- step(lm.result.all, direction = "forward")
lm.result.backward <- step(lm.result.all, direction = "backward")
lm.result.stepwise <- step(lm.result.all, direction = "both")

# ?ë¼??ë¼? è«â¹???£ ?ê¶????ë¸·ï§??? ?? ?ë¸?æ¹?? ???ë¹??ê½? Akaike Information Criterion(AIC)??æ¿?? ????¤?ë¸???

AIC(lm.result.all)
# 47439.57
AIC(lm.result.forward)
# 47439.57
AIC(lm.result.backward)
# 47428.46
AIC(lm.result.stepwise)
# 47428.46

# stepwise??? backward è«â¹???½ AICåªÂ 42428.46??æ¿?? all??? forward??½ 47439.57 è¹ë?? ?ê¶???¬??æ¿?? 
# stepwise è«â¹???£ ï§?ê¾ªê¹®

lm.result.final <- lm.result.stepwise
options(scipen = 100) # ?ëª???è«â¸ì¾???£ ??¼???? ??æ¿??

# 5.1.2 ï§â¤?½ ?ë¹??ê½? ----

summary(lm.result.final)

# Call:
#   lm(formula = Sales ~ C_N_Facs + C_Store + C_Income + C_S_Pop + 
#        C_W_Pop + H_N_Aparts, data = All_Total)
# 
# Residuals:
#   Min           1Q            Median      3Q         Max 
# -12592705690   -328945293    -46453784    242223784  35168692254 
# 
#               Estimate      Std. Error    t value      Pr(>|t|)
# (Intercept)  -476539347.5   209888641.0  -2.270        0.0234 * 
# C_N_Facs      15083184.2    2533015.0     5.955        0.00000000356 ***
# C_Store       10647321.9    1107249.4     9.616      < 0.0000000000000002 ***
# C_Income      132.7         63.8          2.079        0.0378 *  
# C_S_Pop      -174967.6      43067.0      -4.063        0.00005214868 ***
# C_W_Pop       726001.4      42269.8       17.175     < 0.0000000000000002 ***
# H_N_Aparts    381951.9      212449.2      1.798        0.0725 .  
# ---
# Signif. codes:  0 ???***??? 0.001 ???**??? 0.01 ???*??? 0.05 ???.??? 0.1 ??? ??? 1
# 
# Residual standard error: 1550000000 on 1043 degrees of freedom
# Multiple R-squared:  0.4934,	Adjusted R-squared:  0.4905 
# F-statistic: 169.3 on 6 and 1043 DF,  p-value: < 0.00000000000000022


  
# 1????? : ??¶æ´¹Âï§â¦???? ?????¦?ë¸³åª??
# æ´¹Â?¾?¿???ê½? : ??¶æ´¹Âï§â¦???? ?????¦?ë¸?ï§Â ?ë¸???
# ????±????ê½? : ??¶æ´¹Âï§â¦???? ?????¦?ë¸???
# F-statistic: 169.3 on 6 and 1043 DF,  p-value: < 0.00000000000000022
# å¯ê³ì¤? : ?????½???ì¢ì  0.000 ?? èªÂæ¿?? ?????½??ä»¥Â 0.05è¹ë?? ?ê¶???¬??æ¿?? ????±????ê½???£ ï§Âï§Â?ë¸???
# æ´¹ëª???æ¿?? ??¶æ´¹Âï§â¦???? ??»?¨ê¾©?»??æ¿?? ?????¦?ë¸???.

# 2????? : ?ë£ç±??????ë±???? ?«??½è¹Â???ë¿å¯? ??º?ë¼???£ äºì°?åªÂ?
#               Estimate      Std. Error    t value      Pr(>|t|)    
# C_N_Facs      15083184.2    2533015.0     5.955        0.00000000356 ***
# C_Store       10647321.9    1107249.4     9.616      < 0.0000000000000002 ***
# C_Income      132.7         63.8          2.079        0.0378 *  
# C_S_Pop      -174967.6      43067.0      -4.063        0.00005214868 ***
# C_W_Pop       726001.4      42269.8       17.175     < 0.0000000000000002 ***
# H_N_Aparts    381951.9      212449.2      1.798        0.0725 .  
# ---
# Signif. codes:  0 ???***??? 0.001 ???**??? 0.01 ???*??? 0.05 ???.??? 0.1 ??? ??? 1  

# å¯ê³ì¤? : C_Income, H_N_Aparts ?? ?????½??ä»¥Â 0.05?ë¿??ê½? ?«??½è¹Â???ë¿å¯? ??»?¨ê¾©?»??æ¿?? ?????½?ë¸? ??º?ë¼???  ?ë¾???¬.



# ??»?¨ê¾©?»??æ¿?? ?¾??½èªëªë¸? è¹Â?? ?ëª¢åª??? ?? £???ë¸???? ï§â¤?½??£ ??±?´?ê½¦?ë¸?.


lm.result.final2 <- lm(Sales ~ C_N_Facs + C_Store + C_S_Pop + C_W_Pop, data = All_Total)
summary(lm.result.final2)

# 1????? : ??¶æ´¹Âï§â¦???? ?????¦?ë¸³åª??
# F-statistic: 250.9 on 4 and 1045 DF,  p-value: < 0.00000000000000022
# å¯ê³ì¤? : ?????½???ì¢ì  0.000 ?? èªÂæ¿?? ?????½??ä»¥Â 0.05è¹ë?? ?ê¶???¬??æ¿?? ????±????ê½???£ ï§Âï§Â?ë¸???
# æ´¹ëª???æ¿?? ??¶æ´¹Âï§â¦???? ??»?¨ê¾©?»??æ¿?? ?????¦?ë¸???.

# 2????? : ?ë£ç±??????ë±???  ?«??½è¹Â???ë¿å¯? ??º?ë¼???£ äºì°?åªÂ?
#             Estimate    Std. Error  t value      Pr(>|t|)    
# C_N_Facs    14995676    2538850     5.906        0.00000000472 ***
# C_Store     10706604    1108389     9.660      < 0.0000000000000002 ***
# C_S_Pop    -142190      36170      -3.931        0.00009012138 ***
# C_W_Pop     738800      41209       17.928     < 0.0000000000000002 ***
# ---
# Signif. codes:  0 ???***??? 0.001 ???**??? 0.01 ???*??? 0.05 ???.??? 0.1 ??? ??? 1

# å¯ê³ì¤? : C_N_Facs   (t = 5.906,  p < 0.001)
#        C_Store    (t = 9.660,  p < 0.001)
#        C_S_Pop    (t = -3.931, p < 0.001)
#        C_W_Pop    (t = 17.928, p < 0.001)
# ?ë£ç±????? 4åª?? ï§â¤ëª¢åª? ?«??½è¹Â???ë¿å¯? ?????½??ä»¥Â 0.05?ë¿??ê½? ??»?¨ê¾©?»??æ¿?? ?????½?ë¸? ??º?ë¼???£ äºì°? å¯ê»?æ¿?? ?êµ?????ê¶???.

# 3????? : ?ë£ç±??????ë±???? ?ë¼??ë¼? ??º?ë¼???£ äºì°?åªÂ?
#             Estimate    
# C_N_Facs    14995676    
# C_Store     10706604    
# C_S_Pop    -142190     
# C_W_Pop     738800      

# C_N_Facs?? ???? ?ê½? åªì?½ ?ë£ç±????? (C_Store, C_S_Pop, C_W_Pop)åªÂ ?¨ì¢? ?ë¦??ë¼???³??£ ?ë¸??ë¿?, C_N_Facs??½ æ¹²ê³?¯????åªÂ 1ï§ì·???ë¸?ï§??, ?«??½è¹Â??, Sales?? ?ë¹? 14995676 ?? ?ë£? ï§ì·???ë§???

# C_Store?? ???? ?ê½? åªì?½ ?ë£ç±????? (C_N_Facs, C_S_Pop, C_W_Pop)åªÂ ?¨ì¢? ?ë¦??ë¼???³??£ ?ë¸??ë¿?, C_Store??½ æ¹²ê³?¯????åªÂ 1ï§ì·???ë¸?ï§??, ?«??½è¹Â??, Sales?? ?ë¹? 10706604 ?? ?ë£? ï§ì·???ë§???

# C_S_Pop?? ???? ?ê½? åªì?½ ?ë£ç±????? (C_N_Facs, C_Store, C_W_Pop)åªÂ ?¨ì¢? ?ë¦??ë¼???³??£ ?ë¸??ë¿?, C_S_Pop??½ æ¹²ê³?¯????åªÂ 1ï§ì·???ë¸?ï§??, ?«??½è¹Â??, Sales?? ?ë¹? 142190 ?? ?ë£? åªë¨¯?¼?ë§???

# C_W_Pop?? ???? ?ê½? åªì?½ ?ë£ç±????? (C_N_Facs, C_Store, C_S_Pop)åªÂ ?¨ì¢? ?ë¦??ë¼???³??£ ?ë¸??ë¿?, C_W_Pop??½ æ¹²ê³?¯????åªÂ 1ï§ì·???ë¸?ï§??, ?«??½è¹Â??, Sales?? ?ë¹? 738800 ?? ?ë£? ï§ì·???ë§???


# 4????? : ?ë£ç±??????ë±???½ ?ê½ï§?? °
# Adjusted R-squared:  0.488 
# ?ê½åª??½ ?ë£ç±?????åªÂ ?«??½è¹Â???? ?ë¹? 48.8% ?ê½ï§?.


# 5.1.3 ï§â¤?½ å¯Âï§?? ----

# (1) ??ä»¥ë¬?¬?ê½??ê½? ?? å¯Â
car::vif(lm.result.final2)

# ï§â¤ë±? è¹Â????½ vifåªÂ 4 èªëªì­??? èªÂæ¿?? ??ä»¥ë¬?¬?ê½??ê½???? è­°ë?±?ë¸?ï§Â ?ë¸??? å¯ê»?æ¿?? è¹ë?«.

# (2) ??ï§¡â¤??ê½?
gvlma.result <- gvlma::gvlma(lm.result.final2)
summary(gvlma.result)




# ?? æ´¹ìê½?, ?ê½????ê½?, ?ë²éºê¾©ê¶?ê½? ï§â¤ëª? ?º?ì­è???

lmtest::dwtest(lm.result.final2)

# DW = 2.0244, p-value = 0.6291 , ?ë£ç±?ê½???? ï§ë¯?? 


# 5.2 model2 : ?ê¸½æ²?¯?½ ï§ã¼?§??? ?ê¸½æ²?®ë£ç±??????ë±¾åªê¾©ì½ ??ä»¥ë¬?¶æ´¹Â?ºê¾©ê½ ----

total_district_j <- readxl::read_excel("FC_Project1_rawdata/total_district_j.xlsx")
View(total_district_j)

# 5.2.1 è¹Â???ê½??ê¹? ?¨ì±?  ----

lm.result.all      <- lm(total_district_j$d.sales ~ ., data = total_district_j)
lm.result.forward  <- step(lm.result.all, direction = "forward")
lm.result.backward <- step(lm.result.all, direction = "backward")
lm.result.stepwise <- step(lm.result.all, direction = "both")

AIC(lm.result.all)
# 57449.1
AIC(lm.result.forward)
# 57449.1
AIC(lm.result.backward)
# 57443.34
AIC(lm.result.stepwise)
# 57443.34 , stpewise è«â¹???£ ï§?ê¾ªê¹®

lm.result.final1 <- lm.result.stepwise
options(scipen = 100) # ?ëª???è«â¸ì¾???£ ??¼???? ??æ¿??

# 5.2.2 ï§â¤?½ ?ë¹??ê½? ----

summary(lm.result.final1)
# d.spent??½ t å¯Â??  å¯ê³?µåªÂ 0.05 ?????½??ä»¥Â?ë¿??ê½? ?????½?ë¸?ï§Â ?ë¸???èªÂæ¿?? ï§â¤?½ ??±?´?ê½¦.

lm.result.final2 <- lm(d.sales ~ d.facility + d.income + d.s.pop + d.w.pop + d.store, data = total_district_j)
summary(lm.result.final2)

# 1????? : ??¶æ´¹Âï§â¦???? ?????¦?ë¸³åª??
# F-statistic: 298.7 on 5 and 1270 DF,  p-value: < 0.00000000000000022
# å¯ê³ì¤? : ?????½???ì¢ì  0.000 ?? èªÂæ¿?? ?????½??ä»¥Â 0.05?ë¿??ê½? ??¶æ´¹Âï§â¦???? ??»?¨ê¾©?»??æ¿?? ?????¦?ë¸???.

# 2????? : ?ë£ç±??????ë±???  ?«??½è¹Â???ë¿å¯? ??º?ë¼???£ äºì°?åªÂ?
# #                 Estimate   Std. Error t value             Pr(>|t|)    
# (Intercept) -383578577.3    176436461.3  -2.174               0.0299 *  
#   d.facility    13576875.0    2039343.0   6.657      0.0000000000413 ***
#   d.income           120.1         54.8   2.192               0.0285 *  
#   d.s.pop        -128959.3      31004.3  -4.159      0.0000340527132 ***
#   d.w.pop         740052.3      33821.7  21.881 < 0.0000000000000002 ***
#   d.store       10889230.2     899265.4  12.109 < 0.0000000000000002 ***   

# å¯ê³ì¤? : d.facility (t = 6.657,  p < 0.001)
#        d.income   (t = 2.192,  p < 0.05)
#        d.s.pop    (t = -4.159, p < 0.001)
#        d.w.pop    (t = 21.881, p < 0.001)
#        d.store    (t = 12.109,  p < 0.001)
# ?ë£ç±????? 5åª?? ï§â¤ëª¢åª? ?«??½è¹Â???ë¿å¯? ?????½??ä»¥Â 0.05?ë¿??ê½? ??»?¨ê¾©?»??æ¿?? ?????½?ë¸? ??º?ë¼???£ äºì°? å¯ê»?æ¿?? ?êµ?????ê¶???.

# 3????? : ?ë£ç±??????ë±???? ?ë¼??ë¼? ??º?ë¼???£ äºì°?åªÂ?
#                  Estimate   
# (Intercept)   -383578577.3  
#   d.facility    13576875.0   
#   d.income           120.1       
#   d.s.pop        -128959.3      
#   d.w.pop         740052.3      
#   d.store       10889230.2     

# 4????? : ?ë£ç±??????ë±???½ ?ê½ï§?? °
# Adjusted R-squared:  0.5386
# ?ê½åª??½ ?ë£ç±?????åªÂ ?«??½è¹Â???? ?ë¹? 53.86% ?ê½ï§?.

# model 1 è¹ë?? model2 ??½ ?ê½ï§?? °??  ????èªÂæ¿??, ??½??±æºë¯???? model2åªÂ åªÂ??£ ??????ë¹è¹??«.

# 5.2.3 ï§â¤?½ å¯Âï§?? ----

# (1) ??ä»¥ë¬?¬?ê½??ê½? ?? å¯Â
car::vif(lm.result.final2)

# ï§â¤ë±? è¹Â????½ vifåªÂ 4 èªëªì­??? èªÂæ¿?? ??ä»¥ë¬?¬?ê½??ê½???? è­°ë?±?ë¸?ï§Â ?ë¸??? å¯ê»?æ¿?? è¹ë?«.

# (2) ??ï§¡â¤??ê½?
gvlma.result <- gvlma::gvlma(lm.result.final2)
summary(gvlma.result)

# Call:
#   gvlma::gvlma(x = lm.result.final2) 
# 
#                       Value        p-value    Decision
#   Global Stat         2960417.83   0          Assumptions NOT satisfied!
#   Skewness            19869.84     0          Assumptions NOT satisfied!
#   Kurtosis            2940335.11   0          Assumptions NOT satisfied!
#   Link Function       140.36       0          Assumptions NOT satisfied!
#   Heteroscedasticity  72.52        0          Assumptions NOT satisfied!

# ?? æ´¹ìê½?, ?ê½????ê½?, ?ë²éºê¾©ê¶?ê½? ï§â¤ëª? ?º?ì­è???

lmtest::dwtest(lm.result.final2)

# DW = 1.9866, p-value = 0.4057 
# DW test å¯ê³?µ?ê¸? ?ë£ç±?ê½???? ï§ë¯?? 


# 6. model2 ??½ ï§â¤?½ ??????ê½? ?¾ëªì £ åªìê½? ----


