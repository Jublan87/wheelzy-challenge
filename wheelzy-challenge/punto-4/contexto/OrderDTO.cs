namespace wheelzy_challenge.punto_4
{
    public class OrderDTO
    {
        public int Id { get; set; }
        public int CustomerId { get; set; }
        public string CustomerName { get; set; }
        public int StatusId { get; set; }
        public string StatusName { get; set; }
        public DateTime Date { get; set; }
        public bool IsActive { get; set; }
    }
}