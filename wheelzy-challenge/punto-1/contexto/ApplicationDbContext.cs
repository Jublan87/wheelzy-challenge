using Microsoft.EntityFrameworkCore;

namespace wheelzy_challenge.punto_1
{
    public class ApplicationDbContext : DbContext
    {
        public DbSet<Case> Cases { get; set; }
        public DbSet<Car> Cars { get; set; }
        public DbSet<Make> Makes { get; set; }
        public DbSet<Model> Models { get; set; }
        public DbSet<Submodel> Submodels { get; set; }
        public DbSet<ZipCode> ZipCodes { get; set; }
        public DbSet<Quote> Quotes { get; set; }
        public DbSet<BuyerZipCode> BuyerZipCodes { get; set; }
        public DbSet<Buyer> Buyers { get; set; }
        public DbSet<CaseStatusHistory> CaseStatusHistories { get; set; }
        public DbSet<Status> Statuses { get; set; }
        
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options)
        {
        }
    }
}