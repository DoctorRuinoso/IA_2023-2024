from busquedaAlum import *

operador: int

match operadores[operador]:
    case 1:
        objetivo = busquedaAnchura()
        if objetivo:
            print("Se ha alcanzado una solución.")
        else:
            print("No se ha alcanzado ninguna solución.")
    case 2:
        objetivo = busquedaProfundidad()
        if objetivo:
            print("Se ha alcanzado una solución.")
        else:
            print("No se ha alcanzado ninguna solución.")
    case 3:
        objetivo = busquedaAnchuraEstadosRepetidos()
        if objetivo:
            print("Se ha alcanzado una solución.")
        else:
            print("No se ha alcanzado ninguna solución.")
    case 4:
        objetivo = busquedaProfundidadEstadosRepetidos()
        if objetivo:
            print("Se ha alcanzado una solución.")
        else:
            print("No se ha alcanzado ninguna solución.")
    case 5:
        objetivo = busquedaHeuristica()
        if objetivo:
            print("Se ha alcanzado una solución.")
        else:
            print("No se ha alcanzado ninguna solución.")
    case other:
        print("Operador incorrecto.")
