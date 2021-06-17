/**
Inputs : n - Dimension of the Matrix is (nxn),
 M[i,k] - Components of 1st matrix, M[k,j] - components of 2nd matrix
Ouputs : M[i,j] - Components of Result Matrix
**/


START			;PC<=0, AR<=0	
CLAC			;AC<=0, Z<=1	
MOVACR1			;R1<=AC ;	R1 = 0;
STAC i			;i<=AC;	i = 0
LDAC n			;AC<=n;	AC = n
MOVAC			;R<=AC;	R = AC = n
ADD			;AC<=AC+R;	AC = AC*R = n^2
STAC two_n		;two_n<= AC;	two_n = AC
STAC j
LDAC two_n		;AC<= two_n	;AC = two_n
MOVAC			;R <= AC;	R = AC = two_n
LDAC n			;AC <= n;	AC = n
ADD			    ;AC <= AC+R;	AC = AC+R = two_n+n
STAC three_n			;three_n <=AC;	three_n  = AC = two_n + n = nx2 + n
STAC k
LDAC three_n
MOVAC
LDAC n
ADD
STAC four_n
mainloop1:	LDAC M[i,k]		;AC<=M[i,k]	
	MOVAC		;R<=AC	
	LDAC M[k,j]	;AC<=M[k,j]	
	MULT		;AC<=AC*R	
	MOVACR4		;R4<=AC	
	MOVR1AC		;AC<=R1	
	MOVAC		;R<=AC	
	MOVR4AC		;AC<=R4	
	ADD		    ;AC<=AC+R	
	MOVACR1		;R1<=AC	
	LDAC k		;AC<=k	
	INAC		;AC<=AC+1	
	MOVAC		;R<=AC	
	STAC k		;k<=AC	
	LDAC four_n		;AC<=four_n	
	SUB		    ;AC<=AC-R; if AC-R = 0, Z = 1 ;else, Z = 0;	AC = AC-R;
	JPNZ mainloop1	;if Z =0, JUMP to loop1	
MOVR1AC			    ;AC<=R1	
STAC M[i,j]			;M[i,j]<=AC	
LDAC three_n		;AC<= three_n	
STAC k			        ;k<=AC	;k=three_n
mainloop2:	LDAC j		;AC<=j	Ac = j = two_n
	INAC		;AC<=AC+1	
	STAC j		;j<=AC	
	MOVAC		;R<=AC	
	LDAC three_n		;AC<=three_n	
	SUB		    ;AC<=AC-R; if AC-R = 0, Z = 1 ;else, Z = 0;	AC = AC-R;	
	JPNZ mainloop1		;if Z =0, JUMP to loop1	
LDAC two_n			;AC<=two_n	
STAC j			;j<=AC	;j=two_n
mainloop3:	LDAC i		;AC<=i	
	INAC		;AC<=AC+1	
	STAC i		;i<=AC	
	MOVAC		;R<=AC	
	LDAC n		;AC<=n	
	SUB		    ;AC<=AC-R; if AC-R = 0, Z = 1 ;else, Z = 0;	AC = AC-R;
	JPNZ mainloop2		;if Z =0, JUMP to loop2	
ENDOP				