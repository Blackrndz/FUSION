/* ****************************************************************************
 * $Revision: 78239 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 22:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Absence%20Types%20-%20Absence%20Types.sql $:
 * $Id: Manage Absence Types - Absence Types.sql 78239 2022-04-07 15:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=ANC_ABSENCE_TYPES_VL

SELECT ancABSENTYPEEO.NAME RES_NAME
,(SELECT TERRITORY_SHORT_NAME 
	FROM FND_TERRITORIES_TL 
	WHERE LANGUAGE = USERENV('LANG')
	AND TERRITORY_CODE = ancABSENTYPEEO.LEGISLATION_CODE
	) RES_LEGISLATION
,(SELECT NAME 
	FROM PER_LEGISLATIVE_DATA_GROUPS_TL 
	WHERE LANGUAGE = USERENV('LANG')
	AND LEGISLATIVE_DATA_GROUP_ID = ancABSENTYPEEO.LEGISLATIVE_DATA_GROUP_ID
	) RES_LEGISLATIVE_DATA_GROUP
,ancABSENTYPEEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ancABSENTYPEEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ancABSENTYPEEO.CREATED_BY RSC_CREATED_BY
,ancABSENTYPEEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,ancABSENTYPEEO.LEGISLATION_CODE RSC_COUNTRY_ID

FROM ANC_ABSENCE_TYPES_VL ancABSENTYPEEO
WHERE SYSDATE BETWEEN ancABSENTYPEEO.EFFECTIVE_START_DATE AND NVL(ancABSENTYPEEO.EFFECTIVE_END_DATE,TO_DATE('4712-12-31','YYYY-MM-DD'))
ORDER BY ancABSENTYPEEO.NAME