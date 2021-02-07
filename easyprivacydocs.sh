#!/bin/sh

################################################################################
# Version 1.0.2-STABLE (07-02-2021)
################################################################################

################################################################################
# Copyright 2020-2021 SURF. Licenced under a GNU AFFERO GENERAL PUBLIC LICENSE
# Version 3. See https://www.gnu.org/licenses/#AGPL.
#
# Contact:
# > e-mail      info@surf.nl
# > GitHub      https://github.com/edubadges/privacy
################################################################################

################################################################################
# EasyPrivacyDocs generates institution privacy documentation for edubadges.nl.
################################################################################

################################################################################
# INSTITUTION INPUT
################################################################################

# both variables must be filled. use articles when it's part of the name
INSTITUTION_NAME_NL=''      # e.g. Hogeschool SURF
INSTITUTION_NAME_EN=''      # e.g. University of Applied Sciences SURF

# both contacts are required
EDUBADGES_CONTACT=''       # e.g. edubadges@hogeschoolsurf.nl
PRIVACY_CONTACT=''         # e.g. privacy@hogeschoolsurf.nl

# enable (1) or disable (0) types of edubadges
NONFORMAL_EDUBADGES='0'
FORMAL_EDUBADGES='0'

# the legal basis can be 0 (n/a), 1 (legitimate interest),
# 2 (performance of contract) or 3 (legal obligation)
NONFORMAL_LEGAL_BASIS='0'
FORMAL_LEGAL_BASIS='0'

# the purpose must be a sentence with a trailing dot
NONFORMAL_PURPOSE_NL=''
NONFORMAL_PURPOSE_EN=''
FORMAL_PURPOSE_NL=''
FORMAL_PURPOSE_EN=''

################################################################################
# ERROR FUNCTIONS
################################################################################

error_missing_institution_name() {
    echo 'error: institution name must be set'
    exit 1
}

error_missing_contact() {
    echo 'error: contact information must be set'
    exit 1
}

error_missing_type() {
    echo 'error: at least one type of edubadges must be selected'
    exit 1
}

error_missing_legal_basis() {
    echo 'error: legal basis must be set'
    exit 1
}

error_missing_purpose() {
    echo 'error: purpose must be set'
    exit 1
}

################################################################################
# INPUT VALIDATION
################################################################################

check_institution_input() {
    # check whether institution name values are given
    if [ "${INSTITUTION_NAME_NL}" = '' ] || [ "${INSTITUTION_NAME_EN}" = '' ]; then
        error_missing_institution_name
    fi

    # check whether either edubadges or privacy contact has been used
    if [ "${EDUBADGES_CONTACT}" = '' ] && [ "${PRIVACY_CONTACT}" = '' ]; then
        error_missing_contact
    fi

    # check whether at least one type of edubadges is enabled
    if [ "${NONFORMAL_EDUBADGES}" != '1' ] && [ "${FORMAL_EDUBADGES}" != '1' ]; then
        error_missing_type
    fi

    # check whether legal basis and purpose are given for enabled edubadge types
    if [ "${NONFORMAL_EDUBADGES}" = '1' ]; then
        if [ "${NONFORMAL_LEGAL_BASIS}" = '0' ]; then
            error_missing_legal_basis
        fi
        if [ "${NONFORMAL_PURPOSE_NL}" = '' ]; then
            error_missing_purpose
        elif [ "${NONFORMAL_PURPOSE_EN}" = '' ]; then
            error_missing_purpose
        fi
    fi
    if [ "${FORMAL_EDUBADGES}" = '1' ]; then
        if [ "${FORMAL_LEGAL_BASIS}" = '0' ]; then
            error_missing_legal_basis
        fi
        if [ "${FORMAL_PURPOSE_NL}" = '' ]; then
            error_missing_purpose
        elif [ "${FORMAL_PURPOSE_EN}" = '' ]; then
            error_missing_purpose
        fi
    fi
}

################################################################################
# TEXT TEMPLATES
################################################################################

# for each enabled edubadge type, there is a excerpt text and full text

# general templates
DATE="$(date +%d-%m-%Y)"

# excerpt templates
EXCERPT_TITLE_NONFORMAL_LEGITIMATE_NL='# edubadges en jouw privacy'
EXCERPT_TITLE_NONFORMAL_LEGITIMATE_EN='# edubadges and your privacy'
EXCERPT_TITLE_NONFORMAL_CONTRACT_NL='# Gebruiksvoorwaarden voor deze edubadge'
EXCERPT_TITLE_NONFORMAL_CONTRACT_EN='# Terms of use for this edubadge'
EXCERPT_TITLE_NONFORMAL_OBLIGATION_NL=''
EXCERPT_TITLE_NONFORMAL_OBLIGATION_EN=''

EXCERPT_TITLE_FORMAL_LEGITIMATE_NL='# edubadges en jouw privacy'
EXCERPT_TITLE_FORMAL_LEGITIMATE_EN='# edubadges and your privacy'
EXCERPT_TITLE_FORMAL_CONTRACT_NL='# Gebruiksvoorwaarden voor deze edubadge'
EXCERPT_TITLE_FORMAL_CONTRACT_EN='# Terms of use for this edubadge'
EXCERPT_TITLE_FORMAL_OBLIGATION_NL=''
EXCERPT_TITLE_FORMAL_OBLIGATION_EN=''

EXCERPT_PREFACE_NONFORMAL_LEGITIMATE_NL="\n\nHieronder staan de belangrijkste punten over deze edubadges en jouw privacy. In de [volledige versie](link) wordt in detail ingegaan op deze verwerking."
EXCERPT_PREFACE_NONFORMAL_LEGITIMATE_EN="\n\nBelow are the most important points about edubadges and your privacy. In the [full version](link) detailed information about this processing can be found."
EXCERPT_PREFACE_NONFORMAL_CONTRACT_NL="\n\nHieronder staan de belangrijkste punten over deze edubadges en jouw privacy. In de [volledige versie](link) wordt in detail ingegaan op deze verwerking."
EXCERPT_PREFACE_NONFORMAL_CONTRACT_EN="\n\nBelow are the most important points about edubadges and your privacy. In the [full version](link) detailed information about this processing can be found."
EXCERPT_PREFACE_NONFORMAL_OBLIGATION_NL=''
EXCERPT_PREFACE_NONFORMAL_OBLIGATION_EN=''

EXCERPT_PREFACE_FORMAL_LEGITIMATE_NL="\n\nHieronder staan de belangrijkste punten over deze edubadges en jouw privacy. In de [volledige versie](link) wordt in detail ingegaan op deze verwerking."
EXCERPT_PREFACE_FORMAL_LEGITIMATE_EN="\n\nBelow are the most important points about edubadges and your privacy. In the [full version](link) detailed information about this processing can be found."
EXCERPT_PREFACE_FORMAL_CONTRACT_NL="\n\nHieronder staan de belangrijkste punten over deze edubadges en jouw privacy. In de [volledige versie](link) wordt in detail ingegaan op deze verwerking."
EXCERPT_PREFACE_FORMAL_CONTRACT_EN="\n\nBelow are the most important points about edubadges and your privacy. In the [full version](link) detailed information about this processing can be found."
EXCERPT_PREFACE_FORMAL_OBLIGATION_NL=''
EXCERPT_PREFACE_FORMAL_OBLIGATION_EN=''

EXCERPT_ROLES_NONFORMAL_LEGITIMATE_NL="\n\n${INSTITUTION_NAME_NL} is de verwerkingsverantwoordelijke en SURF is de verwerker voor het uitgeven van edubadges. Voor het functioneren van het edubadgesplatform is het noodzakelijk om persoonsgegevens te verwerken. ${NONFORMAL_PURPOSE_NL}."
EXCERPT_ROLES_NONFORMAL_LEGITIMATE_EN="\n\n${INSTITUTION_NAME_EN} is the controller and SURF is the processor for issuing edubadges. For the edubadges platform to function, it is necessary to process your personal data. ${NONFORMAL_PURPOSE_EN}."
EXCERPT_ROLES_NONFORMAL_CONTRACT_NL="\n\n${INSTITUTION_NAME_NL} is de verwerkingsverantwoordelijke en SURF is de verwerker voor het uitgeven van edubadges. Voor het functioneren van het edubadgesplatform is het noodzakelijk om persoonsgegevens te verwerken. ${NONFORMAL_PURPOSE_NL}."
EXCERPT_ROLES_NONFORMAL_CONTRACT_EN="\n\n${INSTITUTION_NAME_EN} is the controller and SURF is the processor for issuing edubadges. For the edubadges platform to function, it is necessary to process your personal data. ${NONFORMAL_PURPOSE_EN}."
EXCERPT_ROLES_NONFORMAL_OBLIGATION_NL=''
EXCERPT_ROLES_NONFORMAL_OBLIGATION_EN=''

EXCERPT_ROLES_FORMAL_LEGITIMATE_NL="\n\n${INSTITUTION_NAME_NL} is de verwerkingsverantwoordelijke en SURF is de verwerker voor het uitgeven van edubadges. Voor het functioneren van het edubadgesplatform is het noodzakelijk om persoonsgegevens te verwerken. ${FORMAL_PURPOSE_NL}."
EXCERPT_ROLES_FORMAL_LEGITIMATE_EN="\n\n${INSTITUTION_NAME_EN} is the controller and SURF is the processor for issuing edubadges. For the edubadges platform to function, it is necessary to process your personal data. ${FORMAL_PURPOSE_EN}."
EXCERPT_ROLES_FORMAL_CONTRACT_NL="\n\n${INSTITUTION_NAME_NL} is de verwerkingsverantwoordelijke en SURF is de verwerker voor het uitgeven van edubadges. Voor het functioneren van het edubadgesplatform is het noodzakelijk om persoonsgegevens te verwerken. ${FORMAL_PURPOSE_NL}."
EXCERPT_ROLES_FORMAL_CONTRACT_EN="\n\n${INSTITUTION_NAME_EN} is the controller and SURF is the processor for issuing edubadges. For the edubadges platform to function, it is necessary to process your personal data. ${FORMAL_PURPOSE_EN}."
EXCERPT_ROLES_FORMAL_OBLIGATION_NL=''
EXCERPT_ROLES_FORMAL_OBLIGATION_EN=''

EXCERPT_PII_NONFORMAL_LEGITIMATE_NL="\n\nVoor het uitgeven van edubadges worden je voornaam, achternaam en e-mailadres verwerkt. Daarnaast bevat de edubadge je eduID en aanvullende informatie zoals het tijdstip van uitgifte, de uitgever (${INSTITUTION_NAME_NL}) en informatie over de prestatie, onderwijsmodule en/of leeruitkomst. Met vragen over je privacy kun je contact opnemen met [${PRIVACY_CONTACT}](mailto:${PRIVACY_CONTACT})."
EXCERPT_PII_NONFORMAL_LEGITIMATE_EN="\n\nTo issue edubadges, your first name, last name and email address are processed. In addition the edubadge contains your eduID and supplementary information such as the time of issue, the publisher (${INSTITUTION_NAME_EN}) and information about the achievement, educational module and/or learning outcomes. If you have any questions about your privacy, please contact [${PRIVACY_CONTACT}](mailto:${PRIVACY_CONTACT})."
EXCERPT_PII_NONFORMAL_CONTRACT_NL="\n\nVoor het uitgeven van edubadges worden je voornaam, achternaam en e-mailadres verwerkt. Daarnaast bevat de edubadge je eduID en aanvullende informatie zoals het tijdstip van uitgifte, de uitgever (${INSTITUTION_NAME_NL}) en informatie over de prestatie, onderwijsmodule en/of leeruitkomst. Met vragen over je privacy kun je contact opnemen met [${PRIVACY_CONTACT}](mailto:${PRIVACY_CONTACT})."
EXCERPT_PII_NONFORMAL_CONTRACT_EN="\n\nTo issue edubadges, your first name, last name and email address are processed. In addition the edubadge contains your eduID and supplementary information such as the time of issue, the publisher (${INSTITUTION_NAME_EN}) and information about the achievement, educational module and/or learning outcomes. If you have any questions about your privacy, please contact [${PRIVACY_CONTACT}](mailto:${PRIVACY_CONTACT})."
EXCERPT_PII_NONFORMAL_OBLIGATION_NL=''
EXCERPT_PII_NONFORMAL_OBLIGATION_EN=''

