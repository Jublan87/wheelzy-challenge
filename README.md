# Wheelzy Challenge

Este repositorio contiene la solucion al desafio tecnico de Wheelzy, organizado por puntos independientes con su contexto especifico.

## Estructura del Proyecto

El proyecto esta dividido en carpetas separadas para cada punto del challenge, manteniendo contextos independientes:

```
wheelzy-challenge/
├── punto-1/           # Entity Framework Query
├── punto-2/           # Uso de cache con datos frecuentes
├── punto-3/           # Base de datos y consultas
├── punto-4/           # DTOs y mapeo de datos
├── punto-5/           # Procesamiento de archivos C#
└── Program.cs         # Punto de entrada principal
```

## Tecnologias Utilizadas

- **.NET 9** - Framework principal
- **Entity Framework Core** - ORM para acceso a datos
- **C#** - Lenguaje de programacion

## Como Ejecutar

1. Clona el repositorio:
   ```bash
   git clone https://github.com/Jublan87/wheelzy-challenge.git
   cd wheelzy-challenge
   ```

2. Restaura las dependencias:
   ```bash
   dotnet restore
   ```

3. Compila el proyecto:
   ```bash
   dotnet build
   ```

4. Ejecuta el proyecto:
   ```bash
   dotnet run
   ```

## Notas de Desarrollo

- Cada carpeta `contexto/` contiene los modelos especificos para ese punto
- Los archivos de respuesta (`respuesta-X.cs`) contienen la implementacion principal

---