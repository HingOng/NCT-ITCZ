# NCT-ITCZ
The NCT-ITCZ (NCT, nontraditional Coriolis term; ITCZ, intertropical
convergence zone) model solves two diagnostic equations for meridional-
vertical mass stream function; one involves NCTs, and the other does not.
An ITCZ-like forcing and a constant dissipation rate are prescribed. The
model solves the equation iteratively using the multigrid method.

The "main" script implements the NCT-ITCZ model:
(1) initialize by calling "namelist"
(2) setup by calling "domain" "basic_state" "forcing" "coefficient_NCT" and
    "coefficient_TCT"
(3) solve for the stream function by calling "solutions"
(4) analyze v, w, u, th by calling "analyses"

For beginning users, run "main.m" and "visualize.m" in order with the
default settings, and then change the model parameters in "namelist.m"

Hing Ong, 23 Jan 2019
hwang2@albany.edu
