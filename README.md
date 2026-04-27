# Field Report Builder

A lightweight tool for generating formatted PDF inspection reports from a CSV of findings and a plain-text configuration file. Built for internal use at CET, Inc.

---

## How It Works

You fill in three files — `config.txt`, `findings.csv`, and `executive_summary.txt` — then run `build.bat`. The script reads your data, generates a Typst document (`report.typ`), and compiles it to a final `report.pdf`.

**You never need to edit `build_report.py` or `report.typ` directly.**

---

## First-Time Setup

These steps only need to be done once when setting up the tool on a new machine.

**1. Install Python 3.14+**
Download from [python.org](https://www.python.org/downloads/). During installation, check "Add Python to PATH".

**2. Install the Typst CLI**
Download the latest release from [github.com/typst/typst/releases](https://github.com/typst/typst/releases). Extract the executable and add its location to your system PATH. Verify it's working by opening a terminal and running:
```
typst --version
```

**3. Set up a virtual environment and install dependencies**
The project uses `uv` for virtual environment and package management, though any standard venv manager works fine. If you have `uv` installed:
```
uv sync
```
This will create a `.venv` folder and install the required Python packages automatically.

If you don't have `uv`, you can set up manually:
```
python -m venv .venv
.venv\Scripts\pip install typst
```

**4. Verify Python dependencies are available**
```
.venv\Scripts\python.exe -c "import typst; print('OK')"
```

---

## Starting a New Project

**1. Copy the template folder** to a new location for your project. The folder should contain:

```
project-folder/
├── build.bat
├── build_report.py
├── config.txt
├── executive_summary.txt
├── findings.csv
├── photos/
│   └── (your photo files go here)
├── cet_logo.png
└── uss_logo.png      ← or your client's logo
```

**2. Edit `config.txt`** — fill in the project metadata (see reference below).

**3. Edit `executive_summary.txt`** — write your summary in plain text. Separate paragraphs with a blank line.

**4. Edit `findings.csv`** — add your findings (see reference below).

**5. Add photos** — place all photo files in the `photos/` folder. Filenames must match exactly what is listed in the `photo` column of `findings.csv`.

**6. Run `build.bat`** — double-click it. If successful, `report.pdf` will appear in the project folder.

---

## File Reference

### config.txt

Edit the value to the right of each colon. Do not change the key names on the left.

| Key | Description | Example |
|---|---|---|
| `firm_name` | Your firm's name | `CET, Inc.` |
| `firm_address` | Firm address, use `\|` to separate lines | `6300 Melton Road \| Portage, IN 46368` |
| `firm_phone` | Firm phone number | `(219) 762-1431` |
| `firm_website` | Firm website | `www.cetincorp.com` |
| `project_name` | Short project descriptor | `Field Visit` |
| `property_name` | Name of the inspected property | `USS Gary Works` |
| `property_address` | Address of the property | `1 North Broadway, Gary, IN 46402` |
| `project_number` | CET project number | `69-26-03` |
| `report_date` | Date the report was issued | `April 20, 2026` |
| `inspection_date` | Date of the field visit | `April 8, 2026` |
| `prepared_by` | Name(s) of report authors | `Andrew Zollos, Frank Shrieves` |
| `reviewed_by` | Reviewer name and credentials | `Patrick Lyell, PE` |
| `client` | Client organization name | `United States Steel Corporation` |
| `report_title` | Report title shown on cover | `ETL 5 Modification Evaluation` |
| `client_logo` | Client logo filename (in project root) | `uss_logo.png` |
| `firm_logo` | CET logo filename (in project root) | `cet_logo.png` |
| `cover_photo` | Cover photo filename (in `photos/` folder) | `IMG_0001.JPG` |

Logos and cover photo are optional — leave the value blank to omit them.

---

### findings.csv

Each row is one finding. The CSV must have the following columns in this order:

| Column | Description | Example |
|---|---|---|
| `section_number` | Integer section number | `1` |
| `section_title` | Section name (shared across all findings in that section) | `Cooling Systems` |
| `finding_id` | Finding identifier, shown on the report | `1.1` |
| `location` | Where the finding was observed | `East Mezzanine, Elev. +24'` |
| `description` | Full observation text | `Corrosion observed on...` |
| `photo` | Photo filename in `photos/` folder, or leave blank | `IMG_0042.JPG` |

- Findings are grouped into sections automatically based on `section_number`.
- Each section gets a divider page, followed by finding pages with two findings per page.
- Sections appear in the report in the order they first appear in the CSV.

---

### executive_summary.txt

Plain text file. Write freely. Separate paragraphs with a blank line — each blank-line-separated block will render as its own paragraph in the report.

---

## Troubleshooting

**`build.bat` says "Python script failed"**
Check that your `.venv` folder exists and that `config.txt` and `findings.csv` are present and properly formatted.

**`build.bat` says "Typst compile failed"**
This usually means a photo file listed in `findings.csv` is missing from the `photos/` folder. Check filenames carefully — they are case-sensitive.

**A finding shows "No photo provided"**
The `photo` column for that finding is blank in the CSV. This is intentional and will render a gray placeholder box.

**Logo or cover photo not showing up**
Confirm the filename in `config.txt` matches exactly (including extension and capitalization) and that the file is in the project root (for logos) or `photos/` folder (for cover photo).