EXCERPT_PII_FORMAL_LEGITIMATE_NL="\n\nVoor het uitgeven van edubadges worden je voornaam, achternaam en e-mailadres verwerkt. Daarnaast bevat de edubadge je eduID en aanvullende informatie zoals het tijdstip van uitgifte, de uitgever (${INSTITUTION_NAME_NL}) en informatie over de prestatie, onderwijsmodule en/of leeruitkomst. Met vragen over je privacy kun je contact opnemen met [${PRIVACY_CONTACT}](mailto:${PRIVACY_CONTACT})."
EXCERPT_PII_FORMAL_LEGITIMATE_EN="\n\nTo issue edubadges, your first name, last name and email address are processed. In addition the edubadge contains your eduID and supplementary information such as the time of issue, the publisher (${INSTITUTION_NAME_EN}) and information about the achievement, educational module and/or learning outcomes. If you have any questions about your privacy, please contact [${PRIVACY_CONTACT}](mailto:${PRIVACY_CONTACT})."
EXCERPT_PII_FORMAL_CONTRACT_NL="\n\nVoor het uitgeven van edubadges worden je voornaam, achternaam en e-mailadres verwerkt. Daarnaast bevat de edubadge je eduID en aanvullende informatie zoals het tijdstip van uitgifte, de uitgever (${INSTITUTION_NAME_NL}) en informatie over de prestatie, onderwijsmodule en/of leeruitkomst. Met vragen over je privacy kun je contact opnemen met [${PRIVACY_CONTACT}](mailto:${PRIVACY_CONTACT})."
EXCERPT_PII_FORMAL_CONTRACT_EN="\n\nTo issue edubadges, your first name, last name and email address are processed. In addition the edubadge contains your eduID and supplementary information such as the time of issue, the publisher (${INSTITUTION_NAME_EN}) and information about the achievement, educational module and/or learning outcomes. If you have any questions about your privacy, please contact [${PRIVACY_CONTACT}](mailto:${PRIVACY_CONTACT})."
EXCERPT_PII_FORMAL_OBLIGATION_NL=''
EXCERPT_PII_FORMAL_OBLIGATION_EN=''

EXCERPT_FOOTER_NONFORMAL_LEGITIMATE_NL="\n\nDoor op 'Ik heb dit gelezen' te klikken verklaar je de [volledige privacyverklaring](link) gelezen te hebben."
EXCERPT_FOOTER_NONFORMAL_LEGITIMATE_EN="\n\nBy clicking 'I have read this', you declare that you have read the [full privacy statement](link)."
EXCERPT_FOOTER_NONFORMAL_CONTRACT_NL="\n\nDoor op 'Ik ga akkoord' te klikken ga je akkoord met de [volledige versie van deze gebruiksvoorwaarden](link)."
EXCERPT_FOOTER_NONFORMAL_CONTRACT_EN="\n\nBy clicking 'I agree', you are agreeing to the [full version of these terms of use](link)."
EXCERPT_FOOTER_NONFORMAL_OBLIGATION_NL=''
EXCERPT_FOOTER_NONFORMAL_OBLIGATION_EN=''

EXCERPT_FOOTER_FORMAL_LEGITIMATE_NL="\n\nDoor op 'Ik heb dit gelezen' te klikken verklaar je de [volledige privacyverklaring](link) gelezen te hebben."
EXCERPT_FOOTER_FORMAL_LEGITIMATE_EN="\n\nBy clicking 'I have read this', you declare that you have read the [full privacy statement](link)."
EXCERPT_FOOTER_FORMAL_CONTRACT_NL="\n\nDoor op 'Ik ga akkoord' te klikken ga je akkoord met de [volledige versie van deze gebruiksvoorwaarden](link)."
EXCERPT_FOOTER_FORMAL_CONTRACT_EN="\n\nBy clicking 'I agree', you are agreeing to the [full version of these terms of use](link)."
EXCERPT_FOOTER_FORMAL_OBLIGATION_NL=''
EXCERPT_FOOTER_FORMAL_OBLIGATION_EN=''

# full text templates
TEXT_PREFACE_NONFORMAL_LEGITIMATE_NL="\n\nGoed dat je de privacyverklaring van ${INSTITUTION_NAME_NL} voor de dienst edubadges bekijkt! We hebben veel aandacht besteed aan de bescherming van jouw persoonsgegevens en in deze privacyverklaring kun je daar over lezen. Als er na het lezen van deze privacyverklaring toch nog vragen, opmerkingen of zorgen zijn, stuur dan gerust een e-mail naar ${PRIVACY_CONTACT}."
TEXT_PREFACE_NONFORMAL_LEGITIMATE_EN="\n\nWe are glad that you’re reading the privacy statement of ${INSTITUTION_NAME_EN} for the service edubadges! We have paid a lot of attention to the protection of your personal data, and you can read all about it in this privacy statement. If you have any questions, comments or concerns after reading this privacy statement, please email ${PRIVACY_CONTACT}."
TEXT_PREFACE_NONFORMAL_CONTRACT_NL="\n\nGoed dat je de gebruiksvoorwaarden van ${INSTITUTION_NAME_NL} voor de dienst edubadges bekijkt! We hebben veel aandacht besteed aan de bescherming van jouw persoonsgegevens en in deze gebruiksvoorwaarden kun je daar over lezen. Om deze edubadge te kunnen ontvangen dien je akkoord gaan met deze gebruiksvoorwaarden. Heb je vragen, opmerkingen of zorgen? Stuur dan een e-mail naar ${PRIVACY_CONTACT}."
TEXT_PREFACE_NONFORMAL_CONTRACT_EN="\n\nWe are glad that you’re reading the terms of use of ${INSTITUTION_NAME_EN} for the service edubadges! We have paid a lot of attention to the protection of your personal data, and you can read all about it in these terms of service. To receive this edubadge, you have to agree with these terms of service. If you have any questions, comments or concerns, please email ${PRIVACY_CONTACT}."
TEXT_PREFACE_NONFORMAL_OBLIGATIONS_NL=''
TEXT_PREFACE_NONFORMAL_OBLIGATIONS_EN=''

TEXT_PREFACE_FORMAL_LEGITIMATE_NL="\n\nGoed dat je de privacyverklaring van ${INSTITUTION_NAME_NL} voor de dienst edubadges bekijkt! We hebben veel aandacht besteed aan de bescherming van jouw persoonsgegevens en in deze privacyverklaring kun je daar over lezen. Als er na het lezen van deze privacyverklaring toch nog vragen, opmerkingen of zorgen zijn, stuur dan gerust een e-mail naar ${PRIVACY_CONTACT}."
TEXT_PREFACE_FORMAL_LEGITIMATE_EN="\n\nWe are glad that you’re reading the privacy statement of ${INSTITUTION_NAME_EN} for the service edubadges! We have paid a lot of attention to the protection of your personal data, and you can read all about it in this privacy statement. If you have any questions, comments or concerns after reading this privacy statement, please email ${PRIVACY_CONTACT}."
TEXT_PREFACE_FORMAL_CONTRACT_NL="\n\nGoed dat je de gebruiksvoorwaarden van ${INSTITUTION_NAME_NL} voor de dienst edubadges bekijkt! We hebben veel aandacht besteed aan de bescherming van jouw persoonsgegevens en in deze gebruiksvoorwaarden kun je daar over lezen. Om de edubadge in kwestie te kunnen ontvangen dien je akkoord gaan met deze gebruiksvoorwaarden. Heb je vragen, opmerkingen of zorgen? Stuur dan een e-mail naar ${PRIVACY_CONTACT}."
TEXT_PREFACE_FORMAL_CONTRACT_EN="\n\nWe are glad that you’re reading the terms of use of ${INSTITUTION_NAME_EN} for the service edubadges! We have paid a lot of attention to the protection of your personal data, and you can read all about it in these terms of service. To receive this edubadge, you have to agree with these terms of service. If you have any questions, comments or concerns, please email ${PRIVACY_CONTACT}."
TEXT_PREFACE_FORMAL_OBLIGATIONS_NL=''
TEXT_PREFACE_FORMAL_OBLIGATIONS_EN=''

TEXT_INTRODUCTION_NONFORMAL_LEGITIMATE_NL="\n\n# 1 Wat zijn edubadges\n\nEen edubadge is een digitaal insigne (afbeelding), dat aantoont dat de ontvanger over bepaalde kennis of vaardigheden beschikt. De ontvanger van een edubadge kan deze delen met anderen, bijvoorbeeld op sociale media, een digitaal cv, een onderwijsinstelling of met een (potentiële) werkgever.\n\nOm edubadges te kunnen maken en toekennen is een technische infrastructuur nodig. SURF (een coöperatieve vereniging van Nederlandse onderwijs- en onderzoeksinstellingen) heeft deze infrastructuur voor het uitgeven van edubadges ontwikkeld, waarbij de edubadges veilig binnen SURF worden opgeslagen en gevalideerd kunnen worden. Meer informatie over edubadges is te vinden op de [website van SURF](https://surf.nl/edubadges)."
TEXT_INTRODUCTION_NONFORMAL_LEGITIMATE_EN="\n\n# 1 Introduction\n\nAn edubadge is a digital badge (image) which shows that the holder has certain knowledge or skills. The recipient of an edubadge can share it with others, for example on social media, on a digital CV, or with an educational institution or (potential) employer.\n\nA technical infrastructure is required in order to create and award edubadges. SURF has developed the infrastructure for issuing edubadges and the edubadges are stored securely and can be validated within SURF's systems. More information about edubadges can be found on [SURF's website](https://surf.nl/edubadges)."
TEXT_INTRODUCTION_NONFORMAL_CONTRACT_NL="\n\n# 1 Wat zijn edubadges\n\nEen edubadge is een digitaal insigne (afbeelding), dat aantoont dat de ontvanger over bepaalde kennis of vaardigheden beschikt. De ontvanger van een edubadge kan deze delen met anderen, bijvoorbeeld op sociale media, een digitaal cv, een onderwijsinstelling of met een (potentiële) werkgever.\n\nOm edubadges te kunnen maken en toekennen is een technische infrastructuur nodig. SURF (een coöperatieve vereniging van Nederlandse onderwijs- en onderzoeksinstellingen) heeft deze infrastructuur voor het uitgeven van edubadges ontwikkeld, waarbij de edubadges veilig binnen SURF worden opgeslagen en gevalideerd kunnen worden. Meer informatie over edubadges is te vinden op de [website van SURF](https://surf.nl/edubadges)."
TEXT_INTRODUCTION_NONFORMAL_CONTRACT_EN="\n\n# 1 Introduction\n\nAn edubadge is a digital badge (image) which shows that the holder has certain knowledge or skills. The recipient of an edubadge can share it with others, for example on social media, on a digital CV, or with an educational institution or (potential) employer.\n\nA technical infrastructure is required in order to create and award edubadges. SURF has developed the infrastructure for issuing edubadges and the edubadges are stored securely and can be validated within SURF's systems. More information about edubadges can be found on [SURF's website](https://surf.nl/edubadges)."
TEXT_INTRODUCTION_NONFORMAL_OBLIGATIONS_NL=''
TEXT_INTRODUCTION_NONFORMAL_OBLIGATIONS_EN=''

