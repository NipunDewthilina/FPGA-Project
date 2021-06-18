/**
Inputs : n - Dimension of the Matrix is (nxn),
 M[i,k] - Components of 1st matrix, M[k,j] - components of 2nd matrix
Ouputs : M[i,j] - Components of Result Matrix
**/


START			;PC<=0, AR<=0	
CLAC			;AC<=0, Z<=1	
MOVACR1			;R1<=AC ;	R1 = 0;
0'd0        //to select the location of i ;AC<=0'd0
MOVACAR			;AR<=AC
STAC i			;M[0'd0 ]<=AC;	i = 0
LDIAC n			;AC<=n;	AC = n
MOVACR4         ;R4<=AC	
0'd1			//to select the location of j ;AC<=0'd1
MOVACAR        	;AR<=AC
MOVR4AC         ;AC<=R4
STAC j			;M[0'd1]<=AC	;j = 2n
MOVAC			;R<=AC;	R = AC = n
ADD			;AC<=AC+R;	AC = AC+R = 2n
MOVACR4         ;R4<=AC	
0'd4			//to select the location of two_n ;AC<=0'd4
MOVACAR        	;AR<=AC
MOVR4AC         ;AC<=R4
STAC two_n		;M[0'd4]<= AC;	two_n = AC
MOVACR4         ;R4<=AC	
0'd2			//to select the location of k ;AC<=0'd2
MOVACAR        	;AR<=AC
MOVR4AC         ;AC<=R4
STAC k			;M[0'd1]<=AC	;j = 2n
MOVAC			;R <= AC;	R = AC = two_n
LDIAC n			;AC <= n;	AC = n
ADD			    ;AC <= AC+R;	AC = AC+R = two_n+n = 2n+n = 3n
MOVACR4         ;R4<=AC	
0'd5			//to select the location of three_n ;AC<=0'd5
MOVACAR        	;AR<=AC
MOVR4AC         ;AC<=R4
STAC three_n			;M[0'd5] <=AC;	three_n  = AC = two_n + n = 3n

//Here atlast, i = 0, j = n, k = 2n, so i is varied in the loops in between [0,n)
//j varied in between [n,2n)
//k varied in between [2n,3n)
//i value stored in 0'd0, j value stored in 0'd1, k value stored in 0'd2, n value stored in 0'd3,
//two_n stored in 0'd4, three_n stored in 0'd5 inside the DATA MEMORY

mainloop1:	LDIAC i ;AC<=i
	SHIFT			;AC<=AC<< width_of_i
	MOVAC			;R<=AC
	LDIAC k			;AC<=k
	ADD				;AC<=AC+R
	LDAC M[i,k]		;AC<=M[i,k]	
	MOVACR2			;R2<=AC	
	LDIAC k			;AC<=k		
	SHIFT			;AC<=AC<<width_of_i
	MOVAC			;R<=AC
	LDIAC j			;AC<=j
	ADD				;AC<=AC+R
	LDAC M[k,j]	;AC<=M[k,j]
	MVAC		;R<=AC
	MVR2AC      ;AC<=R2
	MULT		;AC<=AC*R	
	MOVAC		;R<=AC	
	MOVR1AC		;AC<=R1	
	ADD		    ;AC<=AC+R	
	MOVACR1		;R1<=AC	 //data is updated in R1 register
	LDIAC k		;AC<=k	
	INAC		;AC<=AC+1	
	MOVAC		;R<=AC
	MOVACR4         ;R4<=AC	
	0'd2			//to select the location of k ;AC<=0'd2
	MOVACAR        	;AR<=AC
	MOVR4AC         ;AC<=R4
	STAC k		;M[0'd2]<=AC	
	LDIAC three_n		;AC<=three_n	
	SUB		    ;AC<=AC-R; if AC-R = 0, Z = 1 ;else, Z = 0;	AC = AC-R;
	JPNZ mainloop1	;if Z =0, JUMP to loop1	
	//one element now created, now, this element is saved in i,j and also, k should update again to 2n for the
	//next loop.
LDIAC i				;AC<=i
SHIFT				;AC<=AC<<width_of_i
MOVAC				;R<=AC
LDIAC j				;AC<=j
ADD					;AC<=AC+R  //memory location now created
MOVACAR			;AR<=AC; AR= AC= i,j
MOVR1AC			;AC<=R1
STAC 			;M[i,j]<=AC	
LDIAC two_n		;AC<= two_n ;AC= 2n
MOVACR4             ;R4<=AC
0'd2			//to select the location of k ;AC<=0'd2
MOVACAR        	;AR<=AC
MOVR4AC         ;AC<=R4
STAC k			        ;M[0'd2]<=AC	;k=two_n = 2n
mainloop2:	LDIAC j		;AC<=j	;AC = j = two_n
	INAC		;AC<=AC+1	
	MOVACR4      ;R4<=AC
	0'd1			//to select the location of j ;AC<=0'd1
	MOVACAR        	;AR<=AC
	MOVR4AC         ;AC<=R4
	STAC j		;M[0'd1]<=AC	
	MOVAC		;R<=AC	
	LDIAC two_n		;AC<=two_n	
	SUB		    ;AC<=AC-R; if AC-R = 0, Z = 1 ;else, Z = 0;	AC = AC-R;	
	JPNZ mainloop1		;if Z =0, JUMP to loop1	
LDIAC n			;AC<=n
MOVACR4             ;R4<=AC
0'd1			//to select the location of j ;AC<=0'd1
MOVACAR        	;AR<=AC	
MOVR4AC         ;AC<=R4
STAC j			;M[0'd1]<=AC	;j=two_n
mainloop3:	LDAC i		;AC<=i	
	INAC		;AC<=AC+1	
	MOVACR4             ;R4<=AC
	0'd0			//to select the location of i ;AC<=0'd0
	MOVACAR        	;AR<=AC
	MOVR4AC         ;AC<=R4
	STAC i		;M[0'd0]<=AC	
	MOVAC		;R<=AC	
	LDIAC n		;AC<=n	
	SUB		    ;AC<=AC-R; if AC-R = 0, Z = 1 ;else, Z = 0;	AC = AC-R;
	JPNZ mainloop2		;if Z =0, JUMP to loop2	
ENDOP	

//Here I save i,j,k after every increment in the Data Memory to make the access for j to different cores
