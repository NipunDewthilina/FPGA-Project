# -*- coding: utf-8 -*-
"""
Created on Sun Jun 13 20:39:50 2021

@author: Nipun D
"""
import numpy as np

#Matrix 1 input
R = int(input("Enter the number of rows in square matrix:"))
  
# Initialize matrix
matrix_1 = []
print("Enter the entries rowwise of matrix 1:")

for i in range(R):          # A for loop for row entries
    a =[]
    for j in range(R):      # A for loop for column entries
         a.append(int(input()))
    matrix_1.append(a)

#Matrix 2 input
matrix_2 = []
print("Enter the entries rowwise of matrix 2:")

for i in range(R):          # A for loop for row entries
    a =[]
    for j in range(R):      # A for loop for column entries
         a.append(int(input()))
    matrix_2.append(a)
   
resultant = []

for i in range(R):
    row = []
    for j in range(R):
        row.append(0)
 
    resultant.append(row)
 
# print("Matrix Multiplication method 1: ")
 
# # perform matrix multiplication
# # using nested for loops
# for i in range(R):
#     for j in range(R):
#         for k in range(R) :
#             resultant[i][j] += matrix_1[i][k] * matrix_2[k][j] 
            
# print(resultant)

print("Matrix Multiplication method 2: ")

#Get the transpose of matrix 1

numpy_array = np.array(matrix_1)
transpose = numpy_array.T
matrix_1_t = transpose.tolist()

print("Matrix Transpose of matrix 1: ")
print(matrix_1_t)

for i in range(R):
    for j in range(R):
        matrix_1[i][j] = matrix_1_t[i][i]*matrix_2[i][j]
        print (matrix_1[i][j])