TEXT_INTRODUCTION_FORMAL_LEGITIMATE_NL="\n\n# 1 Wat zijn edubadges\n\nEen edubadge is een digitaal insigne (afbeelding), dat aantoont dat de ontvanger over bepaalde kennis of vaardigheden beschikt. De ontvanger van een edubadge kan deze delen met anderen, bijvoorbeeld op sociale media, een digitaal cv, een onderwijsinstelling of met een (potentiële) werkgever.\n\nOm edubadges te kunnen maken en toekennen is een technische infrastructuur nodig. SURF (een coöperatieve vereniging van Nederlandse onderwijs- en onderzoeksinstellingen) heeft deze infrastructuur voor het uitgeven van edubadges ontwikkeld, waarbij de edubadges veilig binnen SURF worden opgeslagen en gevalideerd kunnen worden. Meer informatie over edubadges is te vinden op de [website van SURF](https://surf.nl/edubadges)."
TEXT_INTRODUCTION_FORMAL_LEGITIMATE_EN="\n\n# 1 Introduction\n\nAn edubadge is a digital badge (image) which shows that the holder has certain knowledge or skills. The recipient of an edubadge can share it with others, for example on social media, on a digital CV, or with an educational institution or (potential) employer.\n\nA technical infrastructure is required in order to create and award edubadges. SURF has developed the infrastructure for issuing edubadges and the edubadges are stored securely and can be validated within SURF's systems. More information about edubadges can be found on [SURF's website](https://surf.nl/edubadges)."
TEXT_INTRODUCTION_FORMAL_CONTRACT_NL="\n\n# 1 Wat zijn edubadges\n\nEen edubadge is een digitaal insigne (afbeelding), dat aantoont dat de ontvanger over bepaalde kennis of vaardigheden beschikt. De ontvanger van een edubadge kan deze delen met anderen, bijvoorbeeld op sociale media, een digitaal cv, een onderwijsinstelling of met een (potentiële) werkgever.\n\nOm edubadges te kunnen maken en toekennen is een technische infrastructuur nodig. SURF (een coöperatieve vereniging van Nederlandse onderwijs- en onderzoeksinstellingen) heeft deze infrastructuur voor het uitgeven van edubadges ontwikkeld, waarbij de edubadges veilig binnen SURF worden opgeslagen en gevalideerd kunnen worden. Meer informatie over edubadges is te vinden op de [website van SURF](https://surf.nl/edubadges)."
TEXT_INTRODUCTION_FORMAL_CONTRACT_EN="\n\n# 1 Introduction\n\nAn edubadge is a digital badge (image) which shows that the holder has certain knowledge or skills. The recipient of an edubadge can share it with others, for example on social media, on a digital CV, or with an educational institution or (potential) employer.\n\nA technical infrastructure is required in order to create and award edubadges. SURF has developed the infrastructure for issuing edubadges and the edubadges are stored securely and can be validated within SURF's systems. More information about edubadges can be found on [SURF's website](https://surf.nl/edubadges)."
TEXT_INTRODUCTION_FORMAL_OBLIGATIONS_NL=''
TEXT_INTRODUCTION_FORMAL_OBLIGATIONS_EN=''

TEXT_PROCESSING_NONFORMAL_LEGITIMATE_NL="\n\n# 2 Doel en verwerking\n\n${NONFORMAL_PURPOSE_NL}\n\nDe edubadgesservice is onderverdeeld in twee delen:\n\n* Account/backpack (1):\n  * Aanmaken en in stand houden van een account\n  * Opslaan van edubadges in een backpack\n  * Valideren van edubadges\n* Uitgeven van edubadges (2):\n  * Inschrijven voor een edubadge\n  * Genereren van een edubadge\n  * Versturen van een edubadge\n\nVoor het account/backpack (1) is SURF de verwerkingsverantwoordelijke. Zie hiervoor de [privacyverklaring van edubadges.nl](https://edubadges.nl/privacy). Met vragen kun je een e-mail sturen naar [support@edubadges.nl](mailto:support@edubadges.nl).\n\nVoor het uitgeven van edubadges (2) is ${INSTITUTION_NAME_NL} de verwerkingsverantwoordelijke en is SURF de verwerker. Deze privacyverklaring heeft vooral betrekking op deze verwerkingen door ${INSTITUTION_NAME_NL}."
TEXT_PROCESSING_NONFORMAL_LEGITIMATE_EN="\n\n# 2 Purpose and processing\n\n${NONFORMAL_PURPOSE_EN}\n\nThe edubadges service is divided into two parts:\n\n* Account/backpack (1):\n  * Creating and maintaining an account\n  * Storing edubadges in the backpack\n  * Validating edubadges\n* Issuing an edubadges (2):\n  * Registering for edubadges\n  * Creating an edubadge\n  * Issuing an edubadge\n\nFor the account/backpack (1), SURF is the controller. See the [privacy statement of edubadges.nl](https://edubadges.nl/privacy) for more information. You can contact [support@edubadges.nl](mailto:support@edubadges.nl) with questions. For issuing edubadges (2), ${INSTITUTION_NAME_EN} is the controller and SURF is the processor. This privacy statement relates primarily to the processing by ${INSTITUTION_NAME_EN}."
TEXT_PROCESSING_NONFORMAL_CONTRACT_NL="\n\n# 2 Doel en verwerking\n\n${NONFORMAL_PURPOSE_NL}\n\nDe edubadgesservice is onderverdeeld in twee delen:\n\n* Account/backpack (1):\n  * Aanmaken en in stand houden van een account\n  * Opslaan van edubadges in een backpack\n  * Valideren van edubadges\n* Uitgeven van edubadges (2):\n  * Inschrijven voor een edubadge\n  * Genereren van een edubadge\n  * Versturen van een edubadge\n\nVoor het account/backpack (1) is SURF de verwerkingsverantwoordelijke. Zie hiervoor de [privacyverklaring van edubadges.nl](https://edubadges.nl/privacy). Met vragen kun je een e-mail sturen naar [support@edubadges.nl](mailto:support@edubadges.nl).\n\nVoor het uitgeven van edubadges (2) is ${INSTITUTION_NAME_NL} de verwerkingsverantwoordelijke en is SURF de verwerker. Deze privacyverklaring heeft vooral betrekking op deze verwerkingen door ${INSTITUTION_NAME_NL}."
TEXT_PROCESSING_NONFORMAL_CONTRACT_EN="\n\n# 2 Purpose and processing\n\n${NONFORMAL_PURPOSE_EN}\n\nThe edubadges service is divided into two parts:\n\n* Account/backpack (1):\n  * Creating and maintaining an account\n  * Storing edubadges in the backpack\n  * Validating edubadges\n* Issuing an edubadges (2):\n  * Registering for edubadges\n  * Creating an edubadge\n  * Issuing an edubadge\n\nFor the account/backpack (1), SURF is the controller. See the [privacy statement of edubadges.nl](https://edubadges.nl/privacy) for more information. You can contact [support@edubadges.nl](mailto:support@edubadges.nl) with questions. For issuing edubadges (2), ${INSTITUTION_NAME_EN} is the controller and SURF is the processor. This privacy statement relates primarily to the processing by ${INSTITUTION_NAME_EN}."
TEXT_PROCESSING_NONFORMAL_OBLIGATIONS_NL=''
TEXT_PROCESSING_NONFORMAL_OBLIGATIONS_EN=''

TEXT_PROCESSING_FORMAL_LEGITIMATE_NL="\n\n# 2 Doel en verwerking\n\n${FORMAL_PURPOSE_NL}\n\nDe edubadgesservice is onderverdeeld in twee delen:\n\n* Account/backpack (1):\n  * Aanmaken en in stand houden van een account\n  * Opslaan van edubadges in een backpack\n  * Valideren van edubadges\n* Uitgeven van edubadges (2):\n  * Inschrijven voor een edubadge\n  * Genereren van edubadge\n  * Versturen van een edubadge\n\nVoor het account/backpack (1) is SURF de verwerkingsverantwoordelijke. Zie hiervoor de [privacyverklaring van edubadges.nl](https://edubadges.nl/privacy). Met vragen kun je een e-mail sturen naar [support@edubadges.nl](mailto:support@edubadges.nl).\n\nVoor het uitgeven van edubadges (2) is ${INSTITUTION_NAME_NL} de verwerkingsverantwoordelijke en is SURF de verwerker. Deze privacyverklaring heeft vooral betrekking op deze verwerkingen door ${INSTITUTION_NAME_NL}."
TEXT_PROCESSING_FORMAL_LEGITIMATE_EN="\n\n# 2 Purpose and processing\n\n${FORMAL_PURPOSE_EN}\n\nThe edubadges service is divided into two parts:\n\n* Account/backpack (1):\n  * Creating and maintaining an account\n  * Storing edubadges in the backpack\n  * Validating edubadges\n* Issuing an edubadges (2):\n  * Registering for edubadges\n  * Creating an edubadge\n  * Issuing an edubadge\n\nFor the account/backpack (1), SURF is the controller. See the [privacy statement of edubadges.nl](https://edubadges.nl/privacy) for more information. You can contact [support@edubadges.nl](mailto:support@edubadges.nl) with questions. For issuing edubadges (2), ${INSTITUTION_NAME_EN} is the controller and SURF is the processor. This privacy statement relates primarily to the processing by ${INSTITUTION_NAME_EN}."
TEXT_PROCESSING_FORMAL_CONTRACT_NL="\n\n# 2 Doel en verwerking\n\n${FORMAL_PURPOSE_NL}\n\nDe edubadgesservice is onderverdeeld in twee delen:\n\n* Account/backpack (1):\n  * Aanmaken en in stand houden van een account\n  * Opslaan van edubadges in een backpack\n  * Valideren van edubadges\n* Uitgeven van edubadges (2):\n  * Inschrijven voor een edubadge\n  * Genereren van een edubadge\n  * Versturen van een edubadge\n\nVoor het account/backpack (1) is SURF de verwerkingsverantwoordelijke. Zie hiervoor de [privacyverklaring van edubadges.nl](https://edubadges.nl/privacy). Met vragen kun je een e-mail sturen naar [support@edubadges.nl](mailto:support@edubadges.nl).\n\nVoor het uitgeven van edubadges (2) is ${INSTITUTION_NAME_NL} de verwerkingsverantwoordelijke en is SURF de verwerker. Deze privacyverklaring heeft vooral betrekking op deze verwerkingen door ${INSTITUTION_NAME_NL}."
TEXT_PROCESSING_FORMAL_CONTRACT_EN="\n\n# 2 Purpose and processing\n\n${FORMAL_PURPOSE_EN}\n\nThe edubadges service is divided into two parts:\n\n* Account/backpack (1):\n  * Creating and maintaining an account\n  * Storing edubadges in the backpack\n  * Validating edubadges\n* Issuing an edubadges (2):\n  * Registering for edubadges\n  * Creating an edubadge\n  * Issuing an edubadge\n\nFor the account/backpack (1), SURF is the controller. See the [privacy statement of edubadges.nl](https://edubadges.nl/privacy) for more information. You can contact [support@edubadges.nl](mailto:support@edubadges.nl) with questions. For issuing edubadges (2), ${INSTITUTION_NAME_EN} is the controller and SURF is the processor. This privacy statement relates primarily to the processing by ${INSTITUTION_NAME_EN}."
TEXT_PROCESSING_FORMAL_OBLIGATIONS_NL=''
TEXT_PROCESSING_FORMAL_OBLIGATIONS_EN=''

