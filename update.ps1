$Databases = @("cve", "exploitdb", "openvas", "osvdb", "scipvuldb", "securityfocus", "securitytracker", "xforce")

foreach ($DB in $Databases) {
    Invoke-WebRequest -Uri "https://khulnasoft-lab.github.io/vulnscan/download/$DB.csv" -OutFile "$DB.csv"
    
    if (Test-Path "$DB.csv.1") {
        Rename-Item -Path "$DB.csv.1" -NewName "$DB.csv" -Force
    }
}
