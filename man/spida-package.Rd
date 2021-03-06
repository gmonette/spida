\name{spida-package}
\Rdversion{1.1}
\alias{spida.beta-package}
\alias{spida}
\alias{spida.beta}
\docType{package}
\title{
Collection of utility functions for mixed models, etc. for SPIDA 2009+ (beta version)
}
\description{
Collection of utility functions for mixed models including
\tabular{ll}{
wald: \tab Wald test with functions to generate hypothesis matrices\cr
gsp: \tab general spline with any degree and smoothness with additional function 'sc' to contruct hypotheses, smsp - easy smoothing splines with lme and nlme \cr
capply: \tab   create contextual variables. Also: cvar, dvar, up  \cr
Misc: \tab  vif.lme; xqplot; tab; panel.subgroups (additional level of subgroups in xyplot) \cr
}
}
\details{
\tabular{ll}{
Package: \tab spida\cr
Type: \tab Package\cr
Version: \tab 0.1-1\cr
Date: \tab 2010-07-19\cr
License: \tab GPL (>= 2)\cr
LazyLoad: \tab yes\cr
}
A local R package currently available from

http://www.math.yorku.ca/~georges/R/spida_0.1.zip

containing functions and some datasets developed for the courses
PSYC6140, MATH6630, MATH6643, MATH6627, SCS Workshops on Mixed Models,
the Summer Program in Data Analysis organized by SCS at York in June 2009
and MGT 1382 (in the MBA program at Rotman).

Many functions are inspired by, extensions of, or simply cobbled from functions in the 'car' package by John Fox.

Please send any comments or changes to: Georges Monette <georges@yorku.ca>

Partial list of functions:
\subsection{Tables:}{
\itemize{
    \item atotal: border an array with sums
    \item abind : glue two arrays together on a selected dimension
    \item tab( fmla, data ) : includes NAs
}
}
\subsection{Graphics:}{

    td    : easy front end to trellis.device and related functions
    xqplot: extended quantile plots
    panel.subgroups : to allow an extra level of subgroups in lattice graphics
}
\subsection{Splines:}{
\itemize{
\item    lsp : linear
\item    qs  : quadratic
\item    cs  : cubic
\item    gsp : general spline with arbitrary degree in each interval and
          arbitrary constraint at each knot
\item    sc  : function to generate hypothesis matrices for 'gsp' for use
          with Wald tests
\item    smsp: smoothing splines using mixed models
}
}
\subsection{Inference}{
\itemize{
\item    glh    - same as wald below but name retained for compatibility
\item    wald   - General Linear Hypothesis of fixed effects using a Wald test
      \itemize{
             \item should work on lm, lme, nlme and lmer objects
             \item wald( fit, L ) where 'L' is a hypothesis matrix performs a Wald test
             \item wald( fit, 'pat' ) where 'pat' is a regular expression (see ?regex)
               uses an L matrix that tests all fixed effects whose names match
               'pat'.  For example
                  > wald( fit, ':.*:' )
                 will test all 2- and higher-way interactions together.
            \item wald( fit, c(2,3,5) )  will test the 2nd, 3rd and 5th coefficients.
        }
\item    Lmat   - Lmat ( fit, 'pat' ) constructs a hypothesis matrix.
\item    Lform  - Lform( fit, list.of.formulas, data.frame ) constructs an L matrix
               applying each formula in the data.frame environment to create the
               corresponding column of the L matrix. Single scalars (e.g. 0 or 1)
               expand to fill the column.

\item    Leff and related tools (fdiff, flevs) simplify the visualization, estimation, testing and
         display of specific effects in models with complex interactions. See \code{\link{Leff}}.

\item    as.data.frame( wald( fit, Lform( fit, list.of.formulas, data.frame)), se = 2)
                returns a data frame with 'coef', 'coefp' = coef + se * std.error,
                'coefm' = coef - se * std.error.  This can be used for plotting
                fitted values with SEs for functions (e.g. lme) where the predict
                method does not produce standard errors, or where there is no
                predict method (e.g. lmer).
                
\item    Lmu

\item    Ldiff
    
\item    L2     - to come: will generate a hypothesis matrix that produces Wald-type
             Type II tests
             
\item    sc     - hypothesis matrices for splines

\item    cell   - a modified version of car::confidence.ellipse.lm that
             can add to a plot

\item    vif.lme - method for vif modelled on vif.lm from library car
             (note that model.frame and model.matrix are not implemented
              for lme objects)
}
}
\subsection{Linear algebra}{
\itemize{
\item    OrthoComp - a basis for the orthogonal complement of the orthogonal projection
                of span(X) into span(Z) within span(Z).
\item    ConjComp  - similar with respect to an inner product.
}
}
\subsection{Graphics for linear algebra}{
\itemize{
\item    vplot  - plots column vectors adding to current plot
\item    vell   - ellipse as a 2 x n matrix
\item    vbox   - box around unit circle
\item    orthog - 2 x 2 rotation
\item    orthog.prog 2 x 2 matrix of orthog projection
}
}
\subsection{File utilities}{
\itemize{
\item    Read.spss  : uses spss.get in library (Hmisc)
\item    Read.dta   : uses read.dta in library (foreign) with trimming and conversion
                 to factors. Reading an spss file that has been saved, in SPSS, as
                 a Stata 'dta' file seems to produce proper date variables.
\item    trim       : removes trailing blanks in character variables and factor levels
                 - useful to post-process files from SPSS read with read.dta
}
}
\subsection{Regression utilities:}{
\itemize{
\item    na.resid, na.fitted: pads with NAs to fit original data frame.
        These can be extended to additional classes by writing a method
        for 'na.pad'

\item    com, na.com: com(fit,'age') returns the component in 'fit' corresponding
        to effect that matches the regular expression 'age', na.com returns a
        vector padded with NAs to match the original data frame.

\item    comres, na.comres: component + residuals
}
}
\subsection{Multilevel utilities:}{
\itemize{
\item    varLevel( dd, fmla )   shows the level of each variable in data.frame dd
           - e.g. varLevel( dd, ~Board/School/Class/Subject ) or just
           - varLevel( dd, ~ID ) to identify inner and outer variables

\item    up ( dd, fmla , keep ) creates a summary data set using the first row of each
           set of rows identified by 'fmla'. 'keep' is the level below which to
           keep variables. By default, only 'outer' variables are kept.
           Caution: currently uses library(nlme) which conflicts with library(lme4)

\item    capply ( x, data, FUN, ...) creates 'contextual' variables
           - like tapply but replicating the original shape
           - the ouput of FUN can also be time-varying with the same length
             as the argument
             
\item    xapply.formula ( fmla, by, FUN, ...) a formula interface to 'aggregate'
           - can be used with 'expand.grid' to create a variable whose values
             depend on other variables
           - useful to create 'prediction data frames'
             
\item    fill ( x, by, FUN , ... )   uses capply to create contextual variable by selecting
             a value. Works intelligently with factors and 'Date's.
           - the default FUN selects a unique value and can be used when
             a long data frame has been created with values for macro variables
             only in the first position.

\item    cvar ( x, id )  creates 'contextual' variables like 'capply' but using the mean.
             cvar also works when 'x' is a factor and returns a matrix with
             (length( levels(x) ) - 1) columns with group mean values
             of the coding matrix.

\item    dvar ( x, id ) is almost equivalent to x - cvar( x, id ) except that it is
             interpreted correctly when 'x' is a factor.
}
}
\subsection{Miscellaneous utilities:}{
\itemize{
\item    labs( dframe ) <- c('rows','colums')
             adds an attribute 'labs' to a data frame and adds the class
             'data.frame.lab'. 'print.data.frame.lab' uses 'labs' as headings
             for rownames and column names, in parallel to the effect

             If 'mat' is a matrix, labs( mat ) is equivalent to:
             > names(dimnames(mat)) <- c('rows','columns')
}
}
\subsection{Recent Changes:}{
\itemize{
\item    December 8, 2008
        predict.mer   -  a crude predict method for 'mer' objects
                         requires a repetition of the model formula

\item    August 8, 2008
        sc = generate coefficients for a spline for glh
        smsp : basis for a smoothing spline

\item    July 31, 2008  -- new version:
        gsp ( x, k, degree, smooth) : general polynomial spline with
              variable degrees in each interval and variable smoothness
              at each knot.

\item    July 29, 2008
        eg -- INCOMPLETE a more efficient version expand.grid that takes
             level information from a data frame.
}
}
}
\author{
Georges Monette <georges@yorku.ca>
}
\references{
Monette, G. (1990).
Geometry of Multiple Regression and Interactive 3-D Graphics.
In Fox, J. & Long, S. (ed.) 
\emph{Modern Methods of Data Analysis}, Sage Publications, 209-256.

}
\keyword{ package }
\seealso{
%~~ Optional links to other man pages, e.g. ~~
\code{\link[nlme]{lme}} ~~
}
\examples{
~~ simple examples of the most important functions ~~
}
