$htmlPath = "d:\Projects\nemyo\index.html"
$html = [System.IO.File]::ReadAllText($htmlPath, [System.Text.Encoding]::UTF8)

# 1. Update services header in index.html
$oldServicesHeader = @"
      <div class="section-header text-center">
        <div class="section-tag-wrapper">
          <span class="tag-flank-line left" aria-hidden="true"></span>
          <span class="section-tag">Наші послуги</span>
          <span class="tag-flank-line right" aria-hidden="true"></span>
        </div>
        <h2 class="section-title">Послуги для дому та бізнесу</h2>
        <p class="section-subtitle">
          Застосовуємо передове обладнання (генератори гарячого/холодного туману, промисловий озонатор до 5000 м²) та
          безпечні сертифіковані препарати.
        </p>
      </div>

      <div class="services-header-separator" aria-hidden="true"></div>
"@

$newServicesHeader = @"
      <div class="section-header text-center">
        <span class="section-tag">Наші послуги</span>
        <h2 class="section-title">Послуги для дому та бізнесу</h2>
        <p class="section-subtitle">
          Професійний захист від шкідників та дезінфекція приміщень сертифікованими препаратами.
        </p>
      </div>
"@

$servStart = $html.IndexOf('<div class="section-header text-center">')
$servEnd = $html.IndexOf('<div class="services-slider-wrap">', $servStart)

if ($servStart -ge 0 -and $servEnd -gt $servStart) {
    $html = $html.Substring(0, $servStart) + $newServicesHeader + "`r`n`r`n      " + $html.Substring($servEnd)
    Write-Output "SERVICES_HEADER_IN_HTML_UPDATED"
}

# 2. Update products subtitle in index.html
$oldProdSub = "Реалізуємо перевірені засоби для самостійного знезараження води, інсектицидні пастки для закладів харчування"
$pSubStart = $html.IndexOf($oldProdSub)
if ($pSubStart -ge 0) {
    $pSubEnd = $html.IndexOf("</p>", $pSubStart)
    $newProdSub = "Перевірені засоби для знезараження води, інсектицидні лампи HoReCa та станції дератизації."
    $html = $html.Substring(0, $pSubStart) + $newProdSub + "`r`n        " + $html.Substring($pSubEnd)
    Write-Output "PRODUCTS_SUBTITLE_IN_HTML_UPDATED"
}

[System.IO.File]::WriteAllText($htmlPath, $html, [System.Text.Encoding]::UTF8)

# 3. Update CSS in css/style.css
$cssPath = "d:\Projects\nemyo\css\style.css"
$css = [System.IO.File]::ReadAllText($cssPath, [System.Text.Encoding]::UTF8)

$cssAppend = @"

/* ==========================================================================
   REFINED COMPACT SECTION HEADERS (Services & Products)
   ========================================================================== */
.services-section-wrapper .section-header,
#products .section-header {
  margin-bottom: 0.75rem !important;
}

.services-section-wrapper .section-tag,
#products .section-tag {
  font-size: 0.72rem !important;
  font-weight: 700 !important;
  letter-spacing: 0.04em !important;
  text-transform: uppercase !important;
  padding: 0.2rem 0.65rem !important;
  border-radius: 6px !important;
  background: #F1F5F9 !important;
  color: #0F4C81 !important;
  border: 1px solid #E2E8F0 !important;
  margin-bottom: 0.35rem !important;
}

.services-section-wrapper .section-title,
#products .section-title {
  font-size: clamp(1.3rem, 2.2vw, 1.65rem) !important;
  font-weight: 800 !important;
  color: #0F172A !important;
  margin-bottom: 0.25rem !important;
  line-height: 1.25 !important;
  letter-spacing: -0.02em !important;
}

.services-section-wrapper .section-subtitle,
#products .section-subtitle {
  font-size: 0.86rem !important;
  color: #64748B !important;
  max-width: 560px !important;
  margin: 0 auto !important;
  line-height: 1.45 !important;
}

.tag-flank-line,
.services-header-separator {
  display: none !important;
}

"@

$css += "`r`n" + $cssAppend
[System.IO.File]::WriteAllText($cssPath, $css, [System.Text.Encoding]::UTF8)
Write-Output "HEADERS_CSS_UPDATED"
