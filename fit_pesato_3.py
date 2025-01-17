#ATTENZIONE: questo codice per funzionare ha bisogno di numpy
import numpy as np 
def fit(x,y,yerr_i, outtype = True):
  #N.B.: la funzione utilizza come formula della retta y=a+bx ! (lo so, sono un cane) 
  if type(yerr_i) ==int or type(yerr_i) ==float:
    yerr =[yerr_i for i in range(len(x))]
  else:
    yerr = yerr_i
  if len(x)!=len(y) or len(yerr)!=len(y):
    raise Exception("Le liste di input non sono della stessa lunghezza!")
  try:
    chi_quadro = 0
    y_err2 =[i**2 for i in yerr]
    W,Y,X = 0,0,0
    XX, XY= 0,0
    for i in range(len(x)):
      if np.isnan(x[i]) == False and np.isnan(y[i])== False:
        if np.isnan(yerr[i]) == False:
            W += 1/y_err2[i]
            X += x[i]/y_err2[i]
            Y += y[i]/y_err2[i]
            XX += (x[i]**2)/y_err2[i]
            XY += (x[i]*y[i])/y_err2[i]
    delta = W*XX-(X**2)
    A_mc = (XX*Y-X*XY)/delta
    B_mc = (W*XY-X*Y)/delta
    sigmaAmc=(XX/delta)**0.5
    sigmaBmc=(W/delta)**0.5
    for i in range(len(x)):
      if np.isnan(x[i]) ==False and np.isnan(y[i])== False:
            chi_quadro += (y[i]-A_mc-x[i]*B_mc)**2/(y_err2[i])
            
            

    if outtype==False:  
      return ['A_mc:',A_mc,'B_mc:',B_mc,'sigmaA:', sigmaAmc,'sigmaB:', sigmaBmc,'chi^2:', chi_quadro]
    else:
      return [A_mc,B_mc, sigmaAmc, sigmaBmc, chi_quadro]
  except ZeroDivisionError:
    return ['A_mc:',None,'B_mc:',None, 'sigmaA:', None,'sigmaB', None,'chi^2:',None]
    print("Il programma ha incontrato errori di divisione per zero")
    #questa ultima linea di codice serve a fornire un risultato in casi degeneri