TEXT_DATA_NONFORMAL_LEGITIMATE_NL="\n\n# 3 Persoonsgegevens\n\nVoor de uitgifte van edubadges zijn drie verwerkingen relevant:\n\n1. Registreren voor een edubadge\n2. Het aanmaken van een edubadge\n3. Het verzenden van een edubadge\n\nIn de onderstaande tabel staan de persoonsgegevens (met doel en grondslag) die worden verwerkt als jij een edubadge aanvraagt, wanneer de edubadge gemaakt wordt en wanneer de edubadge verzonden wordt. Deze persoonsgegevens worden verkregen door te koppelen aan jouw eduID-account."
TEXT_DATA_NONFORMAL_LEGITIMATE_EN="\n\n# 3 Personal data\n\nFor issuing edubadges, there are three forms of processing:\n\n1. Registering for an edubadge\n2. Creating the edubadge\n3. Sending the edubadge\n\nIn the table below are the personal data (with purpose and basis) that are processed when registering for an edubadge, when the edubadge is created and when the edubadge is send to the recipient. This personal data is obtained by linking to the user his/her eduID account."
TEXT_DATA_NONFORMAL_CONTRACT_NL="\n\n# 3 Persoonsgegevens\n\nVoor de uitgifte van edubadges zijn drie verwerkingen relevant:\n\n1. Registreren voor een edubadge\n2. Het aanmaken van een edubadge\n3. Het verzenden van een edubadge\n\nIn de onderstaande tabel staan de persoonsgegevens (met doel en grondslag) die worden verwerkt als jij een edubadge aanvraagt, wanneer de edubadge gemaakt wordt en wanneer de edubadge verzonden wordt. Deze persoonsgegevens worden verkregen door te koppelen aan jouw eduID-account."
TEXT_DATA_NONFORMAL_CONTRACT_EN="\n\n# 3 Personal data\n\nFor issuing edubadges, there are three forms of processing:\n\n1. Registering for an edubadge\n2. Creating the edubadge\n3. Sending the edubadge\n\nIn the table below are the personal data (with purpose and basis) that are processed when registering for an edubadge, when the edubadge is created and when the edubadge is send to the recipient. This personal data is obtained by linking to the user his/her eduID account."
TEXT_DATA_NONFORMAL_OBLIGATIONS_NL=''
TEXT_DATA_NONFORMAL_OBLIGATIONS_EN=''

TEXT_DATA_FORMAL_LEGITIMATE_NL="\n\n# 3 Persoonsgegevens\n\nVoor de uitgifte van edubadges zijn drie verwerkingen relevant:\n\n1. Registreren voor een edubadge\n2. Het aanmaken van een edubadge\n3. Het verzenden van een edubadge\n\nIn de onderstaande tabel staan de persoonsgegevens (met doel en grondslag) die worden verwerkt als jij een edubadge aanvraagt, wanneer de edubadge gemaakt wordt en wanneer de edubadge verzonden wordt. Deze persoonsgegevens worden verkregen door te koppelen aan jouw eduID-account."
TEXT_DATA_FORMAL_LEGITIMATE_EN="\n\n# 3 Personal data\n\nFor issuing edubadges, there are three forms of processing:\n\n1. Registering for an edubadge\n2. Creating the edubadge\n3. Sending the edubadge\n\nIn the table below are the personal data (with purpose and basis) that are processed when registering for an edubadge, when the edubadge is created and when the edubadge is send to the recipient. This personal data is obtained by linking to the user his/her eduID account."
TEXT_DATA_FORMAL_CONTRACT_NL="\n\n# 3 Persoonsgegevens\n\nVoor de uitgifte van edubadges zijn drie verwerkingen relevant:\n\n1. Registreren voor een edubadge\n2. Het aanmaken van een edubadge\n3. Het verzenden van een edubadge\n\nIn de onderstaande tabel staan de persoonsgegevens (met doel en grondslag) die worden verwerkt als jij een edubadge aanvraagt, wanneer de edubadge gemaakt wordt en wanneer de edubadge verzonden wordt. Deze persoonsgegevens worden verkregen door te koppelen aan jouw eduID-account."
TEXT_DATA_FORMAL_CONTRACT_EN="\n\n# 3 Personal data\n\nFor issuing edubadges, there are three forms of processing:\n\n1. Registering for an edubadge\n2. Creating the edubadge\n3. Sending the edubadge\n\nIn the table below are the personal data (with purpose and basis) that are processed when registering for an edubadge, when the edubadge is created and when the edubadge is send to the recipient. This personal data is obtained by linking to the user his/her eduID account."
TEXT_DATA_FORMAL_OBLIGATIONS_NL=''
TEXT_DATA_FORMAL_OBLIGATIONS_EN=''

TEXT_TABLE_NONFORMAL_LEGITIMATE_NL="\n\n| Persoonsgegeven | Doel | Grondslag |\n| --------------- | ---- | --------- |\n| eduID | Pseudonieme identifier in edubadge | Gerechtvaardigd belang |\n| Voornaam | Identificatie van gebruiker | Gerechtvaardigd belang |\n| Achternaam | Identificatie van gebruiker | Gerechtvaardigd belang |\n| E-mailadres | Notificeren van gebruiker | Gerechtvaardigd belang |\n| Onderwijsinstelling | Afbakening beschikbare edubadges | Gerechtvaardigd belang |\n| Privacyinteractie | Of er akkoord is gegaan met Gebruiksvoorwaarden | Gerechtvaardigd belang |"
TEXT_TABLE_NONFORMAL_LEGITIMATE_EN="\n\n| Personal data	| Purpose	| Basis |\n| ------------- | ------- | ----- |\n| eduID	| Pseudonym identifier in edubadge | Legitimate interest |\n| Given name(s) | User identification | Legitimate interest |\n| Surname	| User identification	| Legitimate interest |\n| Email address	| User Notification	| Legitimate interest |\n| Educational institution | Demarcation of available edubadges |	Legitimate interest |\n| Privacy interaction	| Whether the privacy statement has been read | Legitimate interest |"
TEXT_TABLE_NONFORMAL_CONTRACT_NL="\n\n| Persoonsgegeven | Doel | Grondslag |\n| --------------- | ---- | --------- |\n| eduID | Pseudonieme identifier in edubadge | Uitvoering overeenkomst |\n| Voornaam | Identificatie van gebruiker | Uitvoering overeenkomst |\n| Achternaam | Identificatie van gebruiker | Uitvoering overeenkomst |\n| E-mailadres | Notificeren van gebruiker | Uitvoering overeenkomst |\n| Scoped affiliation | Afbakening beschikbare edubadges | Uitvoering overeenkomst |\n| Privacyinteractie | Of er akkoord is gegaan met Gebruiksvoorwaarden | Uitvoering overeenkomst |"
TEXT_TABLE_NONFORMAL_CONTRACT_EN="\n\n| Personal data	| Purpose	| Basis |\n| ------------- | ------- | ----- |\n| eduID	| Pseudonym identifier in edubadge | Performance of an agreement |\n| Given name(s) | User identification | Performance of an agreement |\n| Surname	| User identification	| Performance of an agreement |\n| Email address	| User Notification	| Performance of an agreement |\n| Educational institution | Demarcation of available edubadges |	Performance of an agreement |\n| Privacy interaction	| Whether the privacy statement has been read | Performance of an agreement |"
TEXT_TABLE_NONFORMAL_OBLIGATIONS_NL=''
TEXT_TABLE_NONFORMAL_OBLIGATIONS_EN=''

TEXT_TABLE_FORMAL_LEGITIMATE_NL="\n\n| Persoonsgegeven | Doel | Grondslag |\n| --------------- | ---- | --------- |\n| eduID | Pseudonieme identifier in edubadge | Gerechtvaardigd belang |\n| Voornaam | Identificatie van gebruiker | Gerechtvaardigd belang |\n| Achternaam | Identificatie van gebruiker | Gerechtvaardigd belang |\n| E-mailadres | Notificeren van gebruiker | Gerechtvaardigd belang |\n| Onderwijsinstelling | Afbakening beschikbare edubadges | Gerechtvaardigd belang |\n| Privacyinteractie | Of er akkoord is gegaan met Gebruiksvoorwaarden | Gerechtvaardigd belang |"
TEXT_TABLE_FORMAL_LEGITIMATE_EN="\n\n| Personal data	| Purpose	| Basis |\n| ------------- | ------- | ----- |\n| eduID	| Pseudonym identifier in edubadge | Legitimate interest |\n| Given name(s) | User identification | Legitimate interest |\n| Surname	| User identification	| Legitimate interest |\n| Email address	| User Notification	| Legitimate interest |\n| Educational institution | Demarcation of available edubadges |	Legitimate interest |\n| Privacy interaction	| Whether the privacy statement has been read | Legitimate interest |"
TEXT_TABLE_FORMAL_CONTRACT_NL="\n\n| Persoonsgegeven | Doel | Grondslag |\n| --------------- | ---- | --------- |\n| eduID | Pseudonieme identifier in edubadge | Uitvoering overeenkomst |\n| Voornaam | Identificatie van gebruiker | Uitvoering overeenkomst |\n| Achternaam | Identificatie van gebruiker | Uitvoering overeenkomst |\n| E-mailadres | Notificeren van gebruiker | Uitvoering overeenkomst |\n| Scoped affiliation | Afbakening beschikbare edubadges | Uitvoering overeenkomst |\n| Privacyinteractie | Of er akkoord is gegaan met Gebruiksvoorwaarden | Uitvoering overeenkomst |"
TEXT_TABLE_FORMAL_CONTRACT_EN="\n\n| Personal data	| Purpose	| Basis |\n| ------------- | ------- | ----- |\n| eduID	| Pseudonym identifier in edubadge | Performance of an agreement |\n| Given name(s) | User identification | Performance of an agreement |\n| Surname	| User identification	| Performance of an agreement |\n| Email address	| User Notification	| Performance of an agreement |\n| Educational institution | Demarcation of available edubadges |	Performance of an agreement |\n| Privacy interaction	| Whether the privacy statement has been read | Performance of an agreement |"
TEXT_TABLE_FORMAL_OBLIGATIONS_NL=''
TEXT_TABLE_FORMAL_OBLIGATIONS_EN=''

TEXT_PROVIDE_NONFORMAL_LEGITIMATE_NL="\n\n${INSTITUTION_NAME_NL} heeft toegang tot je voornaam, achternaam en e-mailadres. SURF en haar beheerpartnet hebben toegang tot alle persoonsgegevens. De persoonsgegevens worden niet aan andere partijen verstrekt."
TEXT_PROVIDE_NONFORMAL_LEGITIMATE_EN="\n\n${INSTITUTION_NAME_EN} has access to your first name, last name and email address. SURF and its management partner has access to all personal data. The personal data are not provided to other parties."
TEXT_PROVIDE_NONFORMAL_CONTRACT_NL="\n\n${INSTITUTION_NAME_NL} heeft toegang tot je voornaam, achternaam en e-mailadres. SURF en haar beheerpartnet hebben toegang tot alle persoonsgegevens. De persoonsgegevens worden niet aan andere partijen verstrekt."
TEXT_PROVIDE_NONFORMAL_CONTRACT_EN="\n\n${INSTITUTION_NAME_EN} has access to your first name, last name and email address. SURF and its management partner has access to all personal data. The personal data are not provided to other parties."
TEXT_PROVIDE_NONFORMAL_OBLIGATIONS_NL=''
TEXT_PROVIDE_NONFORMAL_OBLIGATIONS_EN=''

