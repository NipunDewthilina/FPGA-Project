/**
Inputs : n - Dimension of the Matrix is (nxn),
 M[i,k] - Components of 1st matrix, M[k,j] - components of 2nd matrix
Ouputs : M[i,j] - Components of Result Matrix
**/


START			;PC<=0, AR<=0	
CLAC			;AC<=0, Z<=1	
MOVACR1			;R1<=AC ;	R1 = 0;
STAC i			;i<=AC;	i = 0
LDIAC n			;AC<=n;	AC = n
MOVAC			;R<=AC;	R = AC = n
ADD			;AC<=AC+R;	AC = AC+R = 2n
STAC two_n		;two_n<= AC;	two_n = AC
STAC j
MOVAC			;R <= AC;	R = AC = two_n
LDIAC n			;AC <= n;	AC = n
ADD			    ;AC <= AC+R;	AC = AC+R = two_n+n
STAC three_n			;three_n <=AC;	three_n  = AC = two_n + n = nx2 + n
STAC k
MOVAC
LDIAC n
ADD
STAC four_n
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
	MOVACR1		;R1<=AC	
	LDIAC k		;AC<=k	
	INAC		;AC<=AC+1	
	MOVAC		;R<=AC	
	STAC k		;k<=AC	
	LDIAC four_n		;AC<=four_n	
	SUB		    ;AC<=AC-R; if AC-R = 0, Z = 1 ;else, Z = 0;	AC = AC-R;
	JPNZ mainloop1	;if Z =0, JUMP to loop1	
MOVR1AC			    ;AC<=R1	
LDIAC i
SHIFT
MOVAC
LDIAC j
ADD
STAC M[i,j]			;M[i,j]<=AC	
LDIAC three_n		;AC<= three_n	
STAC k			        ;k<=AC	;k=three_n
mainloop2:	LDIAC j		;AC<=j	Ac = j = two_n
	INAC		;AC<=AC+1	
	STAC j		;j<=AC	
	MOVAC		;R<=AC	
	LDIAC three_n		;AC<=three_n	
	SUB		    ;AC<=AC-R; if AC-R = 0, Z = 1 ;else, Z = 0;	AC = AC-R;	
	JPNZ mainloop1		;if Z =0, JUMP to loop1	
LDIAC two_n			;AC<=two_n	
STAC j			;j<=AC	;j=two_n
mainloop3:	LDAC i		;AC<=i	
	INAC		;AC<=AC+1	
	STAC i		;i<=AC	
	MOVAC		;R<=AC	
	LDIAC n		;AC<=n	
	SUB		    ;AC<=AC-R; if AC-R = 0, Z = 1 ;else, Z = 0;	AC = AC-R;
	JPNZ mainloop2		;if Z =0, JUMP to loop2	
ENDOP				
