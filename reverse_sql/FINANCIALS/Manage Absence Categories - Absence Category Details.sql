/* ****************************************************************************
 * $Revision: 73658 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2020-02-28 13:42:07 +0700 (Fri, 28 Feb 2020) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Absence%20Categories%20-%20Absence%20Category.sql $:
 * $Id: Manage Absence Categories - Absence Category.sql 73658 2020-02-28 06:42:07Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT ancABSENCECATEO.NAME RES_NAME
,ancABSENCECATEO.DESCRIPTION RES_DESCRIPTION
,(SELECT TERRITORY_SHORT_NAME 
	FROM FND_TERRITORIES_VL 
	WHERE TERRITORY_CODE = ancABSENCEO.LEGISLATION_CODE
	) RES_LEGISLATION
,(SELECT MEANING 
	FROM FND_LOOKUP_VALUES 
	WHERE LOOKUP_CODE = ancABSENCEO.STATUS
	AND LOOKUP_TYPE = 'ANC_SETUP_OBJ_STATUS' 
	AND LANGUAGE = USERENV('LANG')
	AND SYSDATE BETWEEN START_DATE_ACTIVE AND NVL(END_DATE_ACTIVE,TO_DATE('4712-12-31','YYYY-MM-DD'))
	) RES_STATUS
,(SELECT MEANING 
	FROM FND_LOOKUP_VALUES 
	WHERE LOOKUP_CODE = ancABSENCEO.MANAGEMENT_TYPE_CD
	AND LOOKUP_TYPE = 'ANC_SETUP_OBJ_MGMT' 
	AND LANGUAGE = USERENV('LANG')
	AND SYSDATE BETWEEN START_DATE_ACTIVE AND NVL(END_DATE_ACTIVE,TO_DATE('4712-12-31','YYYY-MM-DD'))
	) RES_MANAGEMENT
,TO_CHAR(ancABSENCEO.EFFECTIVE_START_DATE,'DD-Mon-YYYY')  RES_EFFECTIVE_START_DATE
,DECODE(TO_CHAR(ancABSENCEO.EFFECTIVE_END_DATE,'DD-MM-YYYY'),'31-12-4712',NULL,TO_CHAR(ancABSENCEO.EFFECTIVE_END_DATE,'DD-Mon-YYYY')) RES_EFFECTIVE_END_DATE	
,ancABSENCEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ancABSENCEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ancABSENCEO.CREATED_BY RSC_CREATED_BY
,ancABSENCEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,ancABSENCEO.LEGISLATION_CODE RSC_COUNTRY_ID
FROM ANC_ABSENCE_CATEGORIES_F_TL ancABSENCECATEO
,ANC_ABSENCE_CATEGORIES_F ancABSENCEO
WHERE ancABSENCECATEO.ABSENCE_CATEGORY_ID = ancABSENCEO.ABSENCE_CATEGORY_ID
AND SYSDATE BETWEEN ancABSENCECATEO.EFFECTIVE_START_DATE AND NVL(ancABSENCECATEO.EFFECTIVE_END_DATE,TO_DATE('4712-12-31','YYYY-MM-DD'))
AND SYSDATE BETWEEN ancABSENCEO.EFFECTIVE_START_DATE AND NVL(ancABSENCEO.EFFECTIVE_END_DATE,TO_DATE('4712-12-31','YYYY-MM-DD'))
AND ancABSENCECATEO.LANGUAGE = USERENV('LANG')
ORDER BY ancABSENCECATEO.NAME