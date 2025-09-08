using Microsoft.EntityFrameworkCore;

namespace wheelzy_challenge.punto_1
{
    public class CarInfoQuery
    {
        private readonly ApplicationDbContext _context;

        public CarInfoQuery(ApplicationDbContext context)
        {
            _context = context;
        }

        // Consulta con Entity Framework para obtener la misma informaci�n que la query SQL
        // En esta oportunidad, interpreto segun el enunciado del challenge que debo asumir que todas las entidades y DbContext est�n configurados correctamente
        public async Task<List<object>> GetCarInfoAsync()
        {
            var carInfoQuery = _context.Cases
                .Select(caseEntity => new
                {
                    // Informaci�n del auto
                    CarYear = caseEntity.Car.Year,
                    Make = caseEntity.Car.Submodel.Model.Make.Name,
                    Model = caseEntity.Car.Submodel.Model.Name,
                    Submodel = caseEntity.Car.Submodel.Name,
                    ZipCode = caseEntity.Car.ZipCode.Code,

                    // Informaci�n del comprador actual y cotizaci�n
                    CurrentBuyerName = caseEntity.Quotes
                        .Where(quote => quote.IsCurrent)
                        .Select(quote => quote.BuyerZipCode.Buyer.Name)
                        .FirstOrDefault(),
                    CurrentQuoteAmount = caseEntity.Quotes
                        .Where(quote => quote.IsCurrent)
                        .Select(quote => quote.BuyerZipCode.QuoteAmount)
                        .FirstOrDefault(),

                    // Estado actual del caso (�ltimo hist�rico) - Optimizado
                    CurrentStatus = caseEntity.CaseStatusHistories
                        .OrderByDescending(history => history.StatusDate ?? history.CreatedDate)
                        .ThenByDescending(history => history.CreatedDate)
                        .Select(history => new
                        {
                            StatusName = history.Status.Name,
                            StatusDate = history.StatusDate
                        })
                        .FirstOrDefault()
                })
                .OrderBy(carInfo => carInfo.CarYear);

            var results = await carInfoQuery.ToListAsync();
            return results.Cast<object>().ToList();
        }
    }
}
