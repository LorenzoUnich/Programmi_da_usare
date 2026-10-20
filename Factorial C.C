//my first autonomously written C programme
// Maybe my first sensbile one, withoud staling code from left and right or eworking on someone else's code
// put ; after every line of delcaration of something or after it does something



#include <stdio.h>



int factorial(int n){
	int result = 1;
	if (n>=0){
  // that %d\n is a placeholder that tel the function printf where to put the n variable
	printf("Computing the factorial of %d\n", n);
   
    
    int i=0;
    for (i=1; i <=n; i++)
    // something before the cycle; what to check (condition) for the cycle; what to do at the end of each cycle
    
    	result=result*i;
									}
    else{
    
      printf("number not valid");
      result = -1;
    }
		
	return result;



}



int main() {
    int numero = 5;
    
    // Come chiami la funzione: scrivi il suo nome e le passano il valore tra parentesi
    int mio_risultato = factorial(numero); 
    
    printf("Il risultato finale è: %d\n", mio_risultato);
    
    return 0;
}


