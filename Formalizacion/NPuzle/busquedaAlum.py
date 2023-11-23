from __future__ import annotations
from NPuzle_Alum import *


@dataclass
class Nodo:
    estado: tEstado
    operador: str
    costeCamino: int
    profundidad: int
    valHeuristica: int  # Por el momento se le puede asignar el valor 0.
    padre: Nodo
    modo: str = "Voraz"

    def __str__(self) -> str:
        return f'{"- " * 10}\n{self.estado.tablero}, Operador: {operadores[self.operador]}, Heu:{self.valHeuristica}\n{"- " * 10}'

    def hash(self) -> str:
        return self.estado.crearHash()


def nodoInicial() -> Nodo:
    return Nodo(estadoInicial(), "0", 0, 0, 0, None)


def dispCamino(nodo):
    lista = []
    aux = nodo
    while aux.padre != None:
        lista.append((aux.estado.tablero, aux.operador))
        aux = aux.padre
    for i in lista[::-1]:
        print("Movimiento hacia: ", operadores[i[1]], "\n", i[0])
        print()


def dispSolucion(nodo):
    dispCamino(nodo)
    print("Profundidad: ", nodo.profundidad)
    print("Coste: ", nodo.costeCamino)


def expandir(nodo) -> list:
    nodos = []

    for op in operadores:
        if esValido(op, nodo.estado):
            nuevo = aplicaOperador(op, nodo.estado)
            nodos.append(
                Nodo(
                    nuevo,
                    op,
                    nodo.costeCamino + coste(op, nuevo),
                    nodo.profundidad + 1,
                    0,
                    nodo,
                ))

    return nodos


def busquedaAnchura() -> bool:
    objetivo = False
    raiz = nodoInicial()
    actual = []
    abiertos = []
    sucesores = []
    cerrados = {}  # Cerrados es un diccionario para que funcione como una tabla hash
    abiertos.append(raiz)

    while not objetivo and len(abiertos) > 0:
        actual = abiertos[0]
        abiertos.pop(0)
        objetivo = testObjetivo(actual.estado)
        if not objetivo:
            sucesores = expandir(actual)
            abiertos = abiertos + sucesores
        cerrados[actual.hash()] = 0

    if objetivo:
        dispSolucion(actual)  # Completar
    elif not objetivo:
        print("No se ha encontrado solución")

    return objetivo

def busquedaProfundidad() -> bool:
    objetivo = False
    raiz = nodoInicial()
    actual = []
    abiertos = []
    sucesores = []
    cerrados = {}
    abiertos.append(raiz)

    while not objetivo and len(abiertos) > 0:
        actual = abiertos[0]
        abiertos.pop(0)
        objetivo = testObjetivo(actual.estado)

        if not objetivo:
            sucesores = expandir(actual)
            abiertos = sucesores + abiertos
        cerrados[actual.hash()] = 0

    if objetivo:
        dispSolucion(actual)  # Completar
    elif not objetivo:
        print("No se ha encontrado solución")

    return objetivo

def estado_repetido(cerrados, nodo) -> bool:
    res: bool = 0
    actual = cerrados

    while len(actual) > 0 and not res:
        if actual == nodo:
            res = 1
        elif actual != nodo:
            actual
    return res

def busquedaAnchuraEstadosRepetidos() -> bool:
    objetivo = False
    raiz = nodoInicial()
    abiertos = []
    sucesores = []
    actual = []
    cerrados = {}
    abiertos.append(raiz)

    while not objetivo and len(abiertos) > 0:
        actual = abiertos[0]
        abiertos.pop(0)

        objetivo = testObjetivo(actual)
        if not objetivo and actual not in cerrados:
            if not estado_repetido:
                sucesores = expandir(actual)
                abiertos = abiertos + sucesores
        cerrados[actual.hash()] = 0

    if objetivo:
        dispSolucion(actual)  # Completar
    elif not objetivo:
        print("No se ha encontrado solución")

    return objetivo

def busquedaProfundidadEstadosRepetidos() -> bool:
    objetivo = False
    raiz = nodoInicial()
    abiertos = []
    sucesores = []
    actual = []
    cerrados = {}
    abiertos.append(raiz)

    while not objetivo and len(abiertos) > 0:
        actual = abiertos[0]
        abiertos.pop(0)

        objetivo = testObjetivo(actual)
        if not objetivo and actual not in cerrados:
            if not estado_repetido:
                sucesores = expandir(actual)
                abiertos = sucesores + abiertos
        cerrados[actual.hash()] = 0

    if objetivo:
        dispSolucion(actual)  # Completar
    elif not objetivo:
        print("No se ha encontrado solución")

    return objetivo

def busquedaHeuristica() -> bool:
    objetivo = False
    raiz = nodoInicial()
    abiertos = []
    sucesores = []
    actual = []
    cerrados = {}
    abiertos.append(raiz)

    while not objetivo and len(abiertos) > 0:
        actual = abiertos[0]
        abiertos.pop(0)
        objetivo = testObjetivo(actual)

        if Nodo.modo == "Voraz":
            return Nodo.valHeuristica < 8
        else:
            return Nodo.valHeuristica + Nodo.costeCamino < 8
        
    if objetivo:
        dispSolucion(actual)  # Completar
    elif not objetivo:
        print("No se ha encontrado solución")

    return objetivo