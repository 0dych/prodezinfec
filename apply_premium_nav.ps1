$snippet = [System.IO.File]::ReadAllText("d:\Projects\nemyo\premium_nav_snippet.html", [System.Text.Encoding]::UTF8)
$files = @("index.html", "services.html", "products.html", "instructions.html", "contacts.html")
$pattern = '(?s)<div class="dropdown-menu".*?</div>\s*</div>\s*<a href="products\.html"'
$tail = "`r`n          </div>`r`n          <a href=`"products.html`""

foreach ($name in $files) {
    $path = "d:\Projects\nemyo\" + $name
    $content = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)
    $newContent = [System.Text.RegularExpressions.Regex]::Replace($content, $pattern, ($snippet.Trim() + $tail))
    [System.IO.File]::WriteAllText($path, $newContent, [System.Text.Encoding]::UTF8)
    [System.Console]::WriteLine("Updated " + $name)
}