TEXT_PROVIDE_FORMAL_LEGITIMATE_NL="\n\n${INSTITUTION_NAME_NL} heeft toegang tot je voornaam, achternaam en e-mailadres. SURF en haar beheerpartnet hebben toegang tot alle persoonsgegevens. De persoonsgegevens worden niet aan andere partijen verstrekt."
TEXT_PROVIDE_FORMAL_LEGITIMATE_EN="\n\n${INSTITUTION_NAME_EN} has access to your first name, last name and email address. SURF and its management partner has access to all personal data. The personal data are not provided to other parties."
TEXT_PROVIDE_FORMAL_CONTRACT_NL="\n\n${INSTITUTION_NAME_NL} heeft toegang tot je voornaam, achternaam en e-mailadres. SURF en haar beheerpartnet hebben toegang tot alle persoonsgegevens. De persoonsgegevens worden niet aan andere partijen verstrekt."
TEXT_PROVIDE_FORMAL_CONTRACT_EN="\n\n${INSTITUTION_NAME_EN} has access to your first name, last name and email address. SURF and its management partner has access to all personal data. The personal data are not provided to other parties."
TEXT_PROVIDE_FORMAL_OBLIGATIONS_NL=''
TEXT_PROVIDE_FORMAL_OBLIGATIONS_EN=''

TEXT_SECURITY_NONFORMAL_LEGITIMATE_NL="\n\n# 4 Beveiliging\n\nOnder andere de volgende beveiligingsmaatregelen zijn getroffen om de persoonsgegevens te beschermen:\n\n* Enkel het persoonsgegeven eduID wordt in de edubadge opgeslagen.\n* Communicatie tussen systemen is versleuteld conform moderne standaarden en best practices.\n* Er heeft een uitgebreide externe security audit (code review en penetration test) voor livegang plaatsgevonden.\n* De dienst edubadges wordt regelmatig geaudit.\n* De toegang tot servers is beveiligd conform moderne beveiligingsstandaarden en best practices.\n* Alle fysieke en virtuele servers en data bevinden zich in SURFdatacentra in Nederland. De dienst edubadges wordt redundant gehost op de SURF-locaties Nikhef en InterXion.\n* Alle besturingssystemen en software worden up-to-date gehouden.\n* De toegang tot de beheerkant van de dienst edubadges is afgeschermd door middel van VPN en geharde configuratie voor de toegang zelf.\n* Er worden dagelijks backups gemaakt van de productieomgeving.\n* Servers, besturingssystemen en/of applicaties zijn beschermd door middel van een restrictieve firewall.\n* Handelingen in het besturingssysteem en handelingen bij de uitgifte van edubadges worden gelogd.\n* De webserver maakt gebruik van een geharde configuratie en security headers conform best practices.\n* De rollen voor medewerkersaccounts in edubadges zijn wat betreft toegang beperkt tot louter relevante persoonsgegevens."
TEXT_SECURITY_NONFORMAL_LEGITIMATE_EN="\n\n# 4 Security\n\nSecurity measures, including the following, have been taken to protect personal data:\n\n* Only the personal data associated with the eduID is stored in the edubadge.\n* Communication between systems is encrypted in accordance with the state of the art and best practices.\n* An extensive independent security audit (code review and penetration testing) took place before the systems went live.\n* The edubadges service will be audited regularly.\n* Access to servers is secured in accordance with the state of the art in security technology, standards and best practices.\n* All physical and virtual servers and data are located in SURF's data centres in the Netherlands. The edubadges service is hosted redundantly at SURF's Nikhef and InterXion locations.\n* All operating systems and software are kept up-to-date.\n* Access to the administration side of the edubadges service is shielded by VPN and a hardened configuration for the access itself.\n* Backups of the production environment are made daily.\n* Servers, operating systems and applications are protected by a restrictive firewall.\n* Actions in the operating system and actions taken to issue edubadges are all logged.\n* The web server uses a hardened configuration and security headers in accordance with best practices.\n* Employee account roles access in edubadges is limited to only the personal data that is relevant to them."
TEXT_SECURITY_NONFORMAL_CONTRACT_NL="\m\n# 4 Beveiliging\n\nOnder andere de volgende beveiligingsmaatregelen zijn getroffen om de persoonsgegevens te beschermen:\n\n* Enkel het persoonsgegeven eduID wordt in de edubadge opgeslagen.\n* Communicatie tussen systemen is versleuteld conform moderne standaarden en best practices.\n* Er heeft een uitgebreide externe security audit (code review en penetration test) voor livegang plaatsgevonden.\n* De dienst edubadges wordt regelmatig geaudit.\n* De toegang tot servers is beveiligd conform moderne beveiligingsstandaarden en best practices.\n* Alle fysieke en virtuele servers en data bevinden zich in SURFdatacentra in Nederland. De dienst edubadges wordt redundant gehost op de SURF-locaties Nikhef en InterXion.\n* Alle besturingssystemen en software worden up-to-date gehouden.\n* De toegang tot de beheerkant van de dienst edubadges is afgeschermd door middel van VPN en geharde configuratie voor de toegang zelf.\n* Er worden dagelijks backups gemaakt van de productieomgeving.\n* Servers, besturingssystemen en/of applicaties zijn beschermd door middel van een restrictieve firewall.\n* Handelingen in het besturingssysteem en handelingen bij de uitgifte van edubadges worden gelogd.\n* De webserver maakt gebruik van een geharde configuratie en security headers conform best practices.\n* De rollen voor medewerkersaccounts in edubadges zijn wat betreft toegang beperkt tot louter relevante persoonsgegevens."
TEXT_SECURITY_NONFORMAL_CONTRACT_EN="\m\n# 4 Security\n\nSecurity measures, including the following, have been taken to protect personal data:\n\n* Only the personal data associated with the eduID is stored in the edubadge.\n* Communication between systems is encrypted in accordance with the state of the art and best practices.\n* An extensive independent security audit (code review and penetration testing) took place before the systems went live.\n* The edubadges service will be audited regularly.\n* Access to servers is secured in accordance with the state of the art in security technology, standards and best practices.\n* All physical and virtual servers and data are located in SURF's data centres in the Netherlands. The edubadges service is hosted redundantly at SURF's Nikhef and InterXion locations.\n* All operating systems and software are kept up-to-date.\n* Access to the administration side of the edubadges service is shielded by VPN and a hardened configuration for the access itself.\n* Backups of the production environment are made daily.\n* Servers, operating systems and applications are protected by a restrictive firewall.\n* Actions in the operating system and actions taken to issue edubadges are all logged.\n* The web server uses a hardened configuration and security headers in accordance with best practices.\n* Employee account roles access in edubadges is limited to only the personal data that is relevant to them."
TEXT_SECURITY_NONFORMAL_OBLIGATIONS_NL=''
TEXT_SECURITY_NONFORMAL_OBLIGATIONS_EN=''

TEXT_SECURITY_FORMAL_LEGITIMATE_NL="\n\n# 4 Beveiliging\n\nOnder andere de volgende beveiligingsmaatregelen zijn getroffen om de persoonsgegevens te beschermen:\n\n* Enkel het persoonsgegeven eduID wordt in de edubadge opgeslagen.\n* Communicatie tussen systemen is versleuteld conform moderne standaarden en best practices.\n* Er heeft een uitgebreide externe security audit (code review en penetration test) voor livegang plaatsgevonden.\n* De dienst edubadges wordt regelmatig geaudit.\n* De toegang tot servers is beveiligd conform moderne beveiligingsstandaarden en best practices.\n* Alle fysieke en virtuele servers en data bevinden zich in SURFdatacentra in Nederland. De dienst edubadges wordt redundant gehost op de SURF-locaties Nikhef en InterXion.\n* Alle besturingssystemen en software worden up-to-date gehouden.\n* De toegang tot de beheerkant van de dienst edubadges is afgeschermd door middel van VPN en geharde configuratie voor de toegang zelf.\n* Er worden dagelijks backups gemaakt van de productieomgeving.\n* Servers, besturingssystemen en/of applicaties zijn beschermd door middel van een restrictieve firewall.\n* Handelingen in het besturingssysteem en handelingen bij de uitgifte van edubadges worden gelogd.\n* De webserver maakt gebruik van een geharde configuratie en security headers conform best practices.\n* De rollen voor medewerkersaccounts in edubadges zijn wat betreft toegang beperkt tot louter relevante persoonsgegevens."
TEXT_SECURITY_FORMAL_LEGITIMATE_EN="\n\n# 4 Security\n\nSecurity measures, including the following, have been taken to protect personal data:\n\n* Only the personal data associated with the eduID is stored in the edubadge.\n* Communication between systems is encrypted in accordance with the state of the art and best practices.\n* An extensive independent security audit (code review and penetration testing) took place before the systems went live.\n* The edubadges service will be audited regularly.\n* Access to servers is secured in accordance with the state of the art in security technology, standards and best practices.\n* All physical and virtual servers and data are located in SURF's data centres in the Netherlands. The edubadges service is hosted redundantly at SURF's Nikhef and InterXion locations.\n* All operating systems and software are kept up-to-date.\n* Access to the administration side of the edubadges service is shielded by VPN and a hardened configuration for the access itself.\n* Backups of the production environment are made daily.\n* Servers, operating systems and applications are protected by a restrictive firewall.\n* Actions in the operating system and actions taken to issue edubadges are all logged.\n* The web server uses a hardened configuration and security headers in accordance with best practices.\n* Employee account roles access in edubadges is limited to only the personal data that is relevant to them."
TEXT_SECURITY_FORMAL_CONTRACT_NL="\n\n# 4 Beveiliging\n\nOnder andere de volgende beveiligingsmaatregelen zijn getroffen om de persoonsgegevens te beschermen:\n\n* Enkel het persoonsgegeven eduID wordt in de edubadge opgeslagen.\n* Communicatie tussen systemen is versleuteld conform moderne standaarden en best practices.\n* Er heeft een uitgebreide externe security audit (code review en penetration test) voor livegang plaatsgevonden.\n* De dienst edubadges wordt regelmatig geaudit.\n* De toegang tot servers is beveiligd conform moderne beveiligingsstandaarden en best practices.\n* Alle fysieke en virtuele servers en data bevinden zich in SURFdatacentra in Nederland. De dienst edubadges wordt redundant gehost op de SURF-locaties Nikhef en InterXion.\n* Alle besturingssystemen en software worden up-to-date gehouden.\n* De toegang tot de beheerkant van de dienst edubadges is afgeschermd door middel van VPN en geharde configuratie voor de toegang zelf.\n* Er worden dagelijks backups gemaakt van de productieomgeving.\n* Servers, besturingssystemen en/of applicaties zijn beschermd door middel van een restrictieve firewall.\n* Handelingen in het besturingssysteem en handelingen bij de uitgifte van edubadges worden gelogd.\n* De webserver maakt gebruik van een geharde configuratie en security headers conform best practices.\n* De rollen voor medewerkersaccounts in edubadges zijn wat betreft toegang beperkt tot louter relevante persoonsgegevens."
TEXT_SECURITY_FORMAL_CONTRACT_EN="\n\n# 4 Security\n\nSecurity measures, including the following, have been taken to protect personal data:\n\n* Only the personal data associated with the eduID is stored in the edubadge.\n* Communication between systems is encrypted in accordance with the state of the art and best practices.\n* An extensive independent security audit (code review and penetration testing) took place before the systems went live.\n* The edubadges service will be audited regularly.\n* Access to servers is secured in accordance with the state of the art in security technology, standards and best practices.\n* All physical and virtual servers and data are located in SURF's data centres in the Netherlands. The edubadges service is hosted redundantly at SURF's Nikhef and InterXion locations.\n* All operating systems and software are kept up-to-date.\n* Access to the administration side of the edubadges service is shielded by VPN and a hardened configuration for the access itself.\n* Backups of the production environment are made daily.\n* Servers, operating systems and applications are protected by a restrictive firewall.\n* Actions in the operating system and actions taken to issue edubadges are all logged.\n* The web server uses a hardened configuration and security headers in accordance with best practices.\n* Employee account roles access in edubadges is limited to only the personal data that is relevant to them."
TEXT_SECURITY_FORMAL_OBLIGATIONS_NL=''
TEXT_SECURITY_FORMAL_OBLIGATIONS_EN=''

