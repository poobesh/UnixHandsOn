#!/bin/bash
awk '{for(i=1; i<=NF; i++)
     {A[$i]++}}
     END{for(k in A)

     
	     if(A[k] -gt 0)
		     {
			     print k, A[k]}
			     A[k]=0 }' Animal.txt
