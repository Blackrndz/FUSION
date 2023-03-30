/* ****************************************************************************
* $Revision: 78239 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 22:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/
FINANCIALS/Manage%20Server%20Configurations%20-%20Manage%20Data%20Quality%20Server%20Configurations.sql $:
* $Id: Manage Server Configurations - Manage Data Quality Server Configurations.sql 55345 2016-05-23 05:42:33Z
wuttipong.thongvises $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT ffFORMULAEO.FORMULA_NAME RES_FORMULA_NAME
,(SELECT NAME 
	FROM PER_LEGISLATIVE_DATA_GROUPS_TL 
	WHERE LEGISLATIVE_DATA_GROUP_ID = ffFORMULAEO.LEGISLATIVE_DATA_GROUP_ID 
	AND LANGUAGE = USERENV('LANG')
	) RES_LEGISLATIVE_DATA_GROUP
,ffFORMULAEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,ffFORMULAEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,ffFORMULAEO.CREATED_BY  RSC_CREATED_BY
,ffFORMULAEO.CREATION_DATE  RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,(SELECT LEGISLATION_CODE 
	FROM PER_LEGISLATIVE_DATA_GROUPS 
	WHERE LEGISLATIVE_DATA_GROUP_ID = ffFORMULAEO.LEGISLATIVE_DATA_GROUP_ID 
	) RSC_COUNTRY_ID
FROM FF_FORMULAS_VL ffFORMULAEO
WHERE SYSDATE BETWEEN ffFORMULAEO.EFFECTIVE_START_DATE AND NVL(ffFORMULAEO.EFFECTIVE_END_DATE,TO_DATE('4712-12-31','YYYY-MM-DD'))
ORDER BY ffFORMULAEO.FORMULA_NAME 