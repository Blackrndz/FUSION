/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Project%20Class%20Categories%20-%20Assigned%20Sets.sql $:
* $Id: Manage Project Class Categories - Assigned Sets.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT 	pjfClassCategory.CLASS_CATEGORY							RES_NAME
,pjfClassCodeEO.CLASS_CODE										RES_CLASS_NAME
,(SELECT SET_CODE FROM FND_SETID_SETS
		WHERE SET_ID = pjfClassCodeSTEO.SET_ID
			AND LANGUAGE = USERENV('LANG'))						RES_SET_CODE
,(SELECT SET_NAME FROM FND_SETID_SETS
		WHERE SET_ID = pjfClassCodeSTEO.SET_ID
			AND LANGUAGE = USERENV('LANG'))						RES_SET_NAME
,(SELECT DESCRIPTION FROM FND_SETID_SETS
		WHERE SET_ID = pjfClassCodeSTEO.SET_ID
			AND LANGUAGE = USERENV('LANG'))						RES_DESCRIPTION		
,pjfClassCodeSTEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,pjfClassCodeSTEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,pjfClassCodeSTEO.CREATED_BY  RSC_CREATED_BY
,pjfClassCodeSTEO.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_CLASS_CATEGORIES_VL pjfClassCategory
,PJF_CLASS_CODES_VL pjfClassCodeEO
,PJF_CLASS_CODES_B_ST pjfClassCodeSTEO
WHERE pjfClassCategory.CLASS_CATEGORY_ID = pjfClassCodeEO.CLASS_CATEGORY_ID
AND pjfClassCodeEO.CLASS_CODE_ID = pjfClassCodeSTEO.CLASS_CODE_ID
ORDER BY pjfClassCategory.CLASS_CATEGORY ,pjfClassCodeEO.CLASS_CODE		

