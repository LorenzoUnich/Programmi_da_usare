def tdc_to_events(fname):
  file = open(fname, "r")
  n = 0
  q = 0
  col = 0
  car = 0
  locdict = {}
  events = []
  for f in file: 
      #print(f)
      #print(df)
      if q ==4:#parte di programma che mette il dizionario nella lista
          k = locdict.keys()
          for h in k:
              lista = locdict[h]
              lista_int= [int(y) for y in lista]
              events.append(lista_int)
          #for nr in k: ci ho un po' provato a mettere nel dataframe, senza successo. Per ora ci basta pensare alla lista
              
             # try:
             #     print("GOING")
             #     print(locdict[nr])
             #     print(df)
             #     df.loc[len(df), "event"+str(nr)] = locdict[nr]
             # except KeyError:
             #     print("AIUTO")
             #     cose = [np.nan for i in range(len(df.index))]
             #     toadd = cose+locdict[nr]
             #     title = "event "+str(nr)
             #     df[title] = toadd
                  
          locdict = {}
          q = 0
          col =0
      for i in range(len(f)):
          #print(locdict)
          #print("f_i="+str(f[i]))
          #print("col="+str(col))
          #print("car="+str(car))
          #print("q"+str(q))
          if f[i] == "\n":
              q+=1
              col = 0
              car = 0            
              n+=1
              break
          elif f[i] == "\t":
              col += 1
              car =0 
          else:
              if car ==0 and q == 0:
                  locdict[col]=[f[i]]
                  car= 1
              elif car ==0:
                  locdict[col].append(f[i])
                  car +=1
              else:
                  #print(locdict)
                  locdict[col][q]+=f[i]
                  car+=1
                  
                  
              
  
  file.close()
  return events