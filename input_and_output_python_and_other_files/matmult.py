# -*- coding: utf-8 -*-
"""
Created on Sun Jun 13 20:39:50 2021

@author: Nipun D
"""
# import numpy as np

# #Matrix 1 input
# R = int(input("Enter the number of rows in square matrix:"))
  
# # Initialize matrix
# matrix_1 = []
# print("Enter the entries rowwise of matrix 1:")

# for i in range(R):          # A for loop for row entries
#     a =[]
#     for j in range(R):      # A for loop for column entries
#          a.append(int(input()))
#     matrix_1.append(a)

# #Matrix 2 input
# matrix_2 = []
# print("Enter the entries rowwise of matrix 2:")

# for i in range(R):          # A for loop for row entries
#     a =[]
#     for j in range(R):      # A for loop for column entries
#          a.append(int(input()))
#     matrix_2.append(a)
   
# resultant = []

# for i in range(R):
#     row = []
#     for j in range(R):
#         row.append(0)
 
#     resultant.append(row)

import numpy as np

matrix_1 = np.random.randint(low =0,high = 10,size =( 4, 4))
matrix_2 = np.random.randint(low =0,high = 10,size =( 4, 4))

res_np = np.matmul(matrix_1, matrix_2)
R = 4
resultant = np.zeros((4, 4))
print ("Correct result:  ")
print(res_np)
print("Matrix Multiplication method 1: ")
 
# perform matrix multiplication
# using nested for loops
for i in range(int(R/2)):# 00
    for j in range(int(R/2)):
        for k in range(int(R)) :
            resultant[i][j] += matrix_1[i][k] * matrix_2[k][j] 
            
print(resultant)

for i in range(int(R/2),R):# 11
    for j in range(int(R/2),R):
        for k in range(R) :
            resultant[i][j] += matrix_1[i][k] * matrix_2[k][j]  
            

print(resultant)

for i in range(int(R/2),R):# 10
    for j in range(int(R/2)):
        for k in range(int(R)) :
            resultant[i][j] += matrix_1[i][k] * matrix_2[k][j] 

print(resultant)

for i in range(int(R/2)):# 01
    for j in range(int(R/2),R):
        for k in range(int(R)) :
            resultant[i][j] += matrix_1[i][k] * matrix_2[k][j] 

print(resultant)