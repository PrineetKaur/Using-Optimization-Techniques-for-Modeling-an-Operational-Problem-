reset;

set N;
set E within {N,N};
set Inc_in {i in N} within N:= {v in N: (i,v) in E};
set Inc_out {i in N} within N:= {v in N: (v,i) in E};

param b {N};
param d {E};
param DEM_bound = 1;


var a {E} >=0;
var x {E} >=0;
var B1 binary;
var B2 binary;


minimize TravelTime: sum{(i,j) in E} d[i,j] * x[i,j];

subject to Balance {i in N}:
sum{j in Inc_in[i]}  x[i,j] - sum{j in Inc_out[i]}  x[j,i]  = b[i];


subject to Supply {i in N}:
sum{j in Inc_in[i]} x[i,j] <= sum{j in Inc_in[i]} a[i,j];

subject to Bridge1_in:
x[1,2] <= B1 * DEM_bound;

subject to Bridge1_out:
x[2,1] <= B1 * DEM_bound;

subject to Bridge2_in:
x[1,3] <= B2* DEM_bound;

subject to Bridge2_out:
x[3,1] <= B2 * DEM_bound;

subject to Selection:
B1 + B2 = 1;
