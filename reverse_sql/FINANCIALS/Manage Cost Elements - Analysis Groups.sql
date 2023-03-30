/* ****************************************************************************
 * $Revision: 55453 $:
 * $Author: dhara.pithadiya $:
 * $Date: 2016-05-25 18:43:01 +0700 (Wed, 25 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20AutoInvoice%20Line%20Ordering%20Rules%20-%20AutoInvoice%20Line%20Ordering%20Rules.sql $:
 * $Id: Manage AutoInvoice Line Ordering Rules - AutoInvoice Line Ordering Rules.sql 55453 2016-05-25 11:43:01Z dhara.pithadiya $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 
SELECT CostElementPEO.COST_ELEMENT_CODE RES_COST_ELEMENT
,(SELECT SET_NAME
	FROM FND_SETID_SETS_VL
	WHERE SET_ID = CostElementPEO.SET_ID
	) RES_COST_ELEMENT_SET
,AnalysisGroupPEO.ANALYSIS_GROUP_CODE RES_ANALYSIS_GROUP
,AnalysisCodePEO.ANALYSIS_CODE RES_ANALYSIS_CODE
,ElementAnalysisGroupEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ElementAnalysisGroupEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ElementAnalysisGroupEO.CREATED_BY RSC_CREATED_BY
,ElementAnalysisGroupEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,CostElementPEO.INV_ORG_ID RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM CST_COST_ELEMENTS_VL CostElementPEO
,CST_ELEMENT_ANALYSIS_GROUPS ElementAnalysisGroupEO
,CST_ANALYSIS_GROUPS_VL AnalysisGroupPEO
,CST_ANALYSIS_CODES_VL AnalysisCodePEO
WHERE ElementAnalysisGroupEO.ANALYSIS_GROUP_ID = AnalysisGroupPEO.ANALYSIS_GROUP_ID
AND ElementAnalysisGroupEO.ANALYSIS_ID         = AnalysisCodePEO.ANALYSIS_ID
AND ElementAnalysisGroupEO.COST_ELEMENT_ID     = CostElementPEO.COST_ELEMENT_ID
ORDER BY CostElementPEO.COST_ELEMENT_CODE
,AnalysisGroupPEO.ANALYSIS_GROUP_CODE
,AnalysisCodePEO.ANALYSIS_CODE