using System.IO;
using System.Text.RegularExpressions;

public class CsFileProcessor
{
    public void ProcessFolder(string folderPath)
    {
        var files = Directory.GetFiles(folderPath, "*.cs", SearchOption.AllDirectories);

        foreach (var file in files)
        {
            string content = File.ReadAllText(file);

            content = FixAsyncMethodNames(content);

            content = FixNaming(content);

            content = AddBlankLineBetweenMethods(content);

            File.WriteAllText(file, content);
        }
    }

    public string FixAsyncMethodNames(string content)
    {
        // Busca métodos async que no terminan en Async
        var pattern = @"async\s+Task\s+(\w+)\s*\(";
        return Regex.Replace(content, pattern, match =>
        {
            var name = match.Groups[1].Value;
            if (!name.EndsWith("Async"))
            {
                return match.Value.Replace(name, name + "Async");
            }
            return match.Value;
        });
    }

    public string FixNaming(string content)
    {
        // Reemplaza Vm/Vms/Dto/Dtos por VM/VMs/DTO/DTOs
        // Busca estas palabras como sufijos de identificadores o como palabras completas
        content = Regex.Replace(content, @"Vm(?=\s|{|$|[^\w])", "VM");
        content = Regex.Replace(content, @"Vms(?=\s|{|$|[^\w])", "VMs");
        content = Regex.Replace(content, @"Dto(?=\s|{|$|[^\w])", "DTO");
        content = Regex.Replace(content, @"Dtos(?=\s|{|$|[^\w])", "DTOs");
        return content;
    }

    public string AddBlankLineBetweenMethods(string content)
    {
        // Inserta una línea en blanco entre métodos consecutivos
        var pattern = @"\}\s+(public|private|protected|internal)\s";
        return Regex.Replace(content, pattern, "}\n\n$1 ");
    }
}
