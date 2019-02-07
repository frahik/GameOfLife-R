#' Game of life
#'
#' @param sandbox_dimension (\code{integer}) Dimension of the sandbox,
#'                  by default are 100 (a 100 x 100 matrix).
#' @param iterations (\code{integer}) Number of simulations that will be stored
#'                  in the exported file, by default 300 simulations are stored.
#' @param probability_of_initial_existence (\code{double}) Probability that a
#'                  cell exists at the beginning of the simulation.
#' @param interactive (\code{Boolean}) Should export a .Gif? or return as array?.
#' @param delay_time (\code{integer}) Time in milliseconds of waiting for the
#'                  frame change in the .GIF animation.
#' @param path (\code{string}) Path where the .GIF file will be saved.
#'
#' @return .Gif File with the simulation.
#'
#' @importFrom stats rbinom
#' @export
#'
#' @examples
#' \dontrun{
#' game_of_life()
#' game_of_life(sandbox_dimension = 100)
#' game_of_life(sandbox_dimension = 100, iterations = 300)
#' game_of_life(sandbox_dimension = 100, iterations = 300,
#'              probability_of_initial_existence = 0.35)
#' game_of_life(sandbox_dimension = 100, iterations = 300,
#'              probability_of_initial_existence = 0.35, delay_time = 5)
#' game_of_life(sandbox_dimension = 150, iterations = 100,
#'              probability_of_initial_existence = 0.15, delay_time = 20)
#' }
game_of_life <- function(sandbox_dimension = 100, iterations = 300,
                         probability_of_initial_existence = 0.35, interactive = TRUE,
                         delay_time = 10, path = '~/') {

  # Make a matrix of the dimensions of the sandbox_dimension parameter.
  sandbox <- matrix(nrow = sandbox_dimension, ncol = sandbox_dimension)

  # Fill the matrix with a binomial distribution with
  # defined probability of success (a cell exist).
  sandbox[] <- rbinom(sandbox_dimension^2, size = 1,
                      prob = probability_of_initial_existence)

  # Pre allocate the array to store all the steps of the simulation.
  simulation_storage <- array(dim = c(sandbox_dimension, sandbox_dimension,
                                      iterations))

  # Simulation loop
  for (step_iteration in seq_len(iterations))  {
    # Move the cells of the initial matrix, like a  Minesweeper logic.
    sandbox_tmp <- shift_sandbox(sandbox, sandbox_dimension)

    # Apply the rules of the game, using logical subscripting
    sandbox <- game_of_life_rules(sandbox, sandbox_tmp)

    # The simulation is stored.
    simulation_storage[ , , step_iteration] <- sandbox
  }

  if (interactive) {
    # Export the simulation to a GIF.
    caTools::write.gif(simulation_storage, paste0(path,'life_game_simulation_',
                                                  format(Sys.time(), "Time_%H-%M-%S__Day_%d-%m-%Y"),'.gif'),
                       col = 'jet', delay = delay_time)
  } else {
    return(list(simulation = simulation_storage,
                sandbox_dimension = sandbox_dimension, iterations = iterations,
                probability_of_initial_existence = probability_of_initial_existence))
  }

}

# Private function
shift_sandbox <- function(sandbox, sandbox_dimension) {
  to_right <- cbind( rep(0, sandbox_dimension) , sandbox[, -sandbox_dimension] )
  to_down_right <- rbind(rep(0, sandbox_dimension),
                      cbind(rep(0, sandbox_dimension - 1),
                            sandbox[-sandbox_dimension, -sandbox_dimension]))
  to_down <- rbind(rep(0, sandbox_dimension), sandbox[-sandbox_dimension, ])
  to_down_left  <- rbind(rep(0, sandbox_dimension),
                          cbind(sandbox[-sandbox_dimension, -1],
                                rep(0, sandbox_dimension - 1)))
  to_left   <- cbind(sandbox[, -1], rep(0, sandbox_dimension))
  to_up_left  <- rbind(cbind(sandbox[-1, -1],
                                rep(0, sandbox_dimension - 1)),
                          rep(0, sandbox_dimension))
  to_up   <- rbind(sandbox[-1, ], rep(0, sandbox_dimension))
  to_up_right  <- rbind(cbind(rep(0, sandbox_dimension - 1),
                               sandbox[-1, -sandbox_dimension]),
                         rep(0, sandbox_dimension))

  # return the sum of the matrices
  return(to_right + to_down_right + to_down + to_down_left + to_left +
           to_up_left + to_up + to_up_right)
}

# Private function
game_of_life_rules <-  function(original_sandbox, shifted_sandbox) {
  # Make a copy for safe edit.
  sandbox_copy <- original_sandbox

  # 1.- If the space is empty and there are only three cells around, a new cell born.
  sandbox_copy[original_sandbox == 0 & shifted_sandbox == 3] <- 1

  # 2.- If the space is occupied and there exist two or less cells around,
  #     the cell die of loneliness.
  sandbox_copy[original_sandbox == 1 & shifted_sandbox < 2] <- 0

  # 3.- If the space is occupied and there exist more than three cells around,
  #     the cell die of overpopulation.
  sandbox_copy[original_sandbox == 1 & shifted_sandbox > 3] <- 0
  return(sandbox_copy)
}
