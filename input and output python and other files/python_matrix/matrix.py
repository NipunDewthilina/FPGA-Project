R = int(input("Enter n"))

#Matrix 1 input
matrix_1 = []
print("Enter the entries row wise of matrix 1:")

for i in range(R):          # A for loop for row entries
    a =[]
    for j in range(R):      # A for loop for column entries
         a.append(int(input()))
    matrix_1.append(a)

#Matrix 2 input
matrix_2 = []
print("Enter the entries row wise of matrix 2:")

for i in range(R):          # A for loop for row entries
    a =[]
    for j in range(R):      # A for loop for column entries
         a.append(int(input()))
    matrix_2.append(a)

f = open("myfile.txt", "a")
length = len(matrix_1[0])

# for i in range(0,4096): #ik
#     for j in range(0,4096):
#         if i<length:
#             if j>=length:
#                 f.write("000000000000")
#             else:
#                 f.write(str(matrix_1[i][j]))
#         else:
#             f.write("0")

# for i in range(0,4096): #kj
#     for j in range(0,4096):
#         if i < length:
#             if j>=length:
#                 f.write("0")
#             else:
#                 f.write(str(matrix_2[i][j]))
#         else:
#             f.write("0")


