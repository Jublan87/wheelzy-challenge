using Microsoft.EntityFrameworkCore;

namespace wheelzy_challenge.punto_4
{
    internal class respuesta_4
    {
        private readonly ApplicationDbContext _context;

        public respuesta_4(ApplicationDbContext context)
        {
            _context = context;
        }

        public async Task<List<OrderDTO>> GetOrders(DateTime? dateFrom, DateTime? dateTo, List<int> customerIds, List<int> statusIds, bool? isActive)
        {
            var query = _context.Orders.AsQueryable();

            if (dateFrom.HasValue)
                query = query.Where(o => o.Date >= dateFrom.Value);

            if (dateTo.HasValue)
                query = query.Where(o => o.Date <= dateTo.Value);

            if (customerIds != null && customerIds.Any())
                query = query.Where(o => customerIds.Contains(o.CustomerId));

            if (statusIds != null && statusIds.Any())
                query = query.Where(o => statusIds.Contains(o.StatusId));

            if (isActive.HasValue)
                query = query.Where(o => o.IsActive == isActive.Value);

            return await query
                .Select(o => new OrderDTO
                {
                    Id = o.Id,
                    CustomerId = o.CustomerId,
                    CustomerName = o.Customer.Name,
                    StatusId = o.StatusId,
                    StatusName = o.Status.Name,
                    Date = o.Date,
                    IsActive = o.IsActive
                    // Se agregan todas los parametros necesarios del DTO
                })
                .ToListAsync();
        }

        /* Asumo que _context es una instancia de DbContext y OrderDTO es un DTO previamente definido 
           En el metodo primero creo una instancia de IQueryable para la entidad Orders.
           Luego, aplico los filtros dependiendo si vienen o no los parametros.
           Y por ultimo, proyecto con un select a orderDTO, y lo devuelvo como lista.
         */
    }
}
