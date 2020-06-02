#' @title Implementation of MOS-transformation to be used with Rank based statistical techniques.
#'
#' @description Transform the MOS values given 95% Confidence Intervals, so two similar MOS values get a same rank although their MOS values are not equivalent.
#'
#' @param mos, ci
#'
#' @return new_ranks
#'
#' @examples
#' m <- c(1.1, 4, 5, 2, 3, 1.2, 4)
#' c <- c(0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1)
#' transform_mos(m,c)
#'
#' @export transform_mos
#' @importFrom utils head


transform_mos<-function(mos, ci)
{
  "
/*---------------------------------------------------------------------------------------------
*  Copyright (c) Dr. Babak Naderi. All rights reserved.
*  Licensed under the MIT License. See License.txt in the project root for license information.
*--------------------------------------------------------------------------------------------*/
  @author: Babak Naderi
"
  if (length(mos) != length(ci)){
    stop("MOS and CI should have a same size")
  }
  df <- data.frame(mos, ci)
  df['mos_rank'] <- rank(df$mos)
  df <- df[order(df$mos_rank),]
  df['old_index'] <- as.numeric(rownames(df))

  new_ranks <- rep(0, length(mos))

  new_ranks[1] <- 1

  tied_set_mos <- vector()
  tied_set_ci <- vector()


  for (i in 2:nrow(df)) {
    # check if it make a tied rank with the previous item
    if (is_tied_rank(df[i-1,'mos'], df[i-1,'ci'], df[i,'mos'], df[i,'ci'])){
      new_ranks[i] = new_ranks[i - 1]
      # now check if there is a set
      if(length(tied_set_mos) == 0){
        # there is no set
        # make a set
        tied_set_mos <- c(df[i-1, 'mos'], df[i, 'mos'])
        tied_set_ci <- c(df[i-1, 'ci'], df[i,'ci'])
      }else{
        # a set already exist
        # add the new item to the set
        tied_set_mos <- c(tied_set_mos , df[i, 'mos'])
        tied_set_ci<- c(tied_set_ci , df[i, 'ci'])
        # check if the set is still valid
        if (!is_tied_set_valid(tied_set_mos, tied_set_ci)){
          # correct the set
          # add the last element of set to a new tmp set
          tmp_mos <- tied_set_mos[length(tied_set_mos)]
          tmp_ci <- tied_set_ci[length(tied_set_ci)]

          new_ranks[i] <- new_ranks[i-1] + 1

          tied_set_mos<-head( tied_set_mos, -1)
          tied_set_ci<-head( tied_set_ci, -1)
          # %check if last element of set1 want to be in set2
          while (length(tied_set_mos) > 1 &&
                 abs(tmp_mos[1] - tied_set_mos[length(tied_set_mos)]) < abs(tied_set_mos[length(tied_set_mos)-1]-tied_set_mos[length(tied_set_mos)]) &&
                 is_tied_set_valid( c(tied_set_mos[length(tied_set_mos)], tmp_mos), c(tied_set_ci[length(tied_set_ci)],  tmp_ci))){

            tmp_mos <-  c(tied_set_mos[length(tied_set_mos)], tmp_mos)
            tmp_ci <-  c(tied_set_ci[length(tied_set_ci)],  tmp_ci)
            tied_set_mos<-head( tied_set_mos, -1)
            tied_set_ci<-head( tied_set_ci, -1)
          }
          # now everyone in the tmp_mos should get rank(i)
          for (j in 1:length(tmp_mos)){
            new_ranks[i-j+1] <- new_ranks[i]
          }
          tied_set_mos <- tmp_mos
          tied_set_ci <- tmp_ci

        }
      }

    }else{
      new_ranks[i] <- new_ranks[i - 1] + 1
      tied_set_mos <- vector()
      tied_set_ci <- vector()
    }

  }
  df['tmp_rank'] <- new_ranks
  df['new_rank'] <- rank(df$tmp_rank)
  df <- df[order(df$old_index),]
  return(df$new_rank)
}


is_tied_rank <- function(mos_a, ci_a, mos_b, ci_b)
{
  if (round(mos_a, 2) >= round(mos_b - ci_b, 2) && round(mos_a, 2) <= round(mos_b + ci_b, 2)){
    return(TRUE)
  }
  if (round(mos_b, 2) >= round(mos_a - ci_a, 2) && round(mos_b, 2) <= round(mos_a + ci_a, 2)){
    return(TRUE)
  }
  return(FALSE)
}


is_tied_set_valid <-function(mos_set, ci_set)
{
  l = length(mos_set)
  for (i in l:1){
    for (j in (i-1):1){
      if (j<1){
        next
      }
      if (!is_tied_rank(mos_set[i], ci_set[i], mos_set[j], ci_set[j])){
        return(FALSE)
      }
    }
  }
  return(TRUE)
}