TEXT_RIGHTS_NONFORMAL_LEGITIMATE_NL="\n\n# 5 Je rechten met betrekking tot je (persoons)gegevens\n\nJe hebt de volgende rechten met betrekking tot je persoonsgegevens:\n\n* Je kunt een verzoek indienen tot wijziging, aanvulling of verwijdering van je gegevens wanneer deze onjuist of niet (meer) relevant zijn.\n* Je kunt een verzoek indienen om inzage te verkrijgen in de gegevens die we van jou verwerken.\n* Je kunt bezwaar maken tegen verwerking van je gegevens, als we je gegevens verwerken op basis van een eigen gerechtvaardigd belang of op basis van de uitvoering van een taak van algemeen belang.\n* Je kunt een verzoek indienen tot beperking van de verwerking van je gegevens ten aanzien van de verwerking van gegevens waartegen je bezwaar hebt gemaakt, die je onrechtmatig acht, waarvan je de juistheid van de persoonsgegevens hebt betwist of wanneer we de persoonsgegevens niet meer nodig hebben, maar je ze nodig hebt in het kader van een rechtsvordering.\n* Je kunt een overzicht, in een gestructureerde en gangbare vorm opvragen van de gegevens die we van jou verwerken en je hebt het recht op overdraagbaarheid van deze gegevens naar een andere dienstverlener.\n* Als je van mening bent dat wij niet goed omgaan met je persoonsgegevens kun je een klacht indienen bij.\n* Als jij en ${INSTITUTION_NAME_NL} er echter niet samen uitkomen en het antwoord op je klacht niet leidt tot een acceptabel resultaat, heb je het recht om een klacht in te dienen bij de Autoriteit Persoonsgegevens. Meer informatie over de Autoriteit Persoonsgegevens en het indienen van klachten vind je op de [website van de Autoriteit Persoonsgegevens](https://autoriteitpersoonsgegevens.nl).\n\nOm deze rechten uit te kunnen oefenen, kun je contact opnemen met [${PRIVACY_CONTACT}](mailto:${PRIVACY_CONTACT})."
TEXT_RIGHTS_NONFORMAL_LEGITIMATE_EN="\n\n# 5 Your personal data rights\n\nYou have the following rights with regard to your own personal data:\n\n* You may submit a request to modify, supplement or delete your data if it is incorrect or no longer relevant.\n* You may submit a request to access the data about you that we process.\n* You may object to the processing of your data if we process your data on the legal basis of a legitimate interest or the performance of a task in the public interest.\n* You may submit a request to limit the processing of your data in relation to the processing of data which you have objected to, which you consider to be unlawful, whose accuracy you have disputed, or where we no longer need the personal data, but you need it in the context of legal action.\n* You may request an export of the data we process on you, in a structured and common format, and you have the right to portability of this data to another service provider.\n* If you believe that we have not handled your personal data properly, you may submit a complaint.\n\nHowever, if you and ${INSTITUTION_NAME_EN} disagree and the response to your complaint does not lead to an acceptable outcome, you have the right to submit a complaint to the Dutch Data Protection Authority. More information on the Dutch Data Protection Authority and the procedure for submitting complaints can be found on the [website of the Dutch Data Protection Authority](https://autoriteitpersoonsgegevens.nl).\n\nTo exercise these rights, please contact [${PRIVACY_CONTACT}](mailto:${PRIVACY_CONTACT})."
TEXT_RIGHTS_NONFORMAL_CONTRACT_NL="\n\n# 5 Je rechten met betrekking tot je (persoons)gegevens\n\nJe hebt de volgende rechten met betrekking tot je persoonsgegevens:\n\n* Je kunt een verzoek indienen tot wijziging, aanvulling of verwijdering van je gegevens wanneer deze onjuist of niet (meer) relevant zijn.\n* Je kunt een verzoek indienen om inzage te verkrijgen in de gegevens die we van jou verwerken.\n* Je kunt bezwaar maken tegen verwerking van je gegevens, als we je gegevens verwerken op basis van een eigen gerechtvaardigd belang of op basis van de uitvoering van een taak van algemeen belang.\n* Je kunt een verzoek indienen tot beperking van de verwerking van je gegevens ten aanzien van de verwerking van gegevens waartegen je bezwaar hebt gemaakt, die je onrechtmatig acht, waarvan je de juistheid van de persoonsgegevens hebt betwist of wanneer we de persoonsgegevens niet meer nodig hebben, maar je ze nodig hebt in het kader van een rechtsvordering.\n* Je kunt een overzicht, in een gestructureerde en gangbare vorm opvragen van de gegevens die we van jou verwerken en je hebt het recht op overdraagbaarheid van deze gegevens naar een andere dienstverlener.\n* Als je van mening bent dat wij niet goed omgaan met je persoonsgegevens kun je een klacht indienen bij.\n* Als jij en ${INSTITUTION_NAME_NL} er echter niet samen uitkomen en het antwoord op je klacht niet leidt tot een acceptabel resultaat, heb je het recht om een klacht in te dienen bij de Autoriteit Persoonsgegevens. Meer informatie over de Autoriteit Persoonsgegevens en het indienen van klachten vind je op de [website van de Autoriteit Persoonsgegevens](https://autoriteitpersoonsgegevens.nl).\n\nOm deze rechten uit te kunnen oefenen, kun je contact opnemen met [${PRIVACY_CONTACT}](mailto:${PRIVACY_CONTACT})."
TEXT_RIGHTS_NONFORMAL_CONTRACT_EN="\n\n# 5 Your personal data rights\n\nYou have the following rights with regard to your own personal data:\n\n* You may submit a request to modify, supplement or delete your data if it is incorrect or no longer relevant.\n* You may submit a request to access the data about you that we process.\n* You may object to the processing of your data if we process your data on the legal basis of a legitimate interest or the performance of a task in the public interest.\n* You may submit a request to limit the processing of your data in relation to the processing of data which you have objected to, which you consider to be unlawful, whose accuracy you have disputed, or where we no longer need the personal data, but you need it in the context of legal action.\n* You may request an export of the data we process on you, in a structured and common format, and you have the right to portability of this data to another service provider.\n* If you believe that we have not handled your personal data properly, you may submit a complaint.\n\nHowever, if you and ${INSTITUTION_NAME_EN} disagree and the response to your complaint does not lead to an acceptable outcome, you have the right to submit a complaint to the Dutch Data Protection Authority. More information on the Dutch Data Protection Authority and the procedure for submitting complaints can be found on the [website of the Dutch Data Protection Authority](https://autoriteitpersoonsgegevens.nl).\n\nTo exercise these rights, please contact [${PRIVACY_CONTACT}](mailto:${PRIVACY_CONTACT})."
TEXT_RIGHTS_NONFORMAL_OBLIGATIONS_NL=''
TEXT_RIGHTS_NONFORMAL_OBLIGATIONS_EN=''

TEXT_RIGHTS_FORMAL_LEGITIMATE_NL="\n\n# 5 Je rechten met betrekking tot je (persoons)gegevens\n\nJe hebt de volgende rechten met betrekking tot je persoonsgegevens:\n\n* Je kunt een verzoek indienen tot wijziging, aanvulling of verwijdering van je gegevens wanneer deze onjuist of niet (meer) relevant zijn.\n* Je kunt een verzoek indienen om inzage te verkrijgen in de gegevens die we van jou verwerken.\n* Je kunt bezwaar maken tegen verwerking van je gegevens, als we je gegevens verwerken op basis van een eigen gerechtvaardigd belang of op basis van de uitvoering van een taak van algemeen belang.\n* Je kunt een verzoek indienen tot beperking van de verwerking van je gegevens ten aanzien van de verwerking van gegevens waartegen je bezwaar hebt gemaakt, die je onrechtmatig acht, waarvan je de juistheid van de persoonsgegevens hebt betwist of wanneer we de persoonsgegevens niet meer nodig hebben, maar je ze nodig hebt in het kader van een rechtsvordering.\n* Je kunt een overzicht, in een gestructureerde en gangbare vorm opvragen van de gegevens die we van jou verwerken en je hebt het recht op overdraagbaarheid van deze gegevens naar een andere dienstverlener.\n* Als je van mening bent dat wij niet goed omgaan met je persoonsgegevens kun je een klacht indienen bij.\n* Als jij en ${INSTITUTION_NAME_NL} er echter niet samen uitkomen en het antwoord op je klacht niet leidt tot een acceptabel resultaat, heb je het recht om een klacht in te dienen bij de Autoriteit Persoonsgegevens. Meer informatie over de Autoriteit Persoonsgegevens en het indienen van klachten vind je op de [website van de Autoriteit Persoonsgegevens](https://autoriteitpersoonsgegevens.nl).\n\nOm deze rechten uit te kunnen oefenen, kun je contact opnemen met [${PRIVACY_CONTACT}](mailto:${PRIVACY_CONTACT})."
TEXT_RIGHTS_FORMAL_LEGITIMATE_EN="\n\n# 5 Your personal data rights\n\nYou have the following rights with regard to your own personal data:\n\n* You may submit a request to modify, supplement or delete your data if it is incorrect or no longer relevant.\n* You may submit a request to access the data about you that we process.\n* You may object to the processing of your data if we process your data on the legal basis of a legitimate interest or the performance of a task in the public interest.\n* You may submit a request to limit the processing of your data in relation to the processing of data which you have objected to, which you consider to be unlawful, whose accuracy you have disputed, or where we no longer need the personal data, but you need it in the context of legal action.\n* You may request an export of the data we process on you, in a structured and common format, and you have the right to portability of this data to another service provider.\n* If you believe that we have not handled your personal data properly, you may submit a complaint.\n\nHowever, if you and ${INSTITUTION_NAME_EN} disagree and the response to your complaint does not lead to an acceptable outcome, you have the right to submit a complaint to the Dutch Data Protection Authority. More information on the Dutch Data Protection Authority and the procedure for submitting complaints can be found on the [website of the Dutch Data Protection Authority](https://autoriteitpersoonsgegevens.nl).\n\nTo exercise these rights, please contact [${PRIVACY_CONTACT}](mailto:${PRIVACY_CONTACT})."
TEXT_RIGHTS_FORMAL_CONTRACT_NL="\n\n# 5 Je rechten met betrekking tot je (persoons)gegevens\n\nJe hebt de volgende rechten met betrekking tot je persoonsgegevens:\n\n* Je kunt een verzoek indienen tot wijziging, aanvulling of verwijdering van je gegevens wanneer deze onjuist of niet (meer) relevant zijn.\n* Je kunt een verzoek indienen om inzage te verkrijgen in de gegevens die we van jou verwerken.\n* Je kunt bezwaar maken tegen verwerking van je gegevens, als we je gegevens verwerken op basis van een eigen gerechtvaardigd belang of op basis van de uitvoering van een taak van algemeen belang.\n* Je kunt een verzoek indienen tot beperking van de verwerking van je gegevens ten aanzien van de verwerking van gegevens waartegen je bezwaar hebt gemaakt, die je onrechtmatig acht, waarvan je de juistheid van de persoonsgegevens hebt betwist of wanneer we de persoonsgegevens niet meer nodig hebben, maar je ze nodig hebt in het kader van een rechtsvordering.\n* Je kunt een overzicht, in een gestructureerde en gangbare vorm opvragen van de gegevens die we van jou verwerken en je hebt het recht op overdraagbaarheid van deze gegevens naar een andere dienstverlener.\n* Als je van mening bent dat wij niet goed omgaan met je persoonsgegevens kun je een klacht indienen bij.\n* Als jij en ${INSTITUTION_NAME_NL} er echter niet samen uitkomen en het antwoord op je klacht niet leidt tot een acceptabel resultaat, heb je het recht om een klacht in te dienen bij de Autoriteit Persoonsgegevens. Meer informatie over de Autoriteit Persoonsgegevens en het indienen van klachten vind je op de [website van de Autoriteit Persoonsgegevens](https://autoriteitpersoonsgegevens.nl).\n\nOm deze rechten uit te kunnen oefenen, kun je contact opnemen met [${PRIVACY_CONTACT}](mailto:${PRIVACY_CONTACT})."
TEXT_RIGHTS_FORMAL_CONTRACT_EN="\n\n# 5 Your personal data rights\n\nYou have the following rights with regard to your own personal data:\n\n* You may submit a request to modify, supplement or delete your data if it is incorrect or no longer relevant.\n* You may submit a request to access the data about you that we process.\n* You may object to the processing of your data if we process your data on the legal basis of a legitimate interest or the performance of a task in the public interest.\n* You may submit a request to limit the processing of your data in relation to the processing of data which you have objected to, which you consider to be unlawful, whose accuracy you have disputed, or where we no longer need the personal data, but you need it in the context of legal action.\n* You may request an export of the data we process on you, in a structured and common format, and you have the right to portability of this data to another service provider.\n* If you believe that we have not handled your personal data properly, you may submit a complaint.\n\nHowever, if you and ${INSTITUTION_NAME_EN} disagree and the response to your complaint does not lead to an acceptable outcome, you have the right to submit a complaint to the Dutch Data Protection Authority. More information on the Dutch Data Protection Authority and the procedure for submitting complaints can be found on the [website of the Dutch Data Protection Authority](https://autoriteitpersoonsgegevens.nl).\n\nTo exercise these rights, please contact [${PRIVACY_CONTACT}](mailto:${PRIVACY_CONTACT})."
TEXT_RIGHTS_FORMAL_OBLIGATIONS_NL=''
TEXT_RIGHTS_FORMAL_OBLIGATIONS_EN=''

