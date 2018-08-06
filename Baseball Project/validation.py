import math

def salary(type, n, s0, s):
    if type == 'f':
        return (s0*1.81)
    elif type == 'c':
        return (s0*1.66)
    else:
        if n == 3:
            return (4.5*s)
        elif n >=6:
            return (1.66*s)
        else:
            return (1.33*s)


def WARCalc(age, wExpected,WAR, positon):
    if age > 26 and positon == 'p':
        WAR += .5*(age - 26)*-0.187
        return WAR
    elif age > 28 and positon == 'h':
        WAR += .2222222*(age - 28)*-0.576
        return WAR
    elif age <= 26 and positon == 'p':
        WAR += ((wExpected - WAR) / abs(wExpected - WAR)) * 0.695
        return WAR
    else:
        WAR += ((wExpected - WAR) / abs(wExpected - WAR)) * 0.651
        return WAR


def injuryPotential(WAR, position):
    if position == 'p':
        p = (WAR*0.00416*0.41)
        return p
    else:
        p = (WAR*0.00210*0.23)
        return p


def main():
    print("O'Day - salary, hitter")
    type = 'f'
    position = 'p'
    age = 29
    s0 = 1350000
    s = s0
    wExpected = 2.6
    contract = 3
    n = 1
    WAR = 2.6
    while n <= contract:
        age += 1
        WAR = WARCalc(age, wExpected, WAR, position)
        s = salary(type, n, s0, s)
        print('value at year',n)
        p = injuryPotential(WAR, position)
        v = (WAR - p) / math.log10(s / 40000)
        age += 1
        n += 1
        print(v)



main()




