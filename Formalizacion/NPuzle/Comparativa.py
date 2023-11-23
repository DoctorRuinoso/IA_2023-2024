import pandas as pd
import matplotlib.pyplot as plt
import matplotlib

# Tras implementar los cuatro métodos de búsqueda propuestos (Anchura, Profundidad, Voraz y A*) con el control de los estados repetidos puede llevar a cabo la comparativa de los mismos. Para ello, sustituya los asteriscos de las respectivas importación de librerías, sustituyendo cada uno el nombre que tiene su función en cada caso. Tras ello, puede realizar las tablas directamente y tratar con ellas.
from busquedaAlum import * as BusquedaAnchura 
from busquedaAlum import * as BusquedaProfundidad
from busquedaAlum import * as BusquedaHeuristica

tabla = []
''' 
El primer parámetro que se devuelve se omite porque no nos interesa saber si ha acabado o no en este caso. 
    * generados es el nº de nodos que han sido generados, en total, mediante la función de expandir. Tenga en cuenta que te no importa que hayan sido visitados o no.
    * visitados contabiliza el nº de nodos que han sido visitados. Piense si añadimos al cálculo o no los estados repetidos. 
    * coste en el que se encuentra la solución
    * maxlon hace referencia a la máxima longitud que llega a tener la lista de abiertos
coste 
''' 
_, generados, visitados, coste, maxlon = BusquedaHeuristica(...)
# Se añaden a la lista los resultados obtenidos.
tabla.append([coste, generados, visitados, maxlon, "Busqueda Voraz", "Mal Colocadas"])

_, generados, visitados, coste, maxlon = BusquedaHeuristica(...)
tabla.append([coste, generados, visitados, maxlon, "Busqueda A*", "Mal Colocadas"])


_, generados, visitados, coste, maxlon = BusquedaHeuristica(...)
tabla.append([coste, generados, visitados, maxlon, "Busqueda Voraz", "Manhattan"])

_, generados, visitados, coste, maxlon = BusquedaHeuristica(...)
tabla.append([coste, generados, visitados, maxlon, "Busqueda A*", "Manhattan"])

# Se genera el DataFrame (tabla) con los datos obtenidos
tabla = pd.DataFrame(
    tabla, columns=["Coste", "Generados", "Visitados",  "Maxima Longitud", "Método", "Heurística"], 
).set_index("Método") # Se establece que el índice de la tabla es el método

print(tabla)

# Guardamos los datos en un fichero de texto
tabla.to_csv("Tabla_Practica_7_IA.csv")

# Realizamos un diagrama de barras horizontales a partir de la tabla anterior
ax = tabla.plot(kind="barh", figsize=(10,7))
ax.set_yticklabels(['Búsqueda Voraz - Mal Colocadas', 'Búsqueda A* - Mal Colocadas', 'Búsqueda Voraz - Manhattan', 'Búsqueda A* - Manhattan'])
plt.grid()
ax.get_figure().savefig("Grafica_Practica_7.pdf", bbox_inches="tight", dpi=300)
