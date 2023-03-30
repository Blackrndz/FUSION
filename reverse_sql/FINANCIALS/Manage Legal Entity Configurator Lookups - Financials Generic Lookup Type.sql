/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Legal%20Entity%20Configurator%20Lookups%20-%20Financials%20Generic%20Lookup%20Type.sql $:
* $Id: Manage Legal Entity Configurator Lookups - Financials Generic Lookup Type.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT LOOKUP_TYPE AS RES_LOOKUP_TYPE
,LOOKUP_CODE       AS RES_LOOKUP_CODE
,(SELECT SET_NAME
	FROM FND_SETID_SETS_VL
	WHERE SET_ID = fndlookups.SET_ID
	)                AS RES_REFERENCE_DATA_SET
,DISPLAY_SEQUENCE AS RES_DISPLAY_SEQUENCE
,NVL((SELECT MEANING
	FROM fnd_lookups
	WHERE LOOKUP_TYPE = 'YES_NO'
	AND LOOKUP_CODE   = ENABLED_FLAG
	),'No')                                        AS RES_ENABLED
,TO_CHAR(START_DATE_ACTIVE,'DD-Mon_YYYY') AS RES_START_DATE
,TO_CHAR(END_DATE_ACTIVE,'DD-Mon_YYYY')   AS RES_END_DATE
,MEANING                                  AS RES_MEANING
,DESCRIPTION                              AS RES_DESCRIPTION
,fndlookups.TAG                           AS RES_TAG
,fndlookups.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,fndlookups.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,fndlookups.CREATED_BY RSC_CREATED_BY
,fndlookups.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_LOOKUP_VALUES_VL fndlookups
WHERE fndlookups.LOOKUP_TYPE IN
	(SELECT LOOKUP_TYPE
	FROM FND_LOOKUP_TYPES_VL
	WHERE MODULE_ID IN
		(SELECT MODULE_ID
		FROM FND_APPL_TAXONOMY_VL
		WHERE MODULE_NAME LIKE '%FinLe%'
		AND IS_SEED_DATA_ALLOWED = 'Y'
		)
	)
UNION
SELECT LOOKUP_TYPE AS RES_LOOKUP_TYPE
,LOOKUP_CODE       AS RES_LOOKUP_CODE
,(SELECT SET_NAME
	FROM FND_SETID_SETS_VL
	WHERE SET_ID = fndlookups.SET_ID
	)                AS RES_REFERENCE_DATA_SET
,DISPLAY_SEQUENCE AS RES_DISPLAY_SEQUENCE
,(SELECT MEANING
	FROM fnd_lookups
	WHERE LOOKUP_TYPE = 'YES_NO'
	AND LOOKUP_CODE   = ENABLED_FLAG
	)                                        AS RES_ENABLED
,TO_CHAR(START_DATE_ACTIVE,'DD-Mon_YYYY') AS RES_START_DATE
,TO_CHAR(END_DATE_ACTIVE,'DD-Mon_YYYY')   AS RES_END_DATE
,MEANING                                  AS RES_MEANING
,DESCRIPTION                              AS RES_DESCRIPTION
,fndlookups.TAG                           AS RES_TAG
,fndlookups.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,fndlookups.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,fndlookups.CREATED_BY RSC_CREATED_BY
,fndlookups.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_LOOKUP_VALUES_VL fndlookups
WHERE fndlookups.LOOKUP_TYPE IN
	(SELECT LOOKUP_TYPE
	FROM FND_LOOKUP_TYPES_VL
	WHERE MODULE_ID = '47110F64AC1508E2E040449823C60DB6'
	)
ORDER BY RES_LOOKUP_TYPE