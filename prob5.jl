t = 1 
U = 2 
mix_ratio = 0.2 
delta_old = 0.1 

H_up = [
        0.0　0.0
        0.0　0.0
        ]

H_dn = [
        0.0　0.0
        0.0　0.0
        ]

for i = 1:10000
    H_up[1,1] = 0.5*(1-delta_old)*U
    H_up[2,2] = 0.5*(1+delta_old)*U
    H_up[1,2] = -t
    H_up[2,1] = -t

    H_dn[1,1] = 0.5*(1+delta_old)*U
    H_dn[2,2] = 0.5*(1-delta_old)*U
    H_dn[1,2] = -t
    H_dn[2,1] = -t

end 