
<p align="center">

<h3 align="center">

Game of Life in R | Version 1.0

</h4>

<p align="center">

<a href="https://www.tidyverse.org/lifecycle/#archived">
<img src="https://img.shields.io/badge/lifecycle-archived-red.svg" alt="Archived">
</a> <a href="https://travis-ci.org/frahik/GameOfLife-R">
<img src="https://travis-ci.org/frahik/GameOfLife-R.svg?branch=master" alt="Travis build status">
</a> <a href='https://coveralls.io/github/frahik/GameOfLife-R'>
<img src='https://coveralls.io/repos/github/frahik/GameOfLife-R/badge.svg?branch=master' alt='Coverage Status'/>
</a> <a href="https://www.gnu.org/licenses/lgpl-3.0">
<img src="https://img.shields.io/badge/License-LGPL%20v3-blue.svg" alt="LGPL, Version 3.0">
</a> <a href="http://www.repostatus.org/#inactive">
<img src="https://www.repostatus.org/badges/latest/inactive.svg" alt="The project has reached a stable, usable state but is no longer being actively developed; support/maintenance will be provided as time allows.">
</a>

</p>

<h4 align="center">

\[Last README update: 2019-02-07\]

</h4>

</p>

-----

The Game of Life is a ‘cellular automaton’, and was invented by
Cambridge mathematician John Conway.

This ‘package’ is an simple example of this game.

To complete installation of this version, use the followin code.

``` r
install.packages('devtools')
devtools::install_github('frahik/GameOfLife-R')
```

<h2 id="example">

Example of use

</h2>

``` r
library(GameOfLife)
game_of_life(sandbox_dimension = 500, probability_of_initial_existence = 0.5, delay_time = 30, iterations = 200, path = '')
```

This is the output on the path folder.

<a href="https://github.com/frahik/GameOfLife-R">
<img src="life_game_simulation_Time_11-15-42__Day_07-02-2019.gif" alt="GameOfLife-R"/>
</a>

<h2 id="authors">

Authors

</h2>

  - Francisco Javier Luna-Vázquez (Author, Maintainer)
