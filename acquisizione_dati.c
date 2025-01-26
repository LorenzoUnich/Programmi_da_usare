/**************************************************

compile with the command: gcc acqd.c rs232.c -Wall -Wextra \-o2 -o acqd.exe
run with sudo ./acqd.exe 1

**************************************************/

/* Allo queste sono cose che stiamo chiedendo di fare al pre processore. 
Cioè viene eseguito prima che tu inizi a far lavorare il processore (è tempo di compliazione
, giargiana)*/ 

#include <stdlib.h>
#include <stdio.h>
#include <sys/time.h>
#include <time.h>

#ifdef _WIN32
#include <Windows.h>
#else
#include <unistd.h>
#endif

#include "rs232.h"


double decodeTemperature(unsigned int rbuf);
double decodeHumidity(unsigned int rbuf, double temperature_ref, double val_temp);

int main(int argc, char *argv[])
{

    struct tm *gmp;
    struct tm gm; 
    time_t t, t0;
    int ty, tmon, tday, thour, tmin, tsec, time_acq_h_MAX;
    float time_acq_h;
    int i, n, nloc, InitFlag, StartFlag, nhit, hit, trg, cport_nr=17, bdrate=115200;
/* cport_nr è il numero della porta di comunicazione, brate= baud rate, 
quante volte io interrogo */  
    char pacchetto[9] = "pacchetto"; 
    struct timeval current_time_0;
    struct timeval current_time;
    int j;
        
        
  int cnt=0;
  FILE *file;
  FILE *currN; //file that stores current run name to be used by external programs
  FILE *pacchetti;
  double val_temp, val_hum_corrected;
  unsigned char buf[4096], sht75_nblab03_frame[4];
// questa lista ti serve a ospitare i dati. 
  unsigned int val_temp_int, val_hum_int;
  char NameF[100];

  char mode[]={'8','N','1',0}; 
  
  /* questo è un array che contiene tutti i parametri 
per la trasmissione dei dati: rispettivamente si intende un trasferimento a pacchetti di 8 bits, senza bit di
parità, uno di chiusura e senza controllo del flusso*/
  
  
  if (argv[1] == NULL)
       {
	        printf("format: read_rx Numero di ore di acquisizione \n");
            return -1;
       }	
   else
       { 
      
      gettimeofday(&current_time_0, NULL);
      
      // t0 per lo start del run 
      t0 = time(NULL);
      gmp = gmtime(&t0);
      if (gmp == NULL)
          printf("error on gmp");

      gm = *gmp;

      ty = gm.tm_year + 1900;
      tmon = gm.tm_mon + 1;
      tday = gm.tm_mday;
      thour = gm.tm_hour;
      tmin = gm.tm_min;
      tsec = gm.tm_sec;

            time_acq_h_MAX = atoi(argv[1]);
            sprintf(NameF,"sht75_nblab03_Hum_Temp_RUN_%04d%02d%02d%02d%02d%02d_%d_h.txt",ty,tmon,tday,thour,tmin,tsec,time_acq_h_MAX);
            printf("file_open %s --> durata in ore %d\n", NameF, time_acq_h_MAX);
            file = fopen(NameF, "w+" );
       }

       //writing the file name to the current run name file to be read and used by external programs
        //------------------------------------------------------------------------------------------- 
        currN = fopen("currN.txt", "w");
        fprintf(currN, NameF);
        fclose (currN);
        //------------------------------------------------------------------------------------------- 

  
  
  if(RS232_OpenComport(cport_nr, bdrate, mode))
  {
    printf("Can not open comport\n");
    return(0);
  }
  
  

  InitFlag=0;
  nloc=0;
  trg=0;
  pacchetti = fopen("pacchetti.txt", "w+");
 /*  w+ crea un nuovo file di scrittura e lettura. Se il file esiste allora
 lo cancella*/
  while(1)
  {
    
    n = RS232_PollComport(cport_nr, buf, 4095);
    
    
    // tempo evento
    t = time(NULL);
    gmp = gmtime(&t);
    if (gmp == NULL)
    printf("error on gmp");
    //printf("%d %d ", cnt, n);
    gm = *gmp;   
    time_acq_h = (float)(t-t0);
    
    //printf("time diff: %.3f (sec) \n", time_acq_h);

    if (time_acq_h > time_acq_h_MAX * 3600)
		{
			printf(" time_duration RUN in hours > %d \n", time_acq_h_MAX);
			break;
		}  
       
    
      
    
    gettimeofday(&current_time, NULL);
    

    if(n > 0)
    {
   
    buf[n] = 0; 
    nhit=n/6;
    hit=0; 
    //printf("nhit %d \n", nhit); 
      
     

    for(i=0; i < n; i++)
    {
    
    
     
      
	if (InitFlag==1)
        {
        

      	    sht75_nblab03_frame[nloc]=buf[i];

	        if (nloc==1)
            {
            printf("pacchetto %d\n", trg);
            fprintf(pacchetti, "pacchetto %d\n", trg);
          
            //printf("seconds : %ld\n", (((current_time.tv_sec * 1000000 + current_time.tv_usec) - (current_time_0.tv_sec * 1000000 + current_time_0.tv_usec))/1000000));
            //fprintf(pacchetti, "seconds : %ld\n", (((current_time.tv_sec * 1000000 + current_time.tv_usec) - (current_time_0.tv_sec * 1000000 + current_time_0.tv_usec))/1000000));
            printf("seconds : %f\n", (((current_time.tv_sec * 1000000 + current_time.tv_usec) - (current_time_0.tv_sec * 1000000 + current_time_0.tv_usec))/1000000.));
            fprintf(pacchetti, "seconds : %f\n", (((current_time.tv_sec * 1000000 + current_time.tv_usec) - (current_time_0.tv_sec * 1000000 + current_time_0.tv_usec))/1000000.));

            printf("AA AA\n");
            fprintf(pacchetti, "AA AA\n");
            printf("%x %x\n", sht75_nblab03_frame[0], sht75_nblab03_frame[1]);
            fprintf(pacchetti, "%x %x\n", sht75_nblab03_frame[0], sht75_nblab03_frame[1]);
            

        
             
             val_hum_int=(sht75_nblab03_frame[0]<<8)|(sht75_nblab03_frame[1]);
	           val_hum_corrected = decodeHumidity(val_hum_int, 25, val_temp);
             
             
             //fprintf(file,"%d %d %d %d %.2f", trg, gm.tm_year+1900,gm.tm_mon+1, gm.tm_mday, 3600*gm.tm_hour + 60*gm.tm_min + (float)gm.tm_sec); 
             //fprintf(file,"%d %d %d %d %.2f %f", trg, gm.tm_year+1900, gm.tm_mon+1, gm.tm_mday, (current_time.tv_sec * 1000000 + current_time.tv_usec)/1000000., (((current_time.tv_sec * 1000000 + current_time.tv_usec) - (current_time_0.tv_sec * 1000000 + current_time_0.tv_usec))/1000000.)); 
             fprintf(file,"%d %d %d %d %.2f %f", trg, gm.tm_year+1900, gm.tm_mon+1, gm.tm_mday, 3600*gm.tm_hour + 60*gm.tm_min + (float)gm.tm_sec, (((current_time.tv_sec * 1000000 + current_time.tv_usec) - (current_time_0.tv_sec * 1000000 + current_time_0.tv_usec))/1000000.));
             fprintf(file," %d %.2f ", val_hum_int, val_hum_corrected);
              
             trg++;
             hit++;
             }
      	     else if(nloc==3)
    	     {
             printf("%x %x\n", sht75_nblab03_frame[2], sht75_nblab03_frame[3]);
             fprintf(pacchetti, "%x %x\n", sht75_nblab03_frame[2], sht75_nblab03_frame[3]);
            
             val_temp_int=(sht75_nblab03_frame[2]<<8)|(sht75_nblab03_frame[3]);
	         val_temp=decodeTemperature(val_temp_int);
             
             fprintf(file,"%d %.2f\n", val_temp_int, val_temp);
             }
             else if (nloc>5)
	         {
	         printf("error on nloc\n");
	         }
	    
            }
         
         nloc++;

                
         

         
         if (i>0 && buf[i]==0xAA && buf[i-1]==0xAA)
            {
                
                StartFlag=1;
                nloc=0;
	            if (InitFlag==0)
                {
                    InitFlag=1;
                }
            }  
         
          
    
    }
    
       
    //printf("cnt %d received %i bytes \n", cnt, n);
    
    cnt++;
    }

//ATTENZIONE: QUI HO FATTO LA MIA PICCOLA MODIFICA AL CODICE     
int duration_time = 400
#ifdef _WIN32
    Sleep(duration_time);
#else
    usleep(duration_time*1000); 
#endif
  }
  fclose (pacchetti);
  fclose (file);
  
  return(0);
}



double decodeTemperature(unsigned int rbuf) {
double d1, d2, rd_val;
d1=-39.6;
d2=0.01;
rd_val=(double)rbuf + 0.;
return d1+d2*rd_val ;
}

double decodeHumidity(unsigned int rbuf, double temperature_ref, double val_temp){
double c1, c2, c3, rd_val, hum_val, hum_val_corrected;
c1 = -2.0468;
c2 = 0.0367;
c3 = -1.5955e-6;
rd_val = (double)rbuf;
hum_val = c1+c2*rd_val+c3*(rd_val)*(rd_val);
hum_val_corrected = (val_temp - temperature_ref) * (0.01 + 0.00008 * rd_val) + hum_val;
//return hum_val;  
return hum_val_corrected;
}


