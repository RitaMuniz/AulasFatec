"""
List1_RitaLima.ipynb
Lista de Exercícios - Sistemas Lineares
"""

import numpy as np

#
# Exercicio 1
# Um determinado produtor rural possui duas fazendas, Morro Branco e Riacho Seco, onde deseja plantar soja e trigo. 
# Devido as condições de solo, o lucro anual esperado para a soja é de 40/ha na MorroBranco e de 60/ha na Riacho Seco; 
# e o lucro anual previsto para o trigo é de 80/ha na MorroBranco e de 40/ha na Riacho Seco. 
# Sabe-se ainda que a área de soja a ser plantada na Morro Branco deve ter a mesma dimensão da área plantada de soja na Riacho Seco; 
# a área de trigo plantada na Riacho Seco deve ter a mesma dimensão da área plantada de trigo na Morro Branco. 
# O lucro anual do Morro Branco e da Riacho Seco deve ser 16.000,00 e 12.000,00 respectivamente. 
# Pergunta-se: sabendo-se que as fazendas têm área suficiente para atender os anseios do produtor como deve ser organizada está produção em termos de distribuição de área plantada?
#

#Array com variaveis e restrições

A = np.array([
    [1, -1, 0, 0],
    [0, 0, 1, -1],
    [40, 0, 80, 0],
    [0, 60, 0, 40]
])

b = np.array([0, 0, 16000, 12000])

x = np.linalg.solve(A, b)


print("soja Morro Branco:", np.around(x[0]))
print("soja Riacho Seco:", np.around(x[1]))
print("trigo Morro Branco:", np.around(x[2]))
print("trigo Riacho Seco:", np.around(x[3]))

"""
Resultado:

soja Morro Branco: 100.0
soja Riacho Seco: 100.0
trigo Morro Branco: 150.0
trigo Riacho Seco: 150.0
"""

#
# Exercicio 2
# Um caminhão pode transportar maçãs, peras e laranjas, num total de 10.000 frutas.
# As frutas estão colocadas em caixas (cada caixa só contém um tipo de fruta),
# sendo que cada caixa de maçãs, peras ou laranjas tem, respectivamente, 50 maçãs, 60 peras e 100 laranjas 
# e custam, respectivamente, 20 reais, 40 reais e 10 reais. 
# Se a carga do caminhão pode ter 140 caixas e custa R$3.300,00, calcule quantas maçãs, peras e laranjas podem ser transportadas.
#

A = np.array([
    [1, 1, 1],
    [50, 60, 100],
    [20, 40, 10]
])

b = np.array([140, 10000, 3300])

x = np.linalg.solve(A, b)

print(x)

"""
Resultado:

[40. 50. 50.]
"""

#
# Exercicio 3
# O departamento financeiro de determinada empresa agrícola, decidiu investir parte dos lucros da empresa, 25.000, dólares em aplicações do mercado. 
# A carteira de investimentos é conservadora, diversificada e composta de três tipos de investimentos: poupança, títulos públicos e fundos mútuos. 
# Após um ano estes investimentos renderam um total de 1.620 dólares de juros. 
# A poupança pagou 6% ao ano, os títulos públicos pagaram 7% ao ano e os fundos mútuos pagaram 8% ao ano. 
# Sabendo-se que o departamento financeiro investiu 6.000 dólares a mais em títulos públicos do que em fundos mútuos, determine o quanto foi investido em cada aplicação.
#

A = np.array([
    [1, 1, 1],
    [0.06, 0.07, 0.08],
    [0, 1, -1]
])

b = np.array([25000, 1620, 6000])

x = np.linalg.solve(A, b)

print(x)

"""
Resultado:
[15000.  8000.  2000.]
"""

#
# Exercicio 4
# Uma indústria química atendendo a demanda de empresas do agronegócio, precisa preparar galões de 60 litros de uma mistura que contém 40% de um determinado defensivo agrícola.
# Para preparar os galões este defensivo será usado em três soluções: a primeira tem 15% de defensivo agrícola; a segunda tem 35% e a terceira 55%.
# Com estas quantidades de soluções (3 soluções) e suas respectivas concentrações de defensivos, a mistura precisa ser feita de tal forma que a solução de 35% seja o dobro da solução de 55%. 
# Quantos litros de cada solução deverão utilizados para obter o resultado desejado?
# 

A = np.array([
    [1, 1, 1],
    [0.15, 0.35, 0.55],
    [0, 1, -2]
])

b = np.array([60, 24, 0])

x = np.linalg.solve(A, b)

print(np.around(x,2))

"""
Resultado: 
[ 3.75 37.5  18.75]
"""

#
# Exercicio 5
# Deseja-se preparar galões de 10 litros de um determinado fertilizante líquido a ser aplicada em pequena plantação.
# Estes galões devem ter, cada um, 2% de uma determinada substância química. 
# Por questões de otimização de estoque os galões precisam ser preparados a partir de três soluções com as seguintes características:
# A) solução sem a substância química desejada
# B) solução com 5% da substância química desejada e
# C) solução com 6% da substância química desejada.
# Na composição de cada galão de 10 litros necessita-se utilizar quatro vezes mais solução A do que a solução B. 
# Qual será a quantidade necessária, de cada solução, para compor cada galão de 10 litros?
#

A = np.array([
    [1, 1, 1],
    [0, 0.05, 0.06],
    [1, -4, 0]
])

b = np.array([10, 0.2, 0])

x = np.linalg.solve(A, b)

print(np.around(x,2))

"""
Resultado: 
[6.4 1.6 2. ]
"""