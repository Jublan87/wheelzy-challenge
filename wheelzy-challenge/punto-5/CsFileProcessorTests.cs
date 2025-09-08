using Xunit;

public class CsFileProcessorTests
{
    [Fact]
    public void FixAsyncMethodNames_AddsAsyncSuffix()
    {
        var processor = new CsFileProcessor();
        string input = "public async Task GetData() { }";
        string result = processor.FixAsyncMethodNames(input);
        Assert.Contains("GetDataAsync", result);
    }

    [Fact]
    public void FixNaming_ChangesVmToVM()
    {
        var processor = new CsFileProcessor();
        string input = "public class UserVm { }";
        string result = processor.FixNaming(input);
        Assert.Contains("UserVM", result);
    }

    [Fact]
    public void AddBlankLineBetweenMethods_InsertsBlankLine()
    {
        var processor = new CsFileProcessor();
        string input = "public void A() { } public void B() { }";
        string result = processor.AddBlankLineBetweenMethods(input);
        Assert.Contains("}\n\npublic void B()", result);
    }
}
