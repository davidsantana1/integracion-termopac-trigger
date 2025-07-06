-- sqlite3 termopac.db

CREATE TABLE Inventario (
    id_articulo INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL,
    existencia INTEGER NOT NULL
);

CREATE TABLE Facturas (
    id_factura INTEGER PRIMARY KEY AUTOINCREMENT,
    id_articulo INTEGER NOT NULL,
    cantidad INTEGER NOT NULL,
    fecha TEXT DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_articulo) REFERENCES Inventario(id_articulo)
);

-- Trigger para actualizar inventario después de insertar una factura
CREATE TRIGGER tr_actualizar_inventario
AFTER INSERT ON Facturas
FOR EACH ROW
BEGIN
    UPDATE Inventario
    SET existencia = existencia - NEW.cantidad
    WHERE id_articulo = NEW.id_articulo;
END;

-- Mocked data
INSERT INTO Inventario (id_articulo, nombre, existencia) VALUES (1, 'Plástico Termo', 100);
INSERT INTO Inventario (id_articulo, nombre, existencia) VALUES (2, 'Cartón Reforzado', 50);

INSERT INTO Facturas (id_articulo, cantidad) VALUES (1, 10);