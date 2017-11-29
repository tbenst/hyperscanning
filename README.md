Requires the Functional Programming Constructs installed from Add-on Explorer.
Several non-free toolboxes (Signal processing, Statistics, and Econometrics) also required
Code tested on MATLAB 2017a--older versions may not work

Example command:
fileSelection = 0; timeSelection = 2; onlyPreOT = 0; saveFig = 'no'; scriptToRun='hyperscanningControl.m'; master();

Second example:
reset(); fileSelection = 4; timeSelection = 1; onlyPreOT = 0; scriptToRun='forecasting.m'; master();

## Choosing similar subpopulations of neurons between two monkey brains
[scripts/analyze](https://github.com/tbenst/hyperscanning/blob/master/scripts/analyze.m) provides a flexibly approach to constructing subpopulations such that data collected from two different brains can be compared in an apples-to-apples fashion. As this matching is subjective, the code uses higher-order functions that take functions as arguments. For example, it requires one line of code to switch from using a symmetric Kullback-Leibler divergence to a simple differencing of spike counts.

One approach explored was to construct a histogram of inter-spike intervals for each neuron in both brains, apply a kernel smoother, and then calculate the pairwise KL divergence for each pair of neurons between brains (bipartite graph). Then, we use the Munkres algorithm to solve the assignment problem, and choose the subset of neurons in each brain that minimizes statistical differences between the two populations. Now we can perform direct comparisons between brains, e.g. population firing rate by trial/outcome, spectral density by trial/outcome, etc.
