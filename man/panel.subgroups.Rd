\name{panel.subgroups}
\Rdversion{1.1}
\alias{panel.subgroups}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Panel function to display subgroups within groups within panels
}
\description{
This function is designed to be used as the argument to \code{panel.groups} in
\code{xyplot}. It effectively adds another level of subgrouping to that implemented
by the \code{groups} argument in \code{xyplot}.  Useful mainly to display data and
fitted lines in groups within panels.
}
\usage{
panel.subgroups(x, y, subscripts, subgroups, subgroups.type = c("p", "l"), type, panel.subgroups = panel.xyplot, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x,y}{
coordinates of the points to be displayed
}
  \item{subscripts}{
subscripts giving indices in original data frame
}
  \item{subgroups}{
a subgrouping variable. Use a full reference, e.g. data$subvar
}
  \item{subgroups.type}{
plotting type, typically 'p' or 'l', for each level of the variable passed through
the \code{subgroups} argument
}
  \item{type}{
%%     ~~Describe \code{type} here~~
}
  \item{panel.subgroups}{
function use to plot data within in each group referring to the levels of the
variable passed by \code{subgroups}.  Define a \code{panel.subgroups} argument in the
call to \code{xyplot} and it will be used to plot the groups. See the examples
below.
}
  \item{\dots}{
any other arguments to be passed to the panel plotting function
}
}
\details{
This function is designed to be used as the argument to 'panel.groups' in
'xyplot'. It allows the plotting of points versus lines within subgroups of
the data identified by the 'groups' argument in xyplot.  It requires a
variable to identify the subgroups. Points or lines are used within subgroups
depending on 'subgroups.type' where the order is that of the levels of the
'subgroups' argument coerced as a factor, if necessary.  See the examples below.
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}
%% ~Make other sections like Warning with \section{Warning }{....} ~
\seealso{
\code{link{lattice::panel.superpose}},
\code{link{lattice::panel.superpose.2}},
\code{link{lattice::panel.xyplot}}
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.
     library(car)
     data(Prestige)
     fit <- lm( prestige ~ (education +I(education^2)) * type, Prestige, na.action = na.omit)
     pred <- expand.grid( education = seq( 6, 18, .5), type = levels( Prestige$type))
     pred$prestige <- predict( fit, newdata = pred )

     Prestige$what <- 'data'
     pred$what <- 'fit'         # this works because 'fit' follows 'data' lexicographically

     combined <- merge( Prestige, pred, all = T)

     xyplot( prestige ~ education, combined,
          groups = type,
          subgroups = combined$what,  # note that a full reference to the variable is needed
          panel = panel.superpose,    # might not be necessary in future version of lattice
          panel.groups = panel.subgroups)  # uses the default of points for the first level of 'what'
                                           # and lines for the second level

     ## Using the argument 'panel.subgroups' instead of the default 'panel.xyplot'
     ## Note that panel.subgroups is a function (this one) and also an argument that
     ## is a function passed to the function. The argument defines the action to
     ## be taken within each level of 'what'
     
     xyplot( prestige ~ education, combined,
          groups = type,
          subgroups = combined$what,  # note that a full reference to the variable is needed
          panel = panel.superpose,    # might not be necessary in future version of lattice
          panel.groups = panel.subgroups,
          panel.subgroups = function( x, y, subgroup, type, ...) {
             # note that you need to include 'type' among the arguments
             # if you need to prevent it from being passed through '...'
             # When called, this function will be passed arguments
             # subgroup, subgroup.number, subscripts, and type from
             # subgroups.type.
             if ( subgroup == 'data' ) {
                panel.xyplot( x, y, ...)
                panel.lines( dell(x,y), ...)
             }
             else {
                panel.lines( x,y, ...)
             }
          })
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
