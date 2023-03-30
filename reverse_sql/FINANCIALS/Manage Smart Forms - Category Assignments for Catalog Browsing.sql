/* ****************************************************************************
 * $Revision: 60928 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-02-06 17:14:01 +0700 (Mon, 06 Feb 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Complete%20Primary%20to%20Secondary%20Ledger%20Mapping%20-%20Journal%20Conversion%20Rules.sql $:
 * $Id: Complete Primary to Secondary Ledger Mapping - Journal Conversion Rules.sql 60928 2017-02-06 10:14:01Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT (SELECT BU_NAME
	FROM FUN_ALL_BUSINESS_UNITS_V
	WHERE BU_ID = smartFormsE0.PRC_BU_ID
	) RES_PROCUREMENT_BU
,smartFormsE0.SMART_FORM_NAME RES_SMART_FORM
,(CASE
	WHEN catalogoryAssE0.TYPE = 'BROWSING' THEN
		(SELECT CATEGORY_NAME
			FROM POR_BROWSE_CATEGORIES_VL
			WHERE CATEGORY_ID = catalogoryAssE0.CATEGORY_ID)
	WHEN catalogoryAssE0.TYPE = 'PURCHASING' THEN
		(SELECT CATEGORY_NAME
			FROM EGP_CATEGORIES_VL
			WHERE CATEGORY_ID = catalogoryAssE0.CATEGORY_ID)
	END) RES_CATEGORY_NAME
,(CASE
	WHEN catalogoryAssE0.TYPE = 'BROWSING' THEN
		(SELECT CATEGORY_DESCRIPTION
			FROM POR_BROWSE_CATEGORIES_VL
			WHERE CATEGORY_ID = catalogoryAssE0.CATEGORY_ID)
	WHEN catalogoryAssE0.TYPE = 'PURCHASING' THEN
		(SELECT DESCRIPTION
			FROM EGP_CATEGORIES_VL
			WHERE CATEGORY_ID = catalogoryAssE0.CATEGORY_ID)
	END) RES_DESCRIPTION
,(SELECT MEANING FROM FND_LOOKUPS WHERE LOOKUP_CODE = catalogoryAssE0.TYPE 
	AND LOOKUP_TYPE = 'POR_CATEGORY_TYPES') RES_TYPE
,catalogoryAssE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,catalogoryAssE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,catalogoryAssE0.CREATED_BY RSC_CREATED_BY
,catalogoryAssE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,smartFormsE0.PRC_BU_ID RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM POR_SMART_FORMS_ALL_VL smartFormsE0
,POR_SMART_FORM_CAT_ASSIGNMENTS catalogoryAssE0
WHERE smartFormsE0.SMART_FORM_ID = catalogoryAssE0.SMART_FORM_ID
ORDER BY 1,2,3