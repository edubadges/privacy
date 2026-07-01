# Edubadges MBO privacy documentation

This repository contains privacy documentation for the secondary vocational educational (mbo) institutions connected to edubadges. If you have any questions, feel free to contact us on [info@edubadges.nl](mailto:info@edubadges.nl).

## Usage

EasyPrivacyDocs generates privacy documentation based on institution variables. These variables are sourced from the comma seperated text file `mbo.csv`. Then EasyPrivacyDocs can download all required templates automatically (`easyprivacydocs-mbo --template`) and finally generate the privacy documentation for all entries in `mbo.csv` (`easyprivacydocs-mbo --generate`).

## mbo.csv

This comma separated values file consists of the following information:

1. Institution name NL
2. Institution name EN
3. Institution schacHomeOrganization domain
4. Institution privacy email address
5. Institution privacy documentation subdirectory
6. Institution privacy documentation generation date
7. Legal basis for formal edubadges (optional)
8. Legal basis for non-formal edubadges (optional)

If no number is provided, EasyPrivacyDocs defaults to legitimate interest for formal edubadges and performance of an agreement for nonformal edubadges. Legal basis can be changed by setting a number ranging from 1 to 3.

```
1 - Legitimate interest
2 - Performance of agreement
3 - Public interest
```

For example:

```
$ cat mbo.csv
Mbo School Saaxumhuizen,Saaxumhuizen MBO School,mbosaaxumhuizen.nl,privacy@mbosaaxumhuizen.nl,mbo-school-saaxumhuizen,01-01-1970
Mbo School Schokland,Schokland MBO School,mboschokland.nl,privacy@mboschokland.nl,mbo-school-schokland,01-01-1970,3,2
```

## Runthrough

```
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
      - Changing institution directory to mbo-school-saaxumhuizen
      - Changing current date to 01-01-2024
      - Changing formal legal basis (NL) to Gerechtvaardigd belang
      - Changing formal legal basis (EN) to Legitimate interest
      - Changing nonformal legal basis (NL) to Uitvoering overeenkomst
      - Changing nonformal legal basis (EN) to Performance of agreement
    > Done with Mbo School Saaxumhuizen

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