TEXT_CLOSURE_NONFORMAL_LEGITIMATE_NL="\n\n# 6 Wijziging privacyverklaring\n\nEr kunnen wijzigingen worden aangebracht in deze privacyverklaring. We raden je daarom aan om deze privacyverklaring geregeld te raadplegen."
TEXT_CLOSURE_NONFORMAL_LEGITIMATE_EN="\n\n# 6 Amendments to the privacy statement\n\nWe may amend this privacy statement from time to time. We therefore advise you to consult our privacy statement regularly."
TEXT_CLOSURE_NONFORMAL_CONTRACT_NL=''
TEXT_CLOSURE_NONFORMAL_CONTRACT_EN=''
TEXT_CLOSURE_NONFORMAL_OBLIGATIONS_NL=''
TEXT_CLOSURE_NONFORMAL_OBLIGATIONS_EN=''

TEXT_CLOSURE_FORMAL_LEGITIMATE_NL="\n\n# 6 Wijziging privacyverklaring\n\nEr kunnen wijzigingen worden aangebracht in deze privacyverklaring. We raden je daarom aan om deze privacyverklaring geregeld te raadplegen."
TEXT_CLOSURE_FORMAL_LEGITIMATE_EN="\n\n# 6 Amendments to the privacy statement\n\nWe may amend this privacy statement from time to time. We therefore advise you to consult our privacy statement regularly."
TEXT_CLOSURE_FORMAL_CONTRACT_NL=''
TEXT_CLOSURE_FORMAL_CONTRACT_EN=''
TEXT_CLOSURE_FORMAL_OBLIGATIONS_NL=''
TEXT_CLOSURE_FORMAL_OBLIGATIONS_EN=''

################################################################################
# TEXT GENERATION
################################################################################

# excerpt
generate_excerpt_nonformal_legitimate_nl() {
    touch edubadges-nonformal-excerpt-nl.md
    printf "${EXCERPT_TITLE_NONFORMAL_LEGITIMATE_NL}" >> edubadges-nonformal-excerpt-nl.md
    printf "${EXCERPT_PREFACE_NONFORMAL_LEGITIMATE_NL}" >> edubadges-nonformal-excerpt-nl.md
    printf "${EXCERPT_ROLES_NONFORMAL_LEGITIMATE_NL}" >> edubadges-nonformal-excerpt-nl.md
    printf "${EXCERPT_PII_NONFORMAL_LEGITIMATE_NL}" >> edubadges-nonformal-excerpt-nl.md
    printf "${EXCERPT_FOOTER_NONFORMAL_LEGITIMATE_NL}" >> edubadges-nonformal-excerpt-nl.md
}

generate_excerpt_nonformal_legitimate_en() {
    touch edubadges-nonformal-excerpt-en.md
    printf "${EXCERPT_TITLE_NONFORMAL_LEGITIMATE_EN}" >> edubadges-nonformal-excerpt-en.md
    printf "${EXCERPT_PREFACE_NONFORMAL_LEGITIMATE_EN}" >> edubadges-nonformal-excerpt-en.md
    printf "${EXCERPT_ROLES_NONFORMAL_LEGITIMATE_EN}" >> edubadges-nonformal-excerpt-en.md
    printf "${EXCERPT_PII_NONFORMAL_LEGITIMATE_EN}" >> edubadges-nonformal-excerpt-en.md
    printf "${EXCERPT_FOOTER_NONFORMAL_LEGITIMATE_EN}" >> edubadges-nonformal-excerpt-en.md
}

generate_excerpt_nonformal_contract_nl() {
    touch edubadges-nonformal-excerpt-nl.md
    printf "${EXCERPT_TITLE_NONFORMAL_CONTRACT_NL}" >> edubadges-nonformal-excerpt-nl.md
    printf "${EXCERPT_PREFACE_NONFORMAL_CONTRACT_NL}" >> edubadges-nonformal-excerpt-nl.md
    printf "${EXCERPT_ROLES_NONFORMAL_CONTRACT_NL}" >> edubadges-nonformal-excerpt-nl.md
    printf "${EXCERPT_PII_NONFORMAL_CONTRACT_NL}" >> edubadges-nonformal-excerpt-nl.md
    printf "${EXCERPT_FOOTER_NONFORMAL_CONTRACT_NL}" >> edubadges-nonformal-excerpt-nl.md
}

generate_excerpt_nonformal_contract_en() {
    touch edubadges-nonformal-excerpt-en.md
    printf "${EXCERPT_TITLE_NONFORMAL_CONTRACT_EN}" >> edubadges-nonformal-excerpt-en.md
    printf "${EXCERPT_PREFACE_NONFORMAL_CONTRACT_EN}" >> edubadges-nonformal-excerpt-en.md
    printf "${EXCERPT_ROLES_NONFORMAL_CONTRACT_EN}" >> edubadges-nonformal-excerpt-en.md
    printf "${EXCERPT_PII_NONFORMAL_CONTRACT_EN}" >> edubadges-nonformal-excerpt-en.md
    printf "${EXCERPT_FOOTER_NONFORMAL_CONTRACT_EN}" >> edubadges-nonformal-excerpt-en.md
}

generate_excerpt_nonformal_obligation_nl() {
    printf 'n/a'
}

generate_excerpt_nonformal_obligation_en() {
    printf 'n/a'
}

generate_excerpt_formal_legitimate_nl() {
    touch edubadges-formal-excerpt-nl.md
    printf "${EXCERPT_TITLE_FORMAL_LEGITIMATE_NL}" >> edubadges-formal-excerpt-nl.md
    printf "${EXCERPT_PREFACE_FORMAL_LEGITIMATE_NL}" >> edubadges-formal-excerpt-nl.md
    printf "${EXCERPT_ROLES_FORMAL_LEGITIMATE_NL}" >> edubadges-formal-excerpt-nl.md
    printf "${EXCERPT_PII_FORMAL_LEGITIMATE_NL}" >> edubadges-formal-excerpt-nl.md
    printf "${EXCERPT_FOOTER_FORMAL_LEGITIMATE_NL}" >> edubadges-formal-excerpt-nl.md
}

generate_excerpt_formal_legitimate_en() {
    touch edubadges-formal-excerpt-en.md
    printf "${EXCERPT_TITLE_FORMAL_LEGITIMATE_EN}" >> edubadges-formal-excerpt-en.md
    printf "${EXCERPT_PREFACE_FORMAL_LEGITIMATE_EN}" >> edubadges-formal-excerpt-en.md
    printf "${EXCERPT_ROLES_FORMAL_LEGITIMATE_EN}" >> edubadges-formal-excerpt-en.md
    printf "${EXCERPT_PII_FORMAL_LEGITIMATE_EN}" >> edubadges-formal-excerpt-en.md
    printf "${EXCERPT_FOOTER_FORMAL_LEGITIMATE_EN}" >> edubadges-formal-excerpt-en.md
}

generate_excerpt_formal_contract_nl() {
    touch edubadges-formal-excerpt-nl.md
    printf "${EXCERPT_TITLE_FORMAL_CONTRACT_NL}" >> edubadges-formal-excerpt-nl.md
    printf "${EXCERPT_PREFACE_FORMAL_CONTRACT_NL}" >> edubadges-formal-excerpt-nl.md
    printf "${EXCERPT_ROLES_FORMAL_CONTRACT_NL}" >> edubadges-formal-excerpt-nl.md
    printf "${EXCERPT_PII_FORMAL_CONTRACT_NL}" >> edubadges-formal-excerpt-nl.md
    printf "${EXCERPT_FOOTER_FORMAL_CONTRACT_NL}" >> edubadges-formal-excerpt-nl.md
}

generate_excerpt_formal_contract_en() {
    touch edubadges-formal-excerpt-en.md
    printf "${EXCERPT_TITLE_FORMAL_CONTRACT_EN}" >> edubadges-formal-excerpt-en.md
    printf "${EXCERPT_PREFACE_FORMAL_CONTRACT_EN}" >> edubadges-formal-excerpt-en.md
    printf "${EXCERPT_ROLES_FORMAL_CONTRACT_EN}" >> edubadges-formal-excerpt-en.md
    printf "${EXCERPT_PII_FORMAL_CONTRACT_EN}" >> edubadges-formal-excerpt-en.md
    printf "${EXCERPT_FOOTER_FORMAL_CONTRACT_EN}" >> edubadges-formal-excerpt-en.md
}

generate_excerpt_formal_obligation_nl() {
    printf 'n/a'
}

generate_excerpt_formal_obligation_en() {
    printf 'n/a'
}

# text
generate_text_nonformal_legitimate_nl() {
    touch edubadges-nonformal-text-nl.md
    printf "${DATE}" > edubadges-nonformal-text-nl.md
    printf "${TEXT_PREFACE_NONFORMAL_LEGITIMATE_NL}" >> edubadges-nonformal-text-nl.md
    printf "${TEXT_INTRODUCTION_NONFORMAL_LEGITIMATE_NL}" >> edubadges-nonformal-text-nl.md
    printf "${TEXT_PROCESSING_NONFORMAL_LEGITIMATE_NL}" >> edubadges-nonformal-text-nl.md
    printf "${TEXT_DATA_NONFORMAL_LEGITIMATE_NL}" >> edubadges-nonformal-text-nl.md
    printf "${TEXT_TABLE_NONFORMAL_LEGITIMATE_NL}" >> edubadges-nonformal-text-nl.md
    printf "${TEXT_PROVIDE_NONFORMAL_LEGITIMATE_NL}" >> edubadges-nonformal-text-nl.md
    printf "${TEXT_SECURITY_NONFORMAL_LEGITIMATE_NL}" >> edubadges-nonformal-text-nl.md
    printf "${TEXT_RIGHTS_NONFORMAL_LEGITIMATE_NL}" >> edubadges-nonformal-text-nl.md
    printf "${TEXT_CLOSURE_NONFORMAL_LEGITIMATE_NL}" >> edubadges-nonformal-text-nl.md
}

