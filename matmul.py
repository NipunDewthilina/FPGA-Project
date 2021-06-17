import numpy as np

a = np.random.randn(4, 4)
b = np.random.randn(4, 4)

res_np = np.matmul(a, b)

res = np.zeros((4, 4))

#naive
# for i in range(4):
#     for j in range(4):
#         for k in range(4):
#             res[i, j] += a[i, k] * b[k, j]

#optimal
bT = b.T
for i in range(4):
    for j in range(4): #res[3,2] = a[3,0] * b[2,0] + a[3,1] * b[2,1] + .....
        for k in range(4):
            res[i, j] += a[i, k] * bT[j, k]


print(np.linalg.norm(res_np - res))
print(res_np, res)
