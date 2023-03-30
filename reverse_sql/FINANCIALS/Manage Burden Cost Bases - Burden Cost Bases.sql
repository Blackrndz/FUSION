/* ****************************************************************************
 * $Revision: 49069 $:
 * $Author: Pisan.Jariyasettachok $:
 * $Date: 2015-09-01 17:23:38 +0700 (Tue, 01 Sep 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Facility%20Shifts%20-%20Manage%20Shifts.sql $:
 * $Id: Manage Facility Shifts - Manage Shifts.sql 49069 2015-09-01 10:23:38Z Pisan.Jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 
SELECT costBasesE0.COST_BASE RES_COST_BASE
,costBasesE0.DESCRIPTION RES_DESCRIPTION
,costBasesE0.REPORT_SORT_ORDER RES_REPORT_ORDER
,(SELECT MEANING
	FROM FND_LOOKUP_VALUES
	WHERE LANGUAGE = USERENV('LANG')
	AND LOOKUP_TYPE = 'PJF_COST_BASE_TYPE'
	AND LOOKUP_CODE = costBasesE0.COST_BASE_TYPE
	) RES_COST_BASE_TYPE
,TO_CHAR(costBasesE0.START_DATE_ACTIVE,'DD-Mon-YYYY') RES_FROM_DATE
,TO_CHAR(costBasesE0.END_DATE_ACTIVE,'DD-Mon-YYYY') RES_TO_DATE
,costBasesE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,costBasesE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,costBasesE0.CREATED_BY  RSC_CREATED_BY
,costBasesE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_COST_BASES costBasesE0
ORDER BY costBasesE0.REPORT_SORT_ORDER