/* ****************************************************************************
 * $Revision: 49069 $:
 * $Author: Pisan.Jariyasettachok $:
 * $Date: 2015-09-01 17:23:38 +0700 (Tue, 01 Sep 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Facility%20Shifts%20-%20Manage%20Shifts.sql $:
 * $Id: Manage Facility Shifts - Manage Shifts.sql 49069 2015-09-01 10:23:38Z Pisan.Jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=PJF_IND_COST_CODES
 
SELECT bcCodesE0.IND_COST_CODE RES_BURDEN_COST_CODE
,bcCodesE0.DESCRIPTION RES_DESCRIPTION
,(SELECT EXPENDITURE_TYPE_NAME
	FROM PJF_EXP_TYPES_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND EXPENDITURE_TYPE_ID = bcCodesE0.EXPENDITURE_TYPE_ID 
	) RES_EXPENDITURE_TYPE
,DECODE(bcCodesE0.REPORT_DIRECT_FLAG,'Y','Yes','No') RES_REPORT_AS_DIRECT_COST
,TO_CHAR(bcCodesE0.START_DATE_ACTIVE,'DD-Mon-YYYY') RES_FROM_DATE
,TO_CHAR(bcCodesE0.END_DATE_ACTIVE,'DD-Mon-YYYY') RES_TO_DATE
,bcCodesE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,bcCodesE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,bcCodesE0.CREATED_BY  RSC_CREATED_BY
,bcCodesE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_IND_COST_CODES bcCodesE0
ORDER BY bcCodesE0.IND_COST_CODE