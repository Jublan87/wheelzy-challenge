namespace wheelzy_challenge.punto_1
{
    public class Buyer
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public ICollection<BuyerZipCode> BuyerZipCodes { get; set; } = new List<BuyerZipCode>();
    }
}