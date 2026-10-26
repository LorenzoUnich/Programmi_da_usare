/* my first autonomously written C programme
Maybe my first sensbile one, withoud stealing code from left and right or eworking on someone else's code
here and there comments in order to help you remember the C synatax
This for example is a multi-line comment!
put ; after every line of delcaration of something or after it does something */



#include <stdio.h>


/remember to always declare the type of your variable
int factorial(int n){
	int result = 1;
	if (n>=0){
  // that %d\n is a placeholder that tell the function printf where to put the n variable
	printf("Computing the factorial of %d\n", n);
   
    
    int i=0;
    for (i=1; i <=n; i++)
    // (something before the cycle; what to check (condition) for the cycle; what to do at the end of each cycle)
    
    	result=result*i;
									}
    else{
    
      printf("number not valid");
      result = -1;
    }
		
	return result;



}


/ this part is what really runs the code
int main() {
    int numero = 5;
    
    // Come chiami la funzione: scrivi il suo nome e le passano il valore tra parentesi
    int mio_risultato = factorial(numero); 
    
    printf("Il risultato finale è: %d\n", mio_risultato);
    
    return 0;
}