generate_text_nonformal_legitimate_en() {
    touch edubadges-nonformal-text-en.md
    printf "${DATE}" > edubadges-nonformal-text-en.md
    printf "${TEXT_PREFACE_NONFORMAL_LEGITIMATE_EN}" >> edubadges-nonformal-text-en.md
    printf "${TEXT_INTRODUCTION_NONFORMAL_LEGITIMATE_EN}" >> edubadges-nonformal-text-en.md
    printf "${TEXT_PROCESSING_NONFORMAL_LEGITIMATE_EN}" >> edubadges-nonformal-text-en.md
    printf "${TEXT_DATA_NONFORMAL_LEGITIMATE_EN}" >> edubadges-nonformal-text-en.md
    printf "${TEXT_TABLE_NONFORMAL_LEGITIMATE_EN}" >> edubadges-nonformal-text-en.md
    printf "${TEXT_PROVIDE_NONFORMAL_LEGITIMATE_EN}" >> edubadges-nonformal-text-en.md
    printf "${TEXT_SECURITY_NONFORMAL_LEGITIMATE_EN}" >> edubadges-nonformal-text-en.md
    printf "${TEXT_RIGHTS_NONFORMAL_LEGITIMATE_EN}" >> edubadges-nonformal-text-en.md
    printf "${TEXT_CLOSURE_NONFORMAL_LEGITIMATE_EN}" >> edubadges-nonformal-text-en.md
}

generate_text_nonformal_contract_nl() {
    touch edubadges-nonformal-text-nl.md
    printf "${DATE}" > edubadges-nonformal-text-nl.md
    printf "${TEXT_PREFACE_NONFORMAL_CONTRACT_NL}" >> edubadges-nonformal-text-nl.md
    printf "${TEXT_INTRODUCTION_NONFORMAL_CONTRACT_NL}" >> edubadges-nonformal-text-nl.md
    printf "${TEXT_PROCESSING_NONFORMAL_CONTRACT_NL}" >> edubadges-nonformal-text-nl.md
    printf "${TEXT_DATA_NONFORMAL_CONTRACT_NL}" >> edubadges-nonformal-text-nl.md
    printf "${TEXT_TABLE_NONFORMAL_CONTRACT_NL}" >> edubadges-nonformal-text-nl.md
    printf "${TEXT_PROVIDE_NONFORMAL_CONTRACT_NL}" >> edubadges-nonformal-text-nl.md
    printf "${TEXT_SECURITY_NONFORMAL_CONTRACT_NL}" >> edubadges-nonformal-text-nl.md
    printf "${TEXT_RIGHTS_NONFORMAL_CONTRACT_NL}" >> edubadges-nonformal-text-nl.md
}

generate_text_nonformal_contract_en() {
    touch edubadges-nonformal-text-en.md
    printf "${DATE}" > edubadges-nonformal-text-en.md
    printf "${TEXT_PREFACE_NONFORMAL_CONTRACT_EN}" >> edubadges-nonformal-text-en.md
    printf "${TEXT_INTRODUCTION_NONFORMAL_CONTRACT_EN}" >> edubadges-nonformal-text-en.md
    printf "${TEXT_PROCESSING_NONFORMAL_CONTRACT_EN}" >> edubadges-nonformal-text-en.md
    printf "${TEXT_DATA_NONFORMAL_CONTRACT_EN}" >> edubadges-nonformal-text-en.md
    printf "${TEXT_TABLE_NONFORMAL_CONTRACT_EN}" >> edubadges-nonformal-text-en.md
    printf "${TEXT_PROVIDE_NONFORMAL_CONTRACT_EN}" >> edubadges-nonformal-text-en.md
    printf "${TEXT_SECURITY_NONFORMAL_CONTRACT_EN}" >> edubadges-nonformal-text-en.md
    printf "${TEXT_RIGHTS_NONFORMAL_CONTRACT_EN}" >> edubadges-nonformal-text-en.md
}

generate_text_nonformal_obligation_nl() {
    printf 'n/a'
}

generate_text_nonformal_obligation_en() {
    printf 'n/a'
}

generate_text_formal_legitimate_nl() {
    touch edubadges-formal-text-nl.md
    printf "${DATE}" > edubadges-formal-text-nl.md
    printf "${TEXT_PREFACE_FORMAL_LEGITIMATE_NL}" >> edubadges-formal-text-nl.md
    printf "${TEXT_INTRODUCTION_FORMAL_LEGITIMATE_NL}" >> edubadges-formal-text-nl.md
    printf "${TEXT_PROCESSING_FORMAL_LEGITIMATE_NL}" >> edubadges-formal-text-nl.md
    printf "${TEXT_DATA_FORMAL_LEGITIMATE_NL}" >> edubadges-formal-text-nl.md
    printf "${TEXT_TABLE_FORMAL_LEGITIMATE_NL}" >> edubadges-formal-text-nl.md
    printf "${TEXT_PROVIDE_FORMAL_LEGITIMATE_NL}" >> edubadges-formal-text-nl.md
    printf "${TEXT_SECURITY_FORMAL_LEGITIMATE_NL}" >> edubadges-formal-text-nl.md
    printf "${TEXT_RIGHTS_FORMAL_LEGITIMATE_NL}" >> edubadges-formal-text-nl.md
    printf "${TEXT_CLOSURE_FORMAL_LEGITIMATE_NL}" >> edubadges-formal-text-nl.md
}

generate_text_formal_legitimate_en() {
    touch edubadges-formal-text-en.md
    printf "${DATE}" > edubadges-formal-text-en.md
    printf "${TEXT_PREFACE_FORMAL_LEGITIMATE_EN}" >> edubadges-formal-text-en.md
    printf "${TEXT_INTRODUCTION_FORMAL_LEGITIMATE_EN}" >> edubadges-formal-text-en.md
    printf "${TEXT_PROCESSING_FORMAL_LEGITIMATE_EN}" >> edubadges-formal-text-en.md
    printf "${TEXT_DATA_FORMAL_LEGITIMATE_EN}" >> edubadges-formal-text-en.md
    printf "${TEXT_TABLE_FORMAL_LEGITIMATE_EN}" >> edubadges-formal-text-en.md
    printf "${TEXT_PROVIDE_FORMAL_LEGITIMATE_EN}" >> edubadges-formal-text-en.md
    printf "${TEXT_SECURITY_FORMAL_LEGITIMATE_EN}" >> edubadges-formal-text-en.md
    printf "${TEXT_RIGHTS_FORMAL_LEGITIMATE_EN}" >> edubadges-formal-text-en.md
    printf "${TEXT_CLOSURE_FORMAL_LEGITIMATE_EN}" >> edubadges-formal-text-en.md
}

generate_text_formal_contract_nl() {
    touch edubadges-formal-text-nl.md
    printf "${DATE}" > edubadges-formal-text-nl.md
    echo >> edubadges-formal-text-nl.md
    printf "${TEXT_PREFACE_FORMAL_CONTRACT_NL}" >> edubadges-formal-text-nl.md
    printf "${TEXT_INTRODUCTION_FORMAL_CONTRACT_NL}" >> edubadges-formal-text-nl.md
    printf "${TEXT_PROCESSING_FORMAL_CONTRACT_NL}" >> edubadges-formal-text-nl.md
    printf "${TEXT_DATA_FORMAL_CONTRACT_NL}" >> edubadges-formal-text-nl.md
    printf "${TEXT_TABLE_FORMAL_CONTRACT_NL}" >> edubadges-formal-text-nl.md
    printf "${TEXT_PROVIDE_FORMAL_CONTRACT_NL}" >> edubadges-formal-text-nl.md
    printf "${TEXT_SECURITY_FORMAL_CONTRACT_NL}" >> edubadges-formal-text-nl.md
    printf "${TEXT_RIGHTS_FORMAL_CONTRACT_NL}" >> edubadges-formal-text-nl.md
}

generate_text_formal_contract_en() {
    touch edubadges-formal-text-en.md
    printf "${DATE}" > edubadges-formal-text-en.md
    printf "${TEXT_PREFACE_FORMAL_CONTRACT_EN}" >> edubadges-formal-text-en.md
    printf "${TEXT_INTRODUCTION_FORMAL_CONTRACT_EN}" >> edubadges-formal-text-en.md
    printf "${TEXT_PROCESSING_FORMAL_CONTRACT_EN}" >> edubadges-formal-text-en.md
    printf "${TEXT_DATA_FORMAL_CONTRACT_EN}" >> edubadges-formal-text-en.md
    printf "${TEXT_TABLE_FORMAL_CONTRACT_EN}" >> edubadges-formal-text-en.md
    printf "${TEXT_PROVIDE_FORMAL_CONTRACT_EN}" >> edubadges-formal-text-en.md
    printf "${TEXT_SECURITY_FORMAL_CONTRACT_EN}" >> edubadges-formal-text-en.md
    printf "${TEXT_RIGHTS_FORMAL_CONTRACT_EN}" >> edubadges-formal-text-en.md
}

generate_text_formal_obligation_nl() {
    printf 'n/a'
}

generate_text_formal_obligation_en() {
    printf 'n/a'
}

generate_privacy_documenation() {
    # remove old privacy documents
    rm edubadges-nonformal-excerpt-nl.md
    rm edubadges-nonformal-excerpt-en.md
    rm edubadges-formal-excerpt-nl.md
    rm edubadges-formal-excerpt-en.md
    rm edubadges-nonformal-text-nl.md
    rm edubadges-nonformal-text-en.md
    rm edubadges-formal-text-nl.md
    rm edubadges-formal-text-en.md

    # generate nonformal privacy documentation
    if [ ${NONFORMAL_EDUBADGES} = '1' ] && [ ${NONFORMAL_LEGAL_BASIS} = '1' ]; then
        generate_excerpt_nonformal_legitimate_nl
        generate_excerpt_nonformal_legitimate_en
        generate_text_nonformal_legitimate_nl
        generate_text_nonformal_legitimate_en
    elif [ ${NONFORMAL_EDUBADGES} = '1' ] && [ ${NONFORMAL_LEGAL_BASIS} = '2' ]; then
        generate_excerpt_nonformal_contract_nl
        generate_excerpt_nonformal_contract_en
        generate_text_nonformal_contract_nl
        generate_text_nonformal_contract_en
    elif [ ${NONFORMAL_EDUBADGES} = '1' ] && [ ${NONFORMAL_LEGAL_BASIS} = '3' ]; then
        generate_excerpt_nonformal_obligation_nl
        generate_excerpt_nonformal_obligation_en
        generate_text_nonformal_obligation_nl
        generate_text_nonformal_obligation_en
    fi
    # generate formal privacy documentation
    if [ ${FORMAL_EDUBADGES} = '1' ] && [ ${FORMAL_LEGAL_BASIS} = '1' ]; then
        generate_excerpt_formal_legitimate_nl
        generate_excerpt_formal_legitimate_en
        generate_text_formal_legitimate_nl
        generate_text_formal_legitimate_en
    elif [ ${FORMAL_EDUBADGES} = '1' ] && [ ${FORMAL_LEGAL_BASIS} = '2' ]; then
        generate_excerpt_formal_contract_nl
        generate_excerpt_formal_contract_en
        generate_text_formal_contract_nl
        generate_text_formal_contract_en
    elif [ ${FORMAL_EDUBADGES} = '1' ] && [ ${FORMAL_LEGAL_BASIS} = '3' ]; then
        generate_excerpt_formal_obligation_nl
        generate_excerpt_formal_obligation_en
        generate_text_formal_obligation_nl
        generate_text_formal_obligation_en
    fi
}

################################################################################
# MAIN
################################################################################

check_institution_input
generate_privacy_documenation
