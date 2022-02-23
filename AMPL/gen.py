def generate(n, v, MaxN=2,reqV=2,sett=4):
    vec = ["A","P","R","V","N"]
    if n == 0:
        return v
    else:
        if len(v) == 0:
            return generate(n-1, vec)
        else:
            return generate(n-1, [i + "A" for i in v] + [i + "P" for i in v]+ [i + "R" for i in v] + [i + "N" for i in v]+ [i + "V" for i in v])


def clean(n, v, MaxN=2,reqV=2):
    w = []
    for sh in v:
        
        if sh.count('V') == reqV and sh.count('R') <= MaxN:
            NightOk = True
            for i in range(n):
                if sh[i] == 'N' and sh[(i+1)%n] != 'R' or sh[i] == 'R' and sh[(i-1)%n] != 'N':
                    NightOk = False
            if (NightOk): w.append(sh)
    return w

def pretty(w):
    v = []
    names = []
    tmp=[]
    for s in w:
        tmp =   s.replace('A',"1 1 0 0 ")
        tmp = tmp.replace('P',"0 1 1 0 ")
        tmp = tmp.replace('N',"0 0 0 1 ")
        tmp = tmp.replace('V',"0 0 0 0 ")
        tmp = tmp.replace('R',"0 0 0 0 ")
        v.append(s+" "+tmp)
        names.append(s)
    return names,v

v = []
nam = []
v = generate(7,[])
w = clean(7,v)
nam,ww = pretty(w)

set = ["Mo","Tu","We","Th","Fr","Sa","Su"]
print("set REQUETS := ")

REQ = []

for i in range(7):
    for j in set:
        REQ.append(j+str(i)+" ")
print(REQ)
print(";")

print("set SHIFTS :=")
for i in nam:
    nn = i.count('N')
    if nn==0: nn = 1
    elif nn==1: nn = 2
    elif nn==2: nn = 4;
    print(i," ",str(nn))

print(";")
print("param A :")
print(REQ)
print(":=")
for i in ww:
    print(i)
