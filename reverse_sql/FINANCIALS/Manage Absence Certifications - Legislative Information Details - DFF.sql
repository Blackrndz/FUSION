/* ****************************************************************************
 * $Revision: 79346 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2022-09-15 11:40:19 +0700 (Thu, 15 Sep 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Absence%20Certifications%20-%20Legislative%20Information%20Details%20-%20DFF.sql $:
 * $Id: Manage Absence Certifications - Legislative Information Details - DFF.sql 79346 2022-09-15 04:40:19Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=10110##RES##ANC_ABS_CERTIFICATIONS_LEG_DDF
-- DFF_ATTRIBUTES=INFORMATION,INFORMATION_NUMBER,INFORMATION_DATE

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for attributes fields.

SELECT (SELECT NAME FROM ANC_ABS_CERTIFICATIONS_F_TL WHERE ABSENCE_CERTIFICATION_ID = ancABSENCEREO.ABSENCE_CERTIFICATION_ID 
	AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND NVL(EFFECTIVE_END_DATE,TO_DATE('4712-12-31','YYYY-MM-DD'))
	AND LANGUAGE = USERENV('LANG')) RES_NAME
,TO_CHAR(ancABSENCEREO.EFFECTIVE_START_DATE,'DD-Mon-YYYY')  RES_EFFECTIVE_START_DATE
,(SELECT TERRITORY_SHORT_NAME FROM FND_TERRITORIES_VL WHERE TERRITORY_CODE = ancABSENCEREO.LEGISLATION_CODE) RES_LEGISLATION
,ancABSENCEREO.INFORMATION_CATEGORY RES_CONTEXT_CODE
,ancABSENCEREO.INFORMATION1
,ancABSENCEREO.INFORMATION2
,ancABSENCEREO.INFORMATION3
,ancABSENCEREO.INFORMATION4
,ancABSENCEREO.INFORMATION5
,ancABSENCEREO.INFORMATION6
,ancABSENCEREO.INFORMATION7
,ancABSENCEREO.INFORMATION8
,ancABSENCEREO.INFORMATION9
,ancABSENCEREO.INFORMATION10
,ancABSENCEREO.INFORMATION11
,ancABSENCEREO.INFORMATION12
,ancABSENCEREO.INFORMATION13
,ancABSENCEREO.INFORMATION14
,ancABSENCEREO.INFORMATION15
,ancABSENCEREO.INFORMATION16
,ancABSENCEREO.INFORMATION17
,ancABSENCEREO.INFORMATION18
,ancABSENCEREO.INFORMATION19
,ancABSENCEREO.INFORMATION20
,ancABSENCEREO.INFORMATION21
,ancABSENCEREO.INFORMATION22
,ancABSENCEREO.INFORMATION23
,ancABSENCEREO.INFORMATION24
,ancABSENCEREO.INFORMATION25
,ancABSENCEREO.INFORMATION26
,ancABSENCEREO.INFORMATION27
,ancABSENCEREO.INFORMATION28
,ancABSENCEREO.INFORMATION29
,ancABSENCEREO.INFORMATION30
,ancABSENCEREO.INFORMATION_NUMBER1
,ancABSENCEREO.INFORMATION_NUMBER2
,ancABSENCEREO.INFORMATION_NUMBER3
,ancABSENCEREO.INFORMATION_NUMBER4
,ancABSENCEREO.INFORMATION_NUMBER5
,ancABSENCEREO.INFORMATION_NUMBER6
,ancABSENCEREO.INFORMATION_NUMBER7
,ancABSENCEREO.INFORMATION_NUMBER8
,ancABSENCEREO.INFORMATION_NUMBER9
,ancABSENCEREO.INFORMATION_NUMBER10
,ancABSENCEREO.INFORMATION_NUMBER11
,ancABSENCEREO.INFORMATION_NUMBER12
,ancABSENCEREO.INFORMATION_NUMBER13
,ancABSENCEREO.INFORMATION_NUMBER14
,ancABSENCEREO.INFORMATION_NUMBER15
,ancABSENCEREO.INFORMATION_NUMBER16
,ancABSENCEREO.INFORMATION_NUMBER17
,ancABSENCEREO.INFORMATION_NUMBER18
,ancABSENCEREO.INFORMATION_NUMBER19
,ancABSENCEREO.INFORMATION_NUMBER20
, TO_CHAR(ancABSENCEREO.INFORMATION_DATE1, 'DD-Mon-YYYY') INFORMATION_DATE1
, TO_CHAR(ancABSENCEREO.INFORMATION_DATE2, 'DD-Mon-YYYY') INFORMATION_DATE2
, TO_CHAR(ancABSENCEREO.INFORMATION_DATE3, 'DD-Mon-YYYY') INFORMATION_DATE3
, TO_CHAR(ancABSENCEREO.INFORMATION_DATE4, 'DD-Mon-YYYY') INFORMATION_DATE4
, TO_CHAR(ancABSENCEREO.INFORMATION_DATE5, 'DD-Mon-YYYY') INFORMATION_DATE5
, TO_CHAR(ancABSENCEREO.INFORMATION_DATE6, 'DD-Mon-YYYY') INFORMATION_DATE6
, TO_CHAR(ancABSENCEREO.INFORMATION_DATE7, 'DD-Mon-YYYY') INFORMATION_DATE7
, TO_CHAR(ancABSENCEREO.INFORMATION_DATE8, 'DD-Mon-YYYY') INFORMATION_DATE8
, TO_CHAR(ancABSENCEREO.INFORMATION_DATE9, 'DD-Mon-YYYY') INFORMATION_DATE9
, TO_CHAR(ancABSENCEREO.INFORMATION_DATE10, 'DD-Mon-YYYY') INFORMATION_DATE10
, TO_CHAR(ancABSENCEREO.INFORMATION_DATE11, 'DD-Mon-YYYY') INFORMATION_DATE11
, TO_CHAR(ancABSENCEREO.INFORMATION_DATE12, 'DD-Mon-YYYY') INFORMATION_DATE12
, TO_CHAR(ancABSENCEREO.INFORMATION_DATE13, 'DD-Mon-YYYY') INFORMATION_DATE13
, TO_CHAR(ancABSENCEREO.INFORMATION_DATE14, 'DD-Mon-YYYY') INFORMATION_DATE14
, TO_CHAR(ancABSENCEREO.INFORMATION_DATE15, 'DD-Mon-YYYY') INFORMATION_DATE15


,ancABSENCEREO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ancABSENCEREO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ancABSENCEREO.CREATED_BY RSC_CREATED_BY
,ancABSENCEREO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,ancABSENCEREO.LEGISLATION_CODE RSC_COUNTRY_ID

FROM ANC_ABS_CERTIFICATIONS_F ancABSENCEREO
WHERE (ancABSENCEREO.INFORMATION_CATEGORY IS NOT NULL OR
ancABSENCEREO.INFORMATION1 IS NOT NULL OR 
ancABSENCEREO.INFORMATION2 IS NOT NULL OR 
ancABSENCEREO.INFORMATION3 IS NOT NULL OR 
ancABSENCEREO.INFORMATION4 IS NOT NULL OR 
ancABSENCEREO.INFORMATION5 IS NOT NULL OR 
ancABSENCEREO.INFORMATION6 IS NOT NULL OR 
ancABSENCEREO.INFORMATION7 IS NOT NULL OR 
ancABSENCEREO.INFORMATION8 IS NOT NULL OR 
ancABSENCEREO.INFORMATION9 IS NOT NULL OR 
ancABSENCEREO.INFORMATION10 IS NOT NULL OR 
ancABSENCEREO.INFORMATION11 IS NOT NULL OR 
ancABSENCEREO.INFORMATION12 IS NOT NULL OR 
ancABSENCEREO.INFORMATION13 IS NOT NULL OR 
ancABSENCEREO.INFORMATION14 IS NOT NULL OR 
ancABSENCEREO.INFORMATION15 IS NOT NULL OR 
ancABSENCEREO.INFORMATION16 IS NOT NULL OR 
ancABSENCEREO.INFORMATION17 IS NOT NULL OR 
ancABSENCEREO.INFORMATION18 IS NOT NULL OR 
ancABSENCEREO.INFORMATION19 IS NOT NULL OR 
ancABSENCEREO.INFORMATION20 IS NOT NULL OR 
ancABSENCEREO.INFORMATION21 IS NOT NULL OR 
ancABSENCEREO.INFORMATION22 IS NOT NULL OR 
ancABSENCEREO.INFORMATION23 IS NOT NULL OR 
ancABSENCEREO.INFORMATION24 IS NOT NULL OR 
ancABSENCEREO.INFORMATION25 IS NOT NULL OR 
ancABSENCEREO.INFORMATION26 IS NOT NULL OR 
ancABSENCEREO.INFORMATION27 IS NOT NULL OR 
ancABSENCEREO.INFORMATION28 IS NOT NULL OR 
ancABSENCEREO.INFORMATION29 IS NOT NULL OR 
ancABSENCEREO.INFORMATION30 IS NOT NULL OR 
ancABSENCEREO.INFORMATION_NUMBER1 IS NOT NULL OR 
ancABSENCEREO.INFORMATION_NUMBER2 IS NOT NULL OR 
ancABSENCEREO.INFORMATION_NUMBER3 IS NOT NULL OR 
ancABSENCEREO.INFORMATION_NUMBER4 IS NOT NULL OR 
ancABSENCEREO.INFORMATION_NUMBER5 IS NOT NULL OR 
ancABSENCEREO.INFORMATION_NUMBER6 IS NOT NULL OR 
ancABSENCEREO.INFORMATION_NUMBER7 IS NOT NULL OR 
ancABSENCEREO.INFORMATION_NUMBER8 IS NOT NULL OR 
ancABSENCEREO.INFORMATION_NUMBER9 IS NOT NULL OR 
ancABSENCEREO.INFORMATION_NUMBER10 IS NOT NULL OR 
ancABSENCEREO.INFORMATION_NUMBER11 IS NOT NULL OR 
ancABSENCEREO.INFORMATION_NUMBER12 IS NOT NULL OR 
ancABSENCEREO.INFORMATION_NUMBER13 IS NOT NULL OR 
ancABSENCEREO.INFORMATION_NUMBER14 IS NOT NULL OR 
ancABSENCEREO.INFORMATION_NUMBER15 IS NOT NULL OR 
ancABSENCEREO.INFORMATION_NUMBER16 IS NOT NULL OR 
ancABSENCEREO.INFORMATION_NUMBER17 IS NOT NULL OR 
ancABSENCEREO.INFORMATION_NUMBER18 IS NOT NULL OR 
ancABSENCEREO.INFORMATION_NUMBER19 IS NOT NULL OR 
ancABSENCEREO.INFORMATION_NUMBER20 IS NOT NULL OR 
ancABSENCEREO.INFORMATION_DATE1 IS NOT NULL OR 
ancABSENCEREO.INFORMATION_DATE2 IS NOT NULL OR 
ancABSENCEREO.INFORMATION_DATE3 IS NOT NULL OR 
ancABSENCEREO.INFORMATION_DATE4 IS NOT NULL OR 
ancABSENCEREO.INFORMATION_DATE5 IS NOT NULL OR 
ancABSENCEREO.INFORMATION_DATE6 IS NOT NULL OR 
ancABSENCEREO.INFORMATION_DATE7 IS NOT NULL OR 
ancABSENCEREO.INFORMATION_DATE8 IS NOT NULL OR 
ancABSENCEREO.INFORMATION_DATE10 IS NOT NULL OR 
ancABSENCEREO.INFORMATION_DATE11 IS NOT NULL OR 
ancABSENCEREO.INFORMATION_DATE12 IS NOT NULL OR 
ancABSENCEREO.INFORMATION_DATE13 IS NOT NULL OR 
ancABSENCEREO.INFORMATION_DATE14 IS NOT NULL OR 
ancABSENCEREO.INFORMATION_DATE15 IS NOT NULL 
 )
ORDER BY  RES_NAME,ancABSENCEREO.EFFECTIVE_START_DATE