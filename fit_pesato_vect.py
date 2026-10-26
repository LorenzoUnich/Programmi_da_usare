
import numpy as np

def fit(x, y, yerr_i, outtype=True):
    x = np.asarray(x, dtype=float)
    y = np.asarray(y, dtype=float)

    if np.isscalar(yerr_i):
        yerr = np.full(len(x), yerr_i, dtype=float)
    else:
        yerr = np.asarray(yerr_i, dtype=float)

    if len(x) != len(y) or len(yerr) != len(y):
        raise ValueError("Le liste di input non sono della stessa lunghezza!")

    # Selezione dei dati validi
    mask = (
        np.isfinite(x)
        & np.isfinite(y)
        & np.isfinite(yerr)
        & (yerr != 0)
    )

    x = x[mask]
    y = y[mask]
    yerr = yerr[mask]

    try:
        # Pesi statistici
        w = 1.0 / yerr**2

        # Sommatorie pesate
        W = np.sum(w)
        X = np.sum(w * x)
        Y = np.sum(w * y)
        XX = np.sum(w * x**2)
        XY = np.sum(w * x * y)

        delta = W * XX - X**2

        A_mc = (XX * Y - X * XY) / delta
        B_mc = (W * XY - X * Y) / delta

        sigmaAmc = np.sqrt(XX / delta)
        sigmaBmc = np.sqrt(W / delta)

        # Chi-quadro vettorializzato
        chi_quadro = np.sum(
            (y - A_mc - x * B_mc)**2 / yerr**2
        )

        if outtype is False:
            return [
                'A_mc:', A_mc,
                'B_mc:', B_mc,
                'sigmaA:', sigmaAmc,
                'sigmaB:', sigmaBmc,
                'chi^2:', chi_quadro
            ]

        return [A_mc, B_mc, sigmaAmc, sigmaBmc, chi_quadro]

    except (ZeroDivisionError, FloatingPointError):
        if outtype is False:
            return [
                'A_mc:', None,
                'B_mc:', None,
                'sigmaA:', None,
                'sigmaB:', None,
                'chi^2:', None
            ]
        return [None, None, None, None, None]
