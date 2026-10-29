-- Removes the review notes from the output.
--
-- The review notes of the chapters are written as HTML comments that start with "check:",
-- "note:" or "layout:" (for example <!-- check: ... -->), so that they stay in the source
-- but do not show in the book. Without this filter they would still be readable in the
-- page source of the HTML book.
-- To keep the notes in the output, delete the `filters` lines of _quarto.yml.
--
-- Only these notes are removed. Other comments are left alone on purpose: when Quarto
-- builds the PDF and the EPUB, it writes its own markers as HTML comments
-- (<!-- quarto-file-metadata: ... -->) and uses them to number the chapters and the parts.

local note_labels = { check = true, note = true, layout = true }

-- Takes the notes out of a piece of raw HTML and keeps every other comment.
local function without_notes(text)
  local cleaned = text:gsub("<!%-%-(.-)%-%->", function(comment)
    local label = comment:match("^%s*(%a+):")
    if label and note_labels[label] then
      return ""
    end
  end)
  return cleaned
end

local function clean(el)
  if el.format == "html" and el.text:find("<!%-%-") then
    local cleaned = without_notes(el.text)
    if cleaned == el.text then
      return nil
    end
    if cleaned:match("^%s*$") then
      return {}
    end
    el.text = cleaned
    return el
  end
end

RawBlock = clean
RawInline = clean
