\name{transform_mos}
\alias{transform_mos}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Implementation of MOS-transformation to be used with Rank based statistical techniques.
}
\description{
The rank correlation coefficients and the ranked-based statistical tests (as a subset of non-parametric techniques) might be misleading when they are applied to subjectively collected opinion scores. Those techniques assume that the data is measured at least at an ordinal level and define a sequence of scores to represent a tied rank when they have precisely an equal numeric value. Before applying any rank based static technique use this package to transfer MOS values to a new rank so the result of statistic techniques will be robus to noises.
}
\usage{
transform_mos(mos, ci)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{mos}{
  array of MOS values
  }
  \item{ci}{
  array of 95\% Confifence Intervals.
}
}
\details{
See the paper for details:

Naderi B, Möller S. Transformation of Mean Opinion Scores to AvoidMisleading of Ranked based Statistical Techniques 2020 Twelfth International Workshop on Quality of Multimedia Experience (QoMEX). IEEE, 2020.

There, we show that the definition of tied rank, as mentioned above, is not suitable for Mean Opinion Scores (MOS) and might be misleading conclusions of rank-based statistical techniques. Furthermore, we introduce a method to overcome this issue by transforming the MOS values considering their 95\% Confidence Intervals. The rank correlation coefficients and ranked-based statistical tests can then be safely applied to the transformed values.
This is the R implementation of the transformation method.
}
\value{
  New rank values. Use the outcome with rank based statitical techniques e.g. Spearman's Rank correlation.

}
\references{
Naderi B, Möller S. \emph{Transformation of Mean Opinion Scores to AvoidMisleading of Ranked based Statistical Techniques}. Twelfth International Workshop on Quality of Multimedia Experience (QoMEX). IEEE, 2020.

website: \url{https://github.com/babaknaderi/MOS-transformation}
}
\author{
Dr. Babak Naderi \email{bnaderi9@gmail.com}
}

\examples{
  mos <- c(1.1, 4, 5, 2, 3, 1.2, 4)
  ci <- c(0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1)
  transform_mos(mos,ci)
}


% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory (show via RShowDoc("KEYWORDS")):
%\keyword{ MOS }
%\keyword{ Rank Statistic }
% Use only one keyword per line.
% For non-standard keywords, use \concept instead of \keyword:
 \concept{ MOS }
 \concept{ Rank Statistic }
 \concept{ Spearman Correlation }
 \concept{  subjective test }
% Use only one concept per line.
