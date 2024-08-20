# Edubadges MBO privacy documentation

This repository contains privacy documentation for the secondary vocational educational (MBO) institutions connected to edubadges. If you have any questions, feel free to contact us on [info@edubadges.nl](mailto:info@edubadges.nl).

## Usage

EasyPrivacyDocs generates privacy documentation based on institution variables. These variables are sourced from the comma seperated text file `mbo.csv`. Then EasyPrivacyDocs can download all required templates automatically (`easyprivacydocs-mbo --template`) and finally generate the privacy documentation for all entries in `mbo.csv` (`easyprivacydocs-mbo --generate`).

A walkthrough:

```
$ cat mbo.csv
Mbo School Saaxumhuizen,Saaxumhuizen MBO School,privacy@mbosaaxumhuizen.nl,mbo-school-saaxumhuizen
Mbo School Schokland,Schokland MBO School,privacy@mboschokland.nl,mbo-school-schokland

$ easyprivacydocs-mbo --template
Downloading privacy templates
  -- template-formal-excerpt-mbo-nl.md
  -- template-formal-excerpt-mbo-en.md
  -- template-formal-text-mbo-nl.md
  -- template-formal-text-mbo-en.md
  -- template-nonformal-excerpt-mbo-nl.md
  -- template-nonformal-excerpt-mbo-en.md
  -- template-nonformal-text-mbo-nl.md
  -- template-nonformal-text-mbo-en.md

$ easyprivacydocs-mbo --generate
Checking whether input file exists
  > Input file mbo.csv exists!

Generating privacy documents
  Mbo School Saaxumhuizen
    > Creating institution directory mbo-school-saaxumhuizen
    > Copy templates to mbo-school-saaxumhuizen
      - mbo-school-saaxumhuizen/edubadges-formal-excerpt-nl.md
      - mbo-school-saaxumhuizen/edubadges-formal-excerpt-en.md
      - mbo-school-saaxumhuizen/edubadges-formal-text-nl.md
      - mbo-school-saaxumhuizen/edubadges-formal-text-en.md
      - mbo-school-saaxumhuizen/edubadges-nonformal-excerpt-nl.md
      - mbo-school-saaxumhuizen/edubadges-nonformal-excerpt-en.md
      - mbo-school-saaxumhuizen/edubadges-nonformal-text-nl.md
      - mbo-school-saaxumhuizen/edubadges-nonformal-text-en.md
    > Customizing templates to institution data
      - Changing institution name (NL) to Mbo School Saaxumhuizen
      - Changing institution name (EN) to Saaxumhuizen MBO School
      - Changing institution privacy contact to privacy@mbosaaxumhuizen.nl
    > Done with Mbo School Saaxumhuizen

  Mbo School Schokland
    > Creating institution directory mbo-school-schokland
    > Copy templates to mbo-school-schokland
      - mbo-school-schokland/edubadges-formal-excerpt-nl.md
      - mbo-school-schokland/edubadges-formal-excerpt-en.md
      - mbo-school-schokland/edubadges-formal-text-nl.md
      - mbo-school-schokland/edubadges-formal-text-en.md
      - mbo-school-schokland/edubadges-nonformal-excerpt-nl.md
      - mbo-school-schokland/edubadges-nonformal-excerpt-en.md
      - mbo-school-schokland/edubadges-nonformal-text-nl.md
      - mbo-school-schokland/edubadges-nonformal-text-en.md
    > Customizing templates to institution data
      - Changing institution name (NL) to Mbo School Schokland
      - Changing institution name (EN) to Schokland MBO School
      - Changing institution privacy contact to privacy@mboschokland.nl
    > Done with Mbo School Schokland

All done! \o/
```

## Used terminology

| Dutch (NL) | English (EN) | File names |
| ---------- | ------------ | ---------- |
| account | account | account |
| edubadges | edubadges | edubadges |
| formele edubadges | formal edubadges | formal |
| niet-formele edubadges | non-formal edubadges | nonformal |
| privacyverklaring | privacy statement | statement |
| gebruiksvoorwaarden | terms of use | terms |
| privacyoverzicht | privacy excerpt | excerpt |

## Directory Layout and file name conventions

Consistency is important, follow the layout guidelines below for all future edits of this repository.

* Privacy documentation for the platform edubadges can be found in the folder `surf`.
* Privacy documentation for the secondary vocational educational (MBO) institutions can be found in the folder `mbo`.
* For each educational institution there is a dedicated folder which is named after their official full name. Spaces are replaced by hyphens (e.g. `universiteit-van-harderwijk`).
* File names consist of the following components and order:
  * subject (options: (1) `account` (2) `edubadges`)
  * variant (only for subject `account`)(options: (1) `excerpt` (2) `statement` (3) `terms`)
  * variant (only for subject `edubadges`)(options: (1) `formal` (2) `nonformal`)
  * type (options: (1) `text` (3) `excerpt`)
  * language (options: (1) `nl` (2) `en`)
  * `account` can only be used by the SURF organisation.

Some examples:

* Account: `account-statement-nl`, `account-terms-en`.
* Edubadge: `edubadges-formal-text-en`, `edubadges-nonformal-excerpt-nl`.
