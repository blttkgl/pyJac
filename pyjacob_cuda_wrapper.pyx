#! /usr/bin/env python2.7

import numpy as np
cimport numpy as np
cimport cython

cdef extern from "pyjacob.cuh":
    void run(int num, const double* pres, const double* mass_frac,
            double* conc, double* fwd_rxn_rates, double* rev_rxn_rates,
            double* pres_mod, double* spec_rates, double* dy, double* jac);

@cython.boundscheck(False)
def py_curun(int num,
            np.ndarray[np.double_t, mode='c'] pres,
            np.ndarray[np.double_t, mode='c'] y,
            np.ndarray[np.double_t, mode='c'] conc,
            np.ndarray[np.double_t, mode='c'] fwd_rates,
            np.ndarray[np.double_t, mode='c'] rev_rates,
            np.ndarray[np.double_t, mode='c'] pres_mod,
            np.ndarray[np.double_t, mode='c'] spec_rates,
            np.ndarray[np.double_t, mode='c'] dy,
            np.ndarray[np.double_t, mode='c'] jac):
    run(num, &pres[0], &y[0], &conc[0], &fwd_rates[0], &rev_rates[0],
             &pres_mod[0], &spec_rates[0], &dy[0], &jac[0])