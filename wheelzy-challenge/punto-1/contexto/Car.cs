namespace wheelzy_challenge.punto_1
{
    public class Car
    {
        public int Id { get; set; }
        public int Year { get; set; }
        public int SubmodelId { get; set; }
        public int ZipCodeId { get; set; }
        public Submodel Submodel { get; set; }
        public ZipCode ZipCode { get; set; }
    }
}