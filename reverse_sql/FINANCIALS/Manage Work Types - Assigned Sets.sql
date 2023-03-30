/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Work%20Types%20-%20Assigned%20Sets.sql $:
* $Id: Manage Work Types - Assigned Sets.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT 	pjfWorkTypeEO.NAME							RES_WORK_TYPE
,(SELECT SET_CODE FROM FND_SETID_SETS
		WHERE SET_ID = pjfWorkTypeSTEO.SET_ID
			AND LANGUAGE = USERENV('LANG'))			RES_CODE
,(SELECT SET_NAME FROM FND_SETID_SETS
		WHERE SET_ID = pjfWorkTypeSTEO.SET_ID
			AND LANGUAGE = USERENV('LANG'))			RES_NAME
,(SELECT DESCRIPTION FROM FND_SETID_SETS
		WHERE SET_ID = pjfWorkTypeSTEO.SET_ID
			AND LANGUAGE = USERENV('LANG'))			RES_DESCRIPTION			
,pjfWorkTypeSTEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,pjfWorkTypeSTEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,pjfWorkTypeSTEO.CREATED_BY  RSC_CREATED_BY
,pjfWorkTypeSTEO.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_WORK_TYPES_VL pjfWorkTypeEO
,PJF_WORK_TYPES_B_ST pjfWorkTypeSTEO
WHERE pjfWorkTypeEO.WORK_TYPE_ID = pjfWorkTypeSTEO.WORK_TYPE_ID
ORDER BY pjfWorkTypeEO.NAME

