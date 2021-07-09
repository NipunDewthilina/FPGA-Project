# #Matrix 1 input
# N = int(input("Enter the number of rows in square matrix:"))
  
# # Initialize matrix
# a = []
# print("Enter the entries rowwise of matrix 1:")

# for i in range(N):          # A for loop for row entries
#     row1 = input().split(" ")
#     row1 = list(map(int,row1))
#     a.append(row1)

# #Matrix 2 input
# b = []
# print("Enter the entries rowwise of matrix 2:")

# for i in range(N):          # B for loop for row entries
#     row2 = input().split(" ")
#     row2 = list(map(int,row2))
#     b.append(row1)

import numpy as np

N1 = int(input("Enter Number of Rows of Mat1: "))
N2 = int(input("Enter Number of Columns of Mat1: "))
N3 = int(input("Enter Number of Columns of Mat2: "))

a = np.random.randint(low = 0,high = 20,size = (N1, N2))
b = np.random.randint(low = 0,high = 20,size = (N2, N3))

res_np = np.matmul(a, b)

res = np.zeros((N1, N3))
# a = [[1, 2, 1, 2], [1, 2, 1, 2], [1, 2, 1, 2], [3, 2, 1, 0]]
# b = [[1, 2, 1, 2], [1, 2, 1, 2], [1, 2, 1, 2], [3, 2, 1, 0]]

mem1 = [0] * 4096
mem2 = [0] * 4096
mem3 = [0] * 4096
mem4 = [0] * 4096
if (max(N1,N2,N3)==N1):
    if (N1%2 == 0):
        N = N1
    else:
        N = N1+1
if (max(N1,N2,N3) == N2):
    if (N2%2 == 0):
        N = N2
    else:
        N = N2+1
if (max(N1,N2,N3) == N3):
    if (N3%2 == 0):
        N = N3
    else:
        N = N3+1

print(N)
    
ii = 0
jj = N
kk = 2 * N

n_start_bit = 4091
mem1[n_start_bit] = N
mem2[n_start_bit] = N
mem3[n_start_bit] = N
mem4[n_start_bit] = N

for i in range(ii, jj):
    for k in range(kk, 3 * N):

        loc1 = bin(i)[2:]
        sixloc1 = (6 - len(loc1)) * '0' + loc1

        loc2 = bin(k)[2:]
        sixloc2 = (6 - len(loc2)) * '0' + loc2

        twelveloc = sixloc1 + sixloc2

        decimal_loc = int(twelveloc, 2)

        # print(decimal_loc, a[i][k % N])
        try:
            mem1[decimal_loc] = a[i][k % N]
            mem2[decimal_loc] = a[i][k % N]
            mem3[decimal_loc] = a[i][k % N]
            mem4[decimal_loc] = a[i][k % N]
        except IndexError:
            mem1[decimal_loc] = 0
            mem2[decimal_loc] = 0
            mem3[decimal_loc] = 0
            mem4[decimal_loc] = 0

#ik
for k in range(kk, 3 * N):
    for j in range(jj, kk):

        loc1 = bin(k)[2:]
        sixloc1 = (6 - len(loc1)) * '0' + loc1

        loc2 = bin(j)[2:]
        sixloc2 = (6 - len(loc2)) * '0' + loc2

        twelveloc = sixloc1 + sixloc2

        decimal_loc = int(twelveloc, 2)

        # print(decimal_loc, b[k % N][j % N])
        try:
            mem1[decimal_loc] = b[k % N][j % N]
            mem2[decimal_loc] = b[k % N][j % N]
            mem3[decimal_loc] = b[k % N][j % N]
            mem4[decimal_loc] = b[k % N][j % N]
        except IndexError:
            mem1[decimal_loc] = 0
            mem2[decimal_loc] = 0
            mem3[decimal_loc] = 0
            mem4[decimal_loc] = 0

with open('mat_core1.txt', 'w') as file:
    for i in mem1:
        i_s = str(bin(int(i)))[2:]
        zeros = "0" * (12-len(str(i_s)))
        file.write(zeros+str(i_s)+'\n')
        # print(i)
        # print(str(i)+'\n')

with open('mat_core2.txt', 'w') as file:
    for i in mem2:
        i_s = str(bin(int(i)))[2:]
        zeros = "0" * (12-len(str(i_s)))
        file.write(zeros+str(i_s)+'\n')
        # print(i)
        # print(str(i)+'\n')

with open('mat_core3.txt', 'w') as file:
    for i in mem3:
        i_s = str(bin(int(i)))[2:]
        zeros = "0" * (12-len(str(i_s)))
        file.write(zeros+str(i_s)+'\n')
        # print(i)
        # print(str(i)+'\n')

with open('mat_core4.txt', 'w') as file:
    for i in mem4:
        i_s = str(bin(int(i)))[2:]
        zeros = "0" * (12-len(str(i_s)))
        file.write(zeros+str(i_s)+'\n')
        # print(i)
        # print(str(i)+'\n')

#result indices finding
addr_mem = [0]*512
addr_i = 0;
for i in range(ii, jj):
    for j in range(jj, 2 * N):

        loc1 = bin(i)[2:]
        sixloc1 = (6 - len(loc1)) * '0' + loc1

        loc2 = bin(j)[2:]
        sixloc2 = (6 - len(loc2)) * '0' + loc2

        twelveloc = sixloc1 + sixloc2

        decimal_loc = int(twelveloc, 2)

        print(decimal_loc)
        addr_mem[addr_i] = decimal_loc
        addr_i += 1
print(addr_mem)

with open('addr_mem.txt', 'w') as file:
    for i in addr_mem:
        i_s = str(bin(int(i)))[2:]
        zeros = "0" * (12-len(str(i_s)))
        file.write(zeros+str(i_s)+'\n')
        # print(i)
        # print(str(i)+'\n')

#matrix multiplication for verification
resultant = []
print("Result Matrix: ")
# for i in range(N):
#     row = []
#     for j in range(N):
#         row.append(0)
#     resultant.append(row)
        
# for i in range(N):
#     for j in range(int(N)):
#         for k in range(int(N)) :
#             resultant[i][j] += a[i][k] * b[k][j] 

print(res_np)