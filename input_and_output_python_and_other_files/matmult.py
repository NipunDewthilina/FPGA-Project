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
   
 
#     resultant.append(row)

# import numpy as np

R = int(input("Enter the number of rows in square matrix:"))
  
# Initialize matrix
a = []
print("Enter the entries rowwise of matrix 1:")

for i in range(R):          # A for loop for row entries
    row1 = input().split(" ")
    row1 = map(int,row1)
    a.append(row1)

#Matrix 2 input
b = []
print("Enter the entries rowwise of matrix 2:")

for i in range(R):          # B for loop for row entries
    row2 = input().split(" ")
    row2 = map(int,row2)
    a.append(row1)

# matrix_1 = np.random.randint(low =0,high = 10,size =( 4, 4))
# matrix_2 = np.random.randint(low =0,high = 10,size =( 4, 4))
print(a)
print(b)
# res_np = np.matmul(matrix_1, matrix_2)
# R = 4
resultant = [0,0,0,0]*4
# print ("Correct result:  ")
# print(res_np)
# print("Matrix Multiplication method 1: ")
 
# perform matrix multiplication
# using nested for loops
for i in range(int(R/2)):# 00
    for j in range(int(R/2)):
        for k in range(int(R)) :
            resultant[i][j] += a[i][k] * b[k][j] 
            
print(resultant)

for i in range(int(R/2),R):# 11
    for j in range(int(R/2),R):
        for k in range(R) :
            resultant[i][j] += a[i][k] * b[k][j]  
            

print(resultant)

for i in range(int(R/2),R):# 10
    for j in range(int(R/2)):
        for k in range(int(R)) :
            resultant[i][j] += a[i][k] * b[k][j] 

print(resultant)

for i in range(int(R/2)):# 01
    for j in range(int(R/2),R):
        for k in range(int(R)) :
            resultant[i][j] += a[i][k] * b[k][j] 

print(resultant)