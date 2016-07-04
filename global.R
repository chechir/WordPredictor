library(dplyr)
library(stringr)

uni<-readRDS("rds/unigramsKN.rds") #6080k(33%) vs 8458k(50%(menos norm))
bi<-readRDS("rds/bigramsKN.rds") #140M (33%) vs 196M
tri<-readRDS("rds/trigramsKN.rds") #373M vs 544M
four<-readRDS("rds/fourgramsKN.rds")

predictKN = function(txt, n, reorder) {
    #n=number of predictions
    #reorder=TRUE/FALSE. Reorder the predictions
    # analyse text and generate matrix of words
    # Returns a dataframe containing 1 tweet per row, one word per column
    # and the number of times the word appears per tweet
    #txt<-"Hey sunshine, can you follow me and make me the"
    #txt<-"this is"
    #txt<-"where are we";n=10
    txt <- tolower(txt)
    txt <- str_trim(txt)
    txt <- str_replace_all(txt, "  ", " ")
    txt <- str_replace_all(txt, "  ", " ")
    txt <- gsub("([.-])|[[:punct:]]", "\\1", txt)
    
    tmp <- str_split(txt, pattern = " ")[[1]]
    
    # txt4 <-
    #   paste(tmp[length(tmp) - 3], tmp[length(tmp) - 2], tmp[length(tmp) - 1], tmp[length(tmp)], sep = "_")
    # txt3 <-
    #   paste(tmp[length(tmp) - 2], tmp[length(tmp) - 1], tmp[length(tmp)], sep =
    #           "_")
    # txt2 <- paste(tmp[length(tmp) - 1], tmp[length(tmp)], sep = "_")
    # #txt1<-paste(tmp[length(tmp)], sep ="_")
    result=data.frame()
    df=data.frame()
    #evaluate 4 grams
    if (length(tmp)>=3){
        df <-
            dplyr::filter(four, word_3 == tmp[length(tmp) - 2] &
                              word_2 == tmp[length(tmp) - 1] & word_1 == tmp[length(tmp)])
    }
    if (nrow(df) > 0) {
        
        temp<-head(dplyr::arrange(df, -kn4) %>% dplyr::select(word, kn4), n)
        temp$ngram='4gram'
        colnames(temp)[2]<-"prob"
        cat("4gram found ", nrow(temp), "\n")
        result=rbind(result, temp)
    }
    
    if (nrow(result)<n & length(tmp) >=2) {
        #evaluate 3 grams
        if(nrow(result)==0){
            df <- dplyr::filter(tri, word_2 == tmp[length(tmp) - 1] &
                              word_1 == tmp[length(tmp)])
        }else{
            df <- dplyr::filter(tri, word_2 == tmp[length(tmp) - 1] &
                              word_1 == tmp[length(tmp)] & 
                              !(word %in% result$word))
        }
        if(nrow(df) > 0) {
            temp<-head(dplyr::arrange(df, -kn3) %>% dplyr::select(word, kn3, freq), n)
            temp$ngram='3gram'
            colnames(temp)[2]<-"prob"
            temp$prob=temp$prob*(0.5/temp$freq)
            temp$freq=NULL
            cat("3gram found ", nrow(temp), "\n")
            result=head(rbind(result, temp),n)
        }
    }
    
    if(nrow(result)<n & length(tmp) >=1 & txt!='') {
        #evaluate bigram
        if(nrow(result)==0){
            df <- dplyr::filter(bi, word_1 == tmp[length(tmp)])
        } else {
            df <- dplyr::filter(bi, word_1 == tmp[length(tmp)] & 
                                    !(word %in% result$word))
        }
        if (nrow(df) > 0) {
            temp<-head(dplyr::arrange(df, -kn2) %>% dplyr::select(word, kn2, freq), n)
            temp$ngram='2gram'
            colnames(temp)[2]<-"prob"
            temp$prob=temp$prob*(0.5/temp$freq)
            temp$freq=NULL
            cat("2gram found ", nrow(temp), "\n")
            result=head(rbind(result, temp),n)
        } 
    }
    
    if(nrow(result)<n) {
        # unigram
        if(nrow(result)==0){
            temp<-head(dplyr::arrange(uni, -prob) %>% dplyr::select(word, prob, freq), n)
        }else{
            temp<-head(dplyr::arrange(uni, -prob) %>% dplyr::filter(!(word %in% result$word)) %>%
                       dplyr::select(word, prob), n) 
        }
        temp$ngram='1gram'
        colnames(temp)[2]<-"prob"
        temp$prob=temp$prob*(0.5/temp$freq)
        temp$freq=NULL
        cat("1gram found ", nrow(temp), "\n")
        result=head(rbind(result, temp),n)
    }
    
    if(reorder==TRUE){
        return(head(arrange(result, -prob),n))
    }else{
        return(head(result,n))
    }
}

#predictKN("where are we", 10, F)
