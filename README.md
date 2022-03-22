# Privacy documentation
This repository contains mostly externally oriented privacy documentation for the edubadges project. If you have any questions, please contact info@edubadges.nl.

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

## Privacy documentation overview
| Educational Institution | Formal basis | Nonformal basis | documentation | status |
| ----------------------- | ------------ | --------------- | --------------------- | ------ |
| Albeda | contract | contract | easyprivacydocs | done |
| Avans | legitimate interest | legitimate interest | easyprivacydocs | done |
| Deltion College | none | contract | easyprivacydocs | done |
| Erasmus Universiteit Rotterdam | none | legitimate interest | custom | done |
| Fontys Hogescholen | legitimate interest | contract | easyprivacydocs | done |
| Haagse Hogeschool | legitimate interest | legitimate interest | easyprivacydocs | done |
| Han University of Applied Sciences | none | legitimate interest | easyprivacydocs | done |
| Hanzehogeschool Groningen | none | legitimate interest | custom | done |
| HAS Hogeschool | contract | contract | easyprivacydocs | concept |
| Hogeschool Inholland | legitimate interest | legitimate interest | custom | done |
| Hogeschool Rotterdam | | | custom | done |
| Hogeschool Utrecht | legitimate interest | legitimate interest| custom | done |
| Hogeschool van Amsterdam | legitimate interest | legitimate interest | easyprivacydocs | done |
| Hogeschool Saxion | contract | contract | easyprivacydocs | done |
| Hotelschool The Hague | contract | legitimate interest | easyprivacydocs | done |
| Maastricht University | none | legitimate interest | custom | done |
| mboRijnland | none | legitimate interest | easyprivacydocs | done |
| NHL Stenden Hogeschool | legitimate interest | legitimate interest | easyprivacydocs | done |
| Rijksuniversiteit Groningen | legitimate interest | none | custom | done |
| Thomas More Hogeschool | contract | contract | easyprivacydocs | done |
| Tilburg University | none | contract | easyprivacydocs | done |
| Universiteit Twente | contract | legitimate interest | custom | done |
| Universiteit Utrecht | legitimate interest | legitimate interest | custom | done |
| VISTA College | contract | contract | easyprivacydocs | done |
| Vrije Universiteit Amsterdam | none | legitimate interest | custom | done |
| Wageningen University Research | legitimate interest | legitimate interest | custom | done |
| Windesheim | contract | none | easyprivacydocs | done |
| Zuyd Hogeschool | contract | none | easyprivacydocs | done |

## easyprivacydocs
`easyprivacydocs.sh` is a tool for creating the required edubadges privacy documentation the easy way.
