namespace wheelzy_challenge.punto_1
{
    public class ZipCode
    {
        public int Id { get; set; }
        public string Code { get; set; }
        public ICollection<Car> Cars { get; set; } = new List<Car>();
        public ICollection<BuyerZipCode> BuyerZipCodes { get; set; } = new List<BuyerZipCode>();
    }
}