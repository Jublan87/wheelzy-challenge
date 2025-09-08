namespace wheelzy_challenge.punto_4
{
    public class Customer
    {
        public int Id { get; set; }
        public string Name { get; set; }
        
        // Navigation property
        public ICollection<Order> Orders { get; set; }
    }
}