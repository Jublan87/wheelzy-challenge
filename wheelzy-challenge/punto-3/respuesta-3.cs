using Microsoft.EntityFrameworkCore;

namespace wheelzy_challenge.punto_3
{
    internal class respuesta_3
    {
        private readonly ApplicationDbContext dbContext;

        public respuesta_3(ApplicationDbContext context)
        {
            dbContext = context;
        }

        // METODO ORIGINAL
        //public void UpdateCustomersBalanceByInvoices(List<Invoice> invoices)
        //{
        //    foreach (var invoice in invoices)
        //    {
        //        var customer = dbContext.Customers.SingleOrDefault(invoice.CustomerId.Value);
        //        customer.Balance -= invoice.Total;
        //        dbContext.SaveChanges();
        //    }
        //}

        /*  Esta funcion tiene varios problemas:
         *  1- Metodo SingleOrDefault incorrecto:
         *     No es el metodo adecuado para buscar por llave primaria, se deberia usar Find o FirstOrDefault con una expresion lambda como condicion.
         *  2- Problema de N+1:
         *     Se esta haciendo una consulta a la base de datos por cada factura, lo es muy ineficiente.
         *     Se deberia cargar todos los clientes necesarios en una sola consulta antes del bucle.
         *  3- Guardar cambios dentro del bucle:
         *     Se usa el SaveChanges dentro del bucle, lo que genera multiples transacciones a la base de datos.
         *     Se deberia llamar a SaveChanges una sola vez despues de actualizar todos los clientes.
         */

        // METODO OPTIMIZADO
        public void UpdateCustomersBalanceByInvoicesOptimized(List<Invoice> invoices)
        {
            var customerIds = invoices
                .Select(i => i.CustomerId)
                .Distinct()
                .ToList();

            var customers = dbContext.Customers
                .Where(c => customerIds.Contains(c.Id))
                .ToList();

            foreach (var invoice in invoices)
            {
                var customer = customers.SingleOrDefault(c => c.Id == invoice.CustomerId);
                if (customer != null)
                {
                    customer.Balance -= invoice.Total;
                }
            }

            // Guardo una sola vez
            dbContext.SaveChanges();
        }

        /*  Mejoras realizadas:
         *  1- Enlisto todos los IDs de clientes de las facturas.
         *  2- Cargo todos los clientes necesarios en una sola consulta usando Where y Contains.
         *  3- Recorro las facturas y actualizo los balances de los clientes ya cargados en memoria.
         *  4- Llamada a SaveChanges una sola vez despues de actualizar todos los balances.
         */
    }
}
